# Contents
- `debugger.py` will eventually contain a Python debugge that automates the manual debugging process that must now occur.
- The `ex1` directory contains a very simple example that demonstrates how the SMTCoq checker works, and how the current debugging process works.

## Example
The `ex1` folder contains all the files needed to run a full example on the
SMT solver-SMTCoq checker pipeline.

SMT solver's prove logical formulas to be unsatisfiable. The input
to the SMT solver is a `.smt2` file. For example `ex1.smt2` asks the 
SMT solver whether the formula `True ^ ~True` is unsatisfiable.
If you run the cvc5 SMT solver on the file from the terminal:
```
cvc5 ex1.smt2
```
cvc5 will return `unsat`, telling you that the formula is unsatisfiable.

Because we want to be able to trust the results of SMT solvers, 
they additionally provide a proof certificate. If you wanted to see
cvc5's proof certificate (in the alethe proof certificate format), 
run it with the following command-line options (options to a program
on the terminal usually start with `--` or `-`):
```
cvc5 ex1.smt2 --dump-proofs --prof-format-mode=alethe --dag-thresh=0
```
cvc5 will return `unsat` and then a proof of unsatisfiability of
the formula (see below for the general structure of these proofs). 
For various reasons, cvc5 returns an unnecessarily complicated proof
for this formula (the one that cvc5 returns is in `ex1cvc5.pf`). 
`ex1.pf` contains a much simpler proof that works just as well.

The proof (`.smt2` file) and proof certificate (`.pf` file) can be 
checked against each other using a proof checker. SMTCoq provides a 
proof checker called `Verit_Checker` which given an SMT file
and a proof certificate file in Alethe, returns `true` if the certificate
proves the unsatisfiability of the formula, and `false` otherwise.

The Coq file `ex1.v` contains a call to SMTCoq's checker on `ex1.smt2`
and `ex1.pf`. To try this out, on the terminal, `cd` to the `ex1` 
directory and run `coqc ex1.v` (this calls the Coq compiler on the `ex1.v`
Coq file, and the code inside the file calls `Verit_Checker`).
```
$ coqc ex1.v
     = true
     : bool
```
The command should give the output shown above, indicating that the checker
returns true for `ex1.smt2` and `ex1.pf`, confirming that the certificate
proves the unsatisfiability of the formula.

The checker can also fail - for example, `ex1wrong.v` uses `ex1.smt2` and
the `ex1wrong.pf` proof certificate file. Clearly, the proof certificate 
is wrong because the last line from the correct certificate has simply 
been removed to create `ex1wrong.pf`. This is why this is the output:
```
$ coqc ex1wrong.v
     = false
     : bool
```

`Verit_Checker` is still a work in progress - sometimes it returns 
`false` even when we expect it to return `true` (We already know the
expected result for the SMT and proof certifcate files that we use, that's
why we can tell that we expect the checker to succeed). In such cases,
we need to be able to tell which step the proof failed in. Currently, the
only way to do that is manually. Such a manual debugging is done
for `ex1` in `ex1debug.v`. The goal of this project is to automatically
generate a file like `ex1debug.v` given for any `.smt2` and `.pf` file 
pair. The following goes in detail through `ex1debug.v` and should help
with automating.

Let's follow this naming convention: for any name `foo`, the SMT file
will be called `foo.smt2`, the proof file will be called `foo.pf`, the 
Coq file that calls `Verit_Checker` will be called `foo.v` and
the Coq file that debugs the checker will be called `foodebug.v`. So the
Python debugger will generate `foodebug.v` given the string "foo"
It will assume that `foo.smt2` and `foo.pf` exist in the same directory
in which `foodebug.v` will be created.

The first few lines are common for all debug files (notice the empty 
line, let's make sure that's in there as well for readability).
```
Add Rec LoadPath "../../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Require Import Int31.
Local Open Scope int31_scope.

```

