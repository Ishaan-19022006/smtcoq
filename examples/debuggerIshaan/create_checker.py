
"""
Script that creates the chcker file of for the given smt2 and pf file
"""

import sys 
import os

i = sys.argv[1]
proof_file = sys.argv[2] # Proof file
full_name = sys.argv[3]  # Output filename (passed in from shell script)



'''

Function that finds the relative path of the required directory 


'''

def make_relative(path):
    # Find where the directory specified in the argument begins
    index = path.find("ex1")
    if index != -1:
        return path[index:]  # keep everything from the directory onward
    else:
        return os.path.basename(path)  # fallback to just filename if not found

i_rel = make_relative(i)
proof_rel = make_relative(proof_file)

#Make sure file is empty
with open(full_name, "w") as f:
    f.close()

with open(full_name, "r+") as f:
    f.write(
    "Add Rec LoadPath \"../../src\" as SMTCoq.\n"
    "Require Import SMTCoq.SMTCoq.\n"
    "Require Import Bool.\n"
    "Section Benchmark.\n"
    "    Verit_Checker \"" + i_rel + "\" \"" + proof_rel + "\".\n"
    "End Benchmark.\n"
    )
