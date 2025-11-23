#!/bin/zsh


 : <<'END_COMMENT'
 This script 
 -recursively processes all .smt2 files and their corresponding .pf proof files in the Thesis_Tests directory
 -creates checker files with smt2.v extension
 -runs coqc on those checker files to check whether they return a true or false
 -if the checker file returns false, it runs TT_debugger.py on the .smt2 and .pf file to generate a debug file with smt2debug.v extension
END_COMMENT




ROOT_DIR="./ex1"

PYTHON_SCRIPT="./debugger.py"
PYTHON_CHECKER="./create_checker.py"

echo "Starting recursive processing from: $ROOT_DIR"
echo "Using Python script: $PYTHON_CHECKER"
echo

# Recursively find all .smt2 files and create the checker files 
find "$ROOT_DIR" -type f -name "*.smt2" | while IFS= read -r smt2_file; do # Finding all .smt2 files in the root directory, 
# IFC= read -r to handle spaces in filenames and read entire filename into 1 variable 
  
  dir=$(dirname "$smt2_file")                     # directory of the .smt2 file
  filename=$(basename "$smt2_file")                 # get the filename
  proof_file="${dir}/${filename/.smt2/.pf}"                 # expected proof filename
  base_no_dot="${filename/.smt2/smt2}"              # base name without .smt2 extension
  output_file="${dir}/${base_no_dot}.v"

  # Check if proof file exists
  if [ -f "$proof_file" ]; then

    # Run the Python checker on the pair
    python3 "$PYTHON_CHECKER" "$smt2_file" "$proof_file" "$output_file"
    

  fi
done


echo "Running Coq checker on generated files..."
echo

find "$ROOT_DIR" -type f -name "*smt2.v" | while IFS= read -r checker_file; do
    echo "Checking: $checker_file"

    # Run coqc and capture all output (stdout + stderr)
    coq_output=$(coqc "$checker_file" 2>&1)

    # Does coqc output contain "true :"?
    if echo "$coq_output" | grep -q "true :"; then
        
        echo " Coq returned TRUE (proof succeeded) "
    
    else
        echo " Coq returned FALSE (proof failed) "
        
        # Extract base name and locate corresponding .smt2 and .pf files
        base=$(basename "$checker_file" .v)   # example: test1smt2
        dir=$(dirname "$checker_file")

        smt2_file="$dir/${base/smt2/.smt2}"
        pf_file="$dir/${base/smt2/.pf}"

        # Debug file output location
        debug_file="$dir/${base}debug.v"

        echo "Running debugger:"
        echo "python3 debugger.py $smt2_file $pf_file $debug_file"
        echo

        python3 "$PYTHON_SCRIPT" "$smt2_file" "$pf_file" "$debug_file"
    fi

    echo "---------------------------------------"
done



