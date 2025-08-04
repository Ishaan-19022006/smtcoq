# Contents
- `debugger.py` contains a Python debugger that automates the manual debugging process that must now occur.
- The `ex1` directory contains a very simple example that demonstrates how the SMTCoq checker works, and how the current debugging process works.

# Usage
- To use `debugger.py`, you must first have an existing `.smt2` file and an existing `.pf` file with the same name. 
- For example, if the name of the `.smt2` file is `foo.smt2`, then the `.pf` will be `foo.pf`.
- Please make sure that the names are exactly the same since the filenames are key sensitive. 
- Add these files to the `debuggerIshaan` folder.
- In the terminal change your current directory to `debuggerIshaan`, do this by running 
```
cd smtcoq/examples/debuggerIshaan

``` 
- Once your directory has been changed simply run the `debugger.py` script and add the name of the `.smt2`/`.pf` (for example `foo`) file by running 
```
python3 debugger.py foo

```

# Results
- Running this script will automatically generate a `.v` file in the `debuggerIshaan` folder by the name of `foodebug.v` 
- This will contain an automated debug file with parsed out coq comments. 