This is followed by a line that opens a *section*:
```
Section ex1debug
```
Notice that this section is closed at the end of the file
```
End ex1debug.
```
Both the open and close lines containa name for the section - give it 
the same name as the debug file without the `.v` part, so `foodebug`.

Inside the section is where all the debugging occurs. This line 
invokes the SMT and proof files:
```
  Parse_certif_verit t_i1 t_func1 t_atom1 t_form1 root1 used_roots1 trace1
  "ex1.smt2"
  "ex1.pf".
```
It's common for all debug files except for the two strings that take the 
file names. For `foo` they will be `foo.smt2` and `foo.pf`.

The next few lines are common across debug files (with a few exceptions mentioned below), but the lines that
follow them depend on their (Coq) output.
```
  Definition nclauses1 := Eval vm_compute in (match trace1 with Certif a _ _ => a end). (* Size of the state *)
  Print nclauses1.
  Definition c1 := Eval vm_compute in (match trace1 with Certif _ a _ => a end). (* Certificate *)
  Print c1.
  Definition conf1 := Eval vm_compute in (match trace1 with Certif _ _ a => a end). (* Look here in the state for the empty clause*)
  Print conf1.
  Eval vm_compute in List.length (fst c1). (* No. of steps in certificate *)
  (* Sanity check that atoms and formulas are well-typed. Must return true *)
  Eval vm_compute in (Form.check_form t_form1 && Atom.check_atom t_atom1 && Atom.wt t_i1 t_func1 t_atom1).
```

Some of the Coq statements above give some output that we want
to capture in a comment. These are shown below for the specific
example of `ex1`:
```
  ...
  Print c1. (* 2 *)
  ...
  Print conf1. (* 0 *)
  Eval vm_compute in List.length (fst c1). (* No. of steps in certificate = 3 *)
  ...
  Eval vm_compute in (Form.check_form t_form1 && Atom.check_atom t_atom1 && Atom.wt t_i1 t_func1 t_atom1). (* Check passes *)
```
The comments that are added above depend on the output of the
Coq commands that precede them.

These are all Coq commands that can be run on Coqide to see their output. 
The rest of the debug file depends on some of the outputs. So our script
must be able to run Coq commands, parse the Coq output and add the next
lines of the debug file based on this output.
Specifically, on Coqide, when you run the line:
```
Eval vm_compute in List.length (fst c1). (* No. of steps in certificate *)
```
you get output
```
     = 3%nat
     : nat
```
`3` is the number of steps in the certificate (the Coq comment between `(*`
and `*)` tells you as much) and so there will be 4 
consequent blocks in the debug file - 1 to unroll the start state
and 3 to unroll the 3 steps in the certificate.

