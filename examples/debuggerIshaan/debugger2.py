#Get first command line argument into a string variable
import sys 
import os
import subprocess

i = sys.argv[1]
base_name = os.path.basename(i)
full_name = i + "debug.v"
open(full_name, "w").write(
    "Add Rec LoadPath \"../../src\" as SMTCoq.\n"
    "Require Import SMTCoq.SMTCoq.\n"
    "Require Import Bool. \n" 
    "Require Import Int31. \n"  
    "Local Open Scope int31_scope.\n"
    "\n"
    "Section " + base_name + "debug. \n" 
        "\n"
        " " + "Parse_certif_verit t_i1 t_func1 t_atom1 t_form1 root1 used_roots1 trace1 \n"
        " \"" + i + ".smt2\" \n"
        " \"" + i + ".pf\". \n"
        "\n"
        " " + "Definition nclauses1 := Eval vm_compute in (match trace1 with Certif a _ _ => a end). (* Size of the state *)\n"
        " " + "Print nclauses1.\n"
        
    
    "End " + base_name + "debug. \n"
    )
coqc = subprocess.run(['coqc', full_name], text=True, capture_output=True)
coqcop = coqc.stdout


def parse(output):
    csplit = str.split(output)
    for line in range(0,len(csplit)):
        need = csplit[2] 
        for ch in range(0,len(need)):
            if need[ch]=="%":
                print("(* " + need[0:ch] + " *)")
                break
        break

parse(coqcop)
                  
    


'''
1. Parse from:
nclauses1 = 2%int63
     : int
to:
(* 2 *)
'''

'''
2. Currently, last but one line of ex1debug.v is:
" Print nclauses1."
Replace it with
"(* Print nclauses1. *)"
Then add the comment from 1. to ex1debug.v (into the last but one line)
Most likely, you'll have to use write with r+ mode to do this
'''

'''
3. Then add these lines and repeat the above process:
" Definition c1 := Eval vm_compute in (match trace1 with Certif _ a _ => a end). (* Certificate *)\n"
        " Definition conf1 := Eval vm_compute in (match trace1 with Certif _ _ a => a end). (* Look here in the state for the empty clause*)\n"
        " Print conf1.\n"
'''