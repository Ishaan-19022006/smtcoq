#!/bin/zsh

# Purpose: Recursively find and compile all .debug.v files with coqc

ROOT_DIR="/Users/ishaankumar1902/Desktop/smtcoq/examples/debuggerIshaan/QF_UF"
LOG_FILE="/Users/ishaankumar1902/Desktop/smtcoq/examples/debuggerIshaan/coqc_errors.log"

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

