#!/bin/zsh

# Purpose: Recursively process all .smt2 + .smt2.proof pairs inside QF_UF


ROOT_DIR="/Users/ishaankumar1902/Desktop/smtcoq/examples/debuggerIshaan/QF_UF"


PYTHON_SCRIPT="/Users/ishaankumar1902/Desktop/smtcoq/examples/debuggerIshaan/ss_debugger.py"

echo "Starting recursive processing from: $ROOT_DIR"
echo "Using Python script: $PYTHON_SCRIPT"
echo

# Recursively find all .smt2 files
find "$ROOT_DIR" -type f -name "*.smt2" | while IFS= read -r smt2_file; do # Finding all .smt2 files in the root directory, 
# IFC= read -r to handle spaces in filenames and read entire filename into 1 variable 
  
  dir=$(dirname "$smt2_file")                     # directory of the .smt2 file
  filename=$(basename "$smt2_file")                 # get the filename
  proof_file="${smt2_file}.proof"                   # expected proof filename
  base_no_dot="${filename/.smt2/smt2}"              # base name without .smt2 extension
  output_file="${dir}/${base_no_dot}debug.v"

  # Check if proof file exists
  if [ -f "$proof_file" ]; then

    # Run the Python script on the pair
    python3 "$PYTHON_SCRIPT" "$smt2_file" "$proof_file" "$output_file"
    

  fi
done