The next few lines are common across debug files. All certificates will
have a start state.
```
  (* States from c1 *)

  (* Start state *)
  Definition s0_1 := Eval vm_compute in (add_roots (S.make nclauses1) root1 used_roots1).
  Print s0_1.
```
However, the start state is specific to the proof (certificate) file
being run. Again, this needs to be parsed out of the Coq output.
The following is the Coq output of the `Print` command:
```
s0_1 = 
({|
   PArray.Map.this :=
     PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 0%int63
       (4%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z;
   PArray.Map.is_bst :=
     PArray.Map.Raw.Proofs.add_bst 0%int63 
       (4%int63 :: nil)
       (PArray.Map.Raw.Proofs.empty_bst (list int))
 |}, 0%int63 :: nil, 2%int63)
     : PArray.Map.t C.t * C.t * int
```
This is manually parsed into the comment:
```
(* s0_1 = {| [4] |} *)
```
The important part of this output is everything to the right of
`PArray.Map.this :=`:
```
PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 0%int63
       (4%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z;
```
The rest of the output can be ignored. The above output essentially
says that `s0_1` contains an *array* of lists - a data structure that 
contains a list at element `0`, element `1`, etc.
The above array has only a 0th element - `(0%int63)` indicates index
`0` of the array and `(4%int63 :: nil)` indicates the list element 
at this index. This is just a special way of representing lists.
First of all, all `%int63` should be ignored while parsing.
Coq represents a list `[x; y; z]` as `(x :: y :: z :: nil)`.
We will represent lists inside `[]` and separate the elements
using `;`. We will represent arrays inside `{| |}` and separate
elements using `,`. This finally gives us the array of lists
representing the state of the checker at the beginning of the certificate,
which we store in `s0_1`: `{| [4] |}`. All of this must be parsed
from the Coq output and be printed onto a comment in the debug file
```
(* s0_1 = {| [4] |} *)
```
At the end of this, and all blocks that follow (except the last block),
there will be a command that checks what the next step in the 
certificate is:
```
Eval vm_compute in List.nth 0 (fst c1) _.
```
Notice that this has `0` after the 0th step, `1` after the
first step, and so on.
The output from Coq for this command is:
```
ImmBuildProj (t_i:=t_i1) t_func1 t_atom1 t_form1 1 0 0
     : step (t_i:=t_i1) t_func1 t_atom1 t_form1
```
The comment at the beginning of the block is built from
this output:
```
  (* 1. ImmBuildProj 1 0 0 *)
```
The comment begins with a number, which starts at `1` and increases by 
1 for each block. This is followed by the name of the rule used for the 
certificate, in this case `ImmBuildProj` the rest of the comment is
a little hard to parse out, we'll discuss how to correctly do this
when the time comes.

This will be followed by an empty line for readability.

Then, there will be `n` blocks (where `n` is the number of steps
in the certificate) that look like this:
```
  (* 1. ImmBuildProj 1 0 0 *)
  Definition s1_1 := Eval vm_compute in (step_checker s0_1 (List.nth 0 (fst c1) (CTrue t_func1 t_atom1 t_form1 0))).
  Print s1_1.
  (* s1_1 = {| [4], [0] |} *)
  Eval vm_compute in List.nth 1 (fst c1) _.
```
Again, the `Print` command returns:
```
s1_1 = 
({|
   PArray.Map.this :=
     PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 0%int63
       (4%int63 :: nil)
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 1%int63
          (0%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z) 2%Z;
   PArray.Map.is_bst :=
     PArray.Map.Raw.Proofs.add_bst 1%int63 
       (0%int63 :: nil)
       (PArray.Map.Raw.Proofs.add_bst 0%int63 
          (4%int63 :: nil)
          (PArray.Map.Raw.Proofs.empty_bst (list int)))
 |}, 0%int63 :: nil, 2%int63)
     : PArray.Map.t C.t * C.t * int
```
Using the same rules of parsing as above, we get the new state after 
running this step of the certificate:
```
(* s1_1 = {| [4], [0] |} *)
```
This is followed by a command that tells us what the next step is.

## Proofs Certficates
The details of the proof certificates themselves doesn't matter that much - you need to write a debugger given some particular pattern of files. 
This pattern is 
mostly described above. It's okay if you don't understand what the file
is doing as long as you understand what the pattern is and are able to
write code that recognizes these patterns.

Having said that, here's a brief description of a proof certificate. 
The SMT file has one or more logical formulas that are *asserted*.
`ex1.smt1` has one:
```
(assert (and true (not true)))
```
that asserts the formula `True and (not True)`. A proof certificate
starts from all the assertions in the SMT file, and derives the 
empty clause - this is just a logical way to prove things. Each line
in the `.pf` file is a step in the certificate. There is an
`assume` step for each assertion in the SMT file. In this case:
```
(assume a0 (and true (not true)))
```
Each consequent step derives some formula from either a previously
proven formula or a set of predefined formulas. Ultimately,
the certificate derives the empty clause `(cl)`.

`Verit_Checker` takes these steps, often converts them into a much
longer proof with many more steps, while still proving the same thing.
When things go wrong, we are left with 100s or 1000s of steps, and we need
to spot the one step that has an issue. That's what the debugger above does.
