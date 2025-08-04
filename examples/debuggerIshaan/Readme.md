# Contents
- `debugger.py` contains a Python debugger that automates the manual debugging process that must now occur.
- The `ex1` directory contains a very simple example that demonstrates how the SMTCoq checker works, and how the current debugging process works.

# Usage
- To use `debugger.py`, you must first have an existing `.smt2` file and an existing `.pf` file with the same name. 
- For example, if the name of the `.smt2` file is `foo.smt2`, then the `.pf` will be `foo.pf`.
- Please make sure that the names are exactly the same since the filenames are key sensitive. 
- Add these files to the `debuggerIshaan` directory.
- In the terminal change your current directory to `debuggerIshaan`, do this by running 
```
cd smtcoq/examples/debuggerIshaan

``` 
- Once your directory has been changed simply run the `debugger.py` script and add the name of the `.smt2`/`.pf` (for example `foo`) file by running 
```
python3 debugger.py foo

```

# Results
- Running this script will automatically generate a `.v` file in the `debuggerIshaan` directory by the name of `foodebug.v` 
- This will contain an automated debug file with parsed out coq comments which look like this 
```
(*  Print nclauses. *) (* 2 *)

```
- Each coq comment is enclosed in a set of `(*` and `*)`
- Here, the first comment is 
```
(*  Print nclauses. *)

```
this is a line which was already present in the generated debug file and has been ran and commeneted out.
- The second comment is 
```
(* 2 *)

```
this was the output we got from running ` Print nclauses.` and has also been commeneted out.
- In general, all coq comments in the debug file will be in this layout, where the line will have 2 parts. 
-  The first part will be the already ran line in the debug file, and the second part will be the output we got from the first part.  

# Example
-  The `ex1debug.v` file in the `ex1` directory contains a simple debug script to help you understand the current debugging process. 



