import subprocess

# Start coqtop as a subprocess with pipes
# Pipes allow the coq output to be captured in python 
coq = subprocess.Popen(
    ["coqtop"],  
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True
)

'''
coq.stdin.write("Add Rec LoadPath ../../src as SMTCoq.\n"
"Require Import SMTCoq.SMTCoq.\n"
"Require Import Bool.\n"
"Require Import Int31.\n"
"Local Open Scope int31_scope.\n")
coq.stdin.flush() #used to immediatly send the command to coqtop

coq.stdin.write("Section ex1debug.\n"
"  Parse_certif_verit t_i t_func t_atom t_form root used_roots trace\n"
"  \"ex1/ex1.smt2\"\n"
"  \"ex1/ex1.pf\".\n"
"End ex1debug.\n")
coq.stdin.flush()

coq.stdin.write("Definition nclauses := Eval vm_compute in (match trace with Certif a _ _ => a end). (* Size of the state *)\n"
  "Print nclauses. (* 2 *) \n")
coq.stdin.flush()

'''
coq.stdin.write("Defintion x := 3.\n")
coq.stdin.flush()

coq.stdin.write("Print x.\n")
coq.stdin.flush()

while True:
    line = coq.stdout.readline()
    if not line:
        break
    print("Coq :", line.strip())
    if " nat " in line:
        break
    




