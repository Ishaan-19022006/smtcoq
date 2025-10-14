import subprocess
import time 
# Start Coq
coq = subprocess.Popen(
    ["coqtop", "-quiet"],
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    stderr=subprocess.STDOUT,
    text=True,
    bufsize=1
    )

def coq_command(cmd):
    """Send a command to Coq and return the cleaned response."""
    coq.stdin.write(cmd + "\n")
    coq.stdin.flush()
    time.sleep(0.2)

    output_lines = []
    while True:
        line = coq.stdout.readline()
        if not line:
            break
        line = line.strip()
        # Stop reading when Coq shows the prompt again
        if line.startswith("Coq <"):
            break
        if line:  # skip empty lines
            output_lines.append(line)

    # Return the cleaned output
    return "\n".join(output_lines)


'''
print(">>> Definition x := 3.")
print(coq_command("Definition x := 3."))
print("DEBUG OUTPUT:")
print(coq.stdout.read())
print("\n>>> Print x.")
print(coq_command("Print x."))
'''

coq_command("Add Rec LoadPath ../../src as SMTCoq.\n"
"Require Import SMTCoq.SMTCoq.\n"
"Require Import Bool.\n"
"Require Import Int31.\n"
"Local Open Scope int31_scope.\n")


coq_command("Section ex1debug.\n"
"  Parse_certif_verit t_i t_func t_atom t_form root used_roots trace\n"
"  \"ex1/ex1.smt2\"\n"
"  \"ex1/ex1.pf\".\n"
"End ex1debug.\n")


coq_command("Definition nclauses := Eval vm_compute in (match trace with Certif a _ _ => a end). (* Size of the state *)\n"
  "Print nclauses. (* 2 *) \n")