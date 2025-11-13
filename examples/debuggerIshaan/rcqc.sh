#Usage: 
#./rcqc.sh <BMarkDirectory>
#where <BMarkDirectory> is the full path of the directory with all the benchmarks reside
#writes all errors from running coqc on the generated debugging files into coqc_errors.log, in the same directory as the script

#Expects <BMarkDirectory> to contain .smt2 and .smt2.proof files and a .debug.v file. 
#Run Benchmarks_ss.sh to create a .debug.v file for every SMT and proof file pair.

#!/bin/zsh

# Purpose: Recursively find and compile all .debug.v files with coqc

ROOT_DIR="/Users/ishaankumar1902/Desktop/smtcoq/examples/debuggerIshaan/QF_UF"
LOG_FILE="./coqc_errors.log"

echo "Starting coqc compilation from: $ROOT_DIR"
echo

echo "" > "$LOG_FILE" # Clear previous log file
# Recursively find all .debug.v files
find "$ROOT_DIR" -type f -name "*debug.v" | while IFS= read -r debug_file; do
  rel_path="${debug_file#$(pwd)/}" # Get relative path for better logging
  # Run coqc on the file
  if coqc "$rel_path" >> /dev/null 2>> "$LOG_FILE"; then # Redirect stdout to /dev/null and stderr to log file
    echo "Success: $rel_path"
  else
    echo "Error: $rel_path"
    echo "File: $rel_path" >> "$LOG_FILE"
  fi

  echo "------------------------------------"
done

