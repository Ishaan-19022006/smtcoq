# Tasks
1. Create a Python script to automate the process of a run of the SMTCoq checker on a SMT and proof file.
2. Use the script to run the checker on a set of benchmarks (set of SMT + proof files).

## Debugger
## Contents
- `debugger.py` will eventually contain a Python debugger that automates the manual debugging process that must now occur.
- The `ex1` directory contains a very simple example that demonstrates how the SMTCoq checker works, and how the current debugging process works.

### Example
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
returns `true` for `ex1.smt2` and `ex1.pf`, confirming that the certificate
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

`Verit_Checker` is still a work in progress - sometimes it fails even when we expect it to return `true` (We already know the
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
Python debugger will generate `foodebug.v` given the string `"foo"`
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
  Parse_certif_verit t_i t_func t_atom t_form root used_roots trace
  "ex1.smt2"
  "ex1.pf".
```
The line is common across all debug files except for the two strings that take the 
file names. For `foo` they will be `foo.smt2` and `foo.pf`.

The next few lines are common across debug files (with the few exceptions mentioned below), but the lines that
follow them depend on their (Coq) output.
```
  Definition nclauses := Eval vm_compute in (match trace with Certif a _ _ => a end). (* Size of the state *)
  Print nclauses.
  Definition c := Eval vm_compute in (match trace with Certif _ a _ => a end). (* Certificate *)
  Definition conf := Eval vm_compute in (match trace with Certif _ _ a => a end). (* Look here in the state for the empty clause*)
  Print conf.
  Eval vm_compute in List.length (fst c). (* No. of steps in certificate *)
  (* Sanity check that atoms and formulas are well-typed. Must return true *)
  Eval vm_compute in (Form.check_form t_form && Atom.check_atom t_atom && Atom.wt t_i t_func t_atom).
```

Some of the Coq statements above give some output that we want
to capture in a comment. These are shown below for the specific
example of `ex1`:
```
  ...
  Print nclauses. (* 2 *)
  ...
  Print conf. (* 0 *)
  Eval vm_compute in List.length (fst c). (* No. of steps in certificate*) (* 3 *)
  ...
  Eval vm_compute in (Form.check_form t_form && Atom.check_atom t_atom && Atom.wt t_i t_func t_atom). (* true *)
```
The comments that are added above depend on the output of the
Coq commands that precede them.

These are all Coq commands that can be run on Coqide to see their output. 
The rest of the debug file depends on some of the outputs. So our script
must be able to run Coq commands, parse the Coq output and add the next
lines of the debug file based on this output.
Specifically, on Coqide, when you run the line:
```
Eval vm_compute in List.length (fst c). (* No. of steps in certificate *)
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

The next few lines that define and print the start state are common across debug files 
since all certificates will have a start state.
```
  (* States from c1 *)

  (* Start state *)
  Definition s0 := Eval vm_compute in (add_roots (S.make nclauses) root used_roots).
  Print s0.
```
However, the value of the start state is specific to the proof (certificate) file
being run. This needs to be parsed out of the Coq output.
The following is the Coq output of the `Print` command:
```
s0 = 
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
This is parsed into the comment:
```
(* s0 = {| [4] |} *)
```
The important part of this output is everything to the right of
`PArray.Map.this :=` until the first `;`:
```
PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 0%int63
       (4%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z
```
The rest of the output can be ignored. The above output essentially
says that `s0` contains an *array* of lists - a data structure that 
contains a list at element `0`, one at element `1`, etc.
The above array has only a 0th element - `0%int63` indicates index
`0` of the array and `(4%int63 :: nil)` indicates the list element 
at this index. This is a special way of representing lists.
First of all, all `%int63` should be ignored while parsing.
Coq represents a list `[x; y; z]` as `(x :: y :: z :: nil)`.
We will represent lists inside `[]` and separate the elements
using `;`. We will represent arrays inside `{| |}` and separate
elements using `,`. This finally gives us the array of lists
representing the state of the checker at the beginning of the certificate,
which we store in `s0`: `{| [4] |}`. All of this must be parsed
from the Coq output and be printed onto a comment in the debug file
```
(* s0 = {| [4] |} *)
```
At the end of this, and all blocks that follow (except the last block),
there will be a command that checks what the next step in the 
certificate is:
```
Eval vm_compute in List.nth 0 (fst c) _.
```
Notice that this has `0` after the 0th step, `1` after the
first step, and so on.
The output from Coq for this command is:
```
ImmBuildProj (t_i:=t_i) t_func t_atom t_form 1 0 0
     : step (t_i:=t_i) t_func t_atom t_form
```
The comment at the beginning of the next block is built from
this output:
```
  (* 1. ImmBuildProj 1 0 0 *)
```
The comment begins with a number, which starts at `1` and increases by 
1 for each block. This is followed by the name of the rule used for the 
certificate, in this case `ImmBuildProj` the rest of the comment is
a little hard to parse out. The comment points to a step 
in the certificate. A step can have various forms, all the 
forms are listed in `src/Trace.v` lines 327-372. Each line (except the Coq comment) refers to the form a step can take.
The code from `Trace.v` is presented here with some annotations:
```
Inductive step :=
(* Take 1 integer *)
  | CTrue (pos:int)
  | CFalse (pos:int)

(* Take 2 integers *)
  | BuildDef (pos:int) (l:_lit)
  | BuildDef2 (pos:int) (l:_lit)
  | ImmBuildDef (pos:int) (cid:clause_id)
  | ImmBuildDef2 (pos:int) (cid:clause_id)
  | Res (pos:int) (res:resolution)
  | BBVar (pos:int) (res:_lit)
  | BBConst (pos:int) (res:_lit)
  | BBDiseq (pos:int) (res:_lit)
  | RowEq (pos:int) (res: _lit)  
  | Ext (pos:int) (res: _lit)
  | LiaDiseq (pos:int) (l:_lit)

(* Take 3 integers *)
  | ImmFlatten (pos:int) (cid:clause_id) (lf:_lit)
  | Tautology (pos:int) (cid:clause_id) (l:_lit)
  | BuildProj (pos:int) (l:_lit) (i:int)
  | ImmBuildProj (pos:int) (cid:clause_id) (i:int)
  | SplDistinctElim (pos:int) (orig:clause_id) (res:_lit)
  | BBNot (pos:int) (orig:clause_id) (res:_lit)
  | BBNeg (pos:int) (orig:clause_id) (res:_lit)
  | BBExtract (pos:int) (orig:clause_id) (res:_lit)
  | BBZextend (pos:int) (orig:clause_id) (res:_lit)
  | BBSextend (pos:int) (orig:clause_id) (res:_lit)

(* Take 4 integers *)
  | BBOp (pos:int) (orig1 orig2:clause_id) (res:_lit)
  | BBAdd (pos:int) (orig1 orig2:clause_id) (res:_lit)
  | BBConcat (pos:int) (orig1 orig2:clause_id) (res:_lit)
  | BBMul (pos:int) (orig1 orig2:clause_id) (res:_lit)
  | BBUlt (pos:int) (orig1 orig2:clause_id) (res:_lit)
  | BBSlt (pos:int) (orig1 orig2:clause_id) (res:_lit)
  | BBEq (pos:int) (orig1 orig2:clause_id) (res:_lit)
  | BBShl (pos:int) (orig1 orig2:clause_id) (res:_lit)
  | BBShr (pos:int) (orig1 orig2:clause_id) (res:_lit)

(* Takes integer, list of integers, integer)
  | DistElim (pos:int) (cl:list _lit) (l:_lit)

(* Takes integer, integer, list of integers)
  | EqTr (pos:int) (l:_lit) (fl: list _lit)  
  | Weaken (pos:int) (cid:clause_id) (cl:list _lit)
  
(* Takes integer, integer, list of integer options *)
  | EqCgr (pos:int) (l:_lit) (fl: list (option _lit))

(* Takes integer, integer, integer, list of integer options *)
  | EqCgrP (pos:int) (l1:_lit) (l2:_lit) (fl: list (option _lit))

(* Takes integer, array of integers *)
  | Res (pos:int) (res:resolution)

(* We can ignore these for now; may be combine them, and as soon as you read a step of any of these types, have the 
script print an error message saying this step type is not
supported *)  
  | RowNeq (pos:int) (cl: C.t)
  | LiaMicromega (pos:int) (cl:list _lit) (c:list ZMicromega.ZArithProof)
  | SplArith (pos:int) (orig:clause_id) (res:_lit) (l:list ZMicromega.ZArithProof)
  (* Offer the possibility to discharge parts of the proof to (manual) Coq proofs.
     WARNING: this breaks extraction. *)
  | Hole (pos:int) (prem_id:list clause_id) (prem:list C.t) (concl:C.t)
    (p:interp_conseq_uf (Form.interp_state_var (Atom.interp_form_hatom t_i t_func t_atom) (Atom.interp_form_hatom_bv t_i t_func t_atom) t_form) prem concl)
  | ForallInst (pos:int) (lemma:Prop) (plemma:lemma) (concl:C.t)
    (p: lemma -> interp_conseq_uf (Form.interp_state_var (Atom.interp_form_hatom t_i t_func t_atom) (Atom.interp_form_hatom_bv t_i t_func t_atom) t_form) nil concl)
  .
```
Each step takes a particular number of arguments in some 
order. Above, the rules that take the same number and type
of arguments have been grouped together. The first few
are easy to parse since they take some number of integers.
The more complicated ones take arrays, lists, and option types.
An option type is a regular type that is stored inside another 
type. The only options that you have to deal with here are
integer options. An value of the integer option type is
either `Some n` where `n` can be any integer, or `None`.

The `Eval` command for the step type will be
followed by an empty line for readability.

Then, there will be `n` blocks (where `n` is the number of steps
in the certificate) that look like this:
```
  (* 1. ImmBuildProj 1 0 0 *)
  Definition s1 := Eval vm_compute in (step_checker s0 (List.nth 0 (fst c) (CTrue t_func t_atom t_form 0))).
  Print s1.
  (* s1 = {| [4], [0] |} *)
  Eval vm_compute in List.nth 1 (fst c) _.
```
Again, the `Print` command returns:
```
s1 = 
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
(* s1 = {| [4], [0] |} *)
```
This is followed by a command that tells us what the next step is.

### Proof Certficates
The details of the proof certificates themselves doesn't matter too much - you need to write a debugger given some particular pattern of files. 
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

## Benchmarks

### Thesis Benchmarks
Once the debugger has been tested on small examples such as `ex1`, `ex2`, etc. we can
run it on some real world problems that it was built for in the first place. 
`test6cvc` abd `test8cvc5` are two such examples, but the ones that this debugger 
could really help with are `thesistest1` to `thesistest7`. This new SMTCoq checker was tested on 138 benchmarks and it passed 
on all but 7 of them. These are those 7 benchmarks for which the checker returns 
`false`: if you `cd` into the directory for `thesistestn` and run `coqc thesistestn.v`,
you will see that it returns `false`. We need to use the debug file to figure out 
which part of the certificate checking SMTCoq fails at. These can help us 
better refine our debugger script so that it can find the exact source of failure 
in a large certificate.

Once we successfully use the script on these 7 tests, we can move on to a 
much larger set of benchmarks, as detailed below.

### Larger Benchmarks
The expected behavior of the SMTCoq checker - given a proof certificate 
file (`.pf` file) that correctly justifies the assertions in an SMT file 
(`.smt` file) - is that it returns `true`.

For example, `examples/debuggerIshaan/test1` contains an SMT file (`test1.smt2`) 
and a proof file (`test1/pf`). The `Coq` file (`test1.v`) calls the SMTCoq checker
on these two files. From the `test1` directory, if run `coqc test1.v`, you can 
see that the checker is successful:
```
     = true
     : bool
```

We actually care more about file pairs for which the checker returns `false`. The 
SMTCoq checker is not fully implemented so it might fail on some pairs of files that
we actually expect it to pass on. On such cases, we want to be able to use the Python
debugger to figure out which part of the certificate the checker fails on so we can 
fix it. So the task here is:
1. Run the SMTCoq checker on a set of benchmarks (SMT and proof certificate file pairs).
2. Ignore the benchmarks that pass, ie, SMTCoq returns `true` for them. Focus instead,
on the benchmarks for which SMTCoq returns `false.
3. Run the Python debugger on these files and figure our where they fail. During this task, 
we'll improve on our definition of what it means for a step in a certificate to fail.
Currently, we're just looking for when there is a `[0]` in SMTCoq's state, which is not 
a very refined definition of when things go wrong (sometimes this happens when nothing
has gone wrong).

To make things more complicated, the checker is probably going to fail even before it
can return `true` or `false` on the benchmarks that we try. It's going to give a few errors
because it can't parse the benchmark files. Once we get the specific errors, I can edit 
the parser so that we can eventually get to a place where the checker only returns `true`
or `false` on any of the benchmarks. Then we'll have to go through the above 3 steps.

We'll start with 208 benchmarks (file pairs) that have been uploaded here: https://drive.google.com/file/d/1nX-GyrHnxsvGRv2EONOb1p8dZeqPuFcJ/view?usp=sharing
These file pairs are arbitrarily dispersed into folders that are all under the `QF_UF` folder in this zip file.
Each pair has the following format:
- `<basename>.smt2` is the SMT file
- `<basename>.smt2.proof` is the proof file

For example, `QF_UF/SEQ` contains `SEQ038size7.smt2` and `SEQ038_size7.smt2.proof`. So `<basename>` here 
is `SEQ038size7`.

### Step 1
To run step 1, we need to create a corresponding Coq file (`.v`) file that imports SMTCoq and calls `Verit_Checker`
on the SMT file and the proof file. For the same two files in the example above, if we wanted to create a
Coq file - say `SEQ038_size7.v` in the same directory that contains `QF_UF`, then it would contain this code
to call the SMTCoq checker:
```
Add Rec LoadPath "../../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
  Verit_Checker "QF_UF/SEQ/SEQ038size7.smt2" "QF_UF/SEQ/SEQ038_size7.smt2.proof".
End Benchmark.
```
Note that the `"../../../src" part needs to be adjusted to correctly point to your SMTCoq's `src` directory
from the place in which `coqc` is being called. Clarify if this is confusing.

To complete step 1, you need to create such a `.v` file for every pair of SMT and proof files in the benchmark directory.
It might be best to create all these files in the same directory as `QF_UF` as the example above because we don't
want to pollute the benchmark's file structure with new files.

**Don't do this manually!** Use either Python or bash scripts to automate this process.

### Step 2
Once all the `.v` files have been generated, write another script to run `coqc` on all the `.v` files.
Each one should ideally return a `true/false` value but I might have to make changes to the parser before
we reach that point.

### Step 3
Once we get to a point where we can automatically run the SMTCoq checker on all the benchmark pairs and 
get a `true/false` value, we can filter out the ones that return `false`. These are the ones we 
want to run the Python debugger on (ideally we have fixed the bottleneck by this point so that
each benchmark pair doesn't take 10-20 minutes to run!).

We can now talk about what it means to find the source of the error in these benchmarks and modify the
script to find the thing that we care about.

I can then use that information to fix the SMTCoq checker and ultimately have SMTCoq only return
`true` for all the benchmarks. Once that's done I will actually test it on a truly large benchmark set
(1000s of file pairs).