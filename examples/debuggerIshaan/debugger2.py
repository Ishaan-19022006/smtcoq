#Get first command line argument into a string variable
import sys 
import os
import subprocess

'''
Takes a string - the Coq output
Returns the string parsed into a Coq comment

Ex: takes
nclauses1 = 2%int63
     : int

Returns 
(* 2 *)
'''
def parse_coq_op(coq_op):
    coq_op_lines = str.split(coq_op)
    lines_2 = coq_op_lines[2]
    i_percent = lines_2.index("%")
    num = lines_2[0:i_percent]
    coq_comment = "(* " + num + " *)"
    return coq_comment


'''
Takes a string - the Coq debug file name
Runs coqc on the debug file and returns the output after parsing
    Calls parse() to parse output
'''
def run_coq(fname):
    coqc = subprocess.run(['coqc', fname], text=True, capture_output=True)
    coqcop = coqc.stdout
    return parse_coq_op(coqcop)


'''
    Takes 
    1. a file object pointing to the debug file
    2. an integer - the index of the line to replace
    3. the commented Coq output of the line
    And
    1. Comments the line
    2. Adds a comment with the Coq output

    Ex: takes index of line that contains
     Print nclauses1.
    and the Coq output
    (* 2 *)
    and replaces the line with 
    (*  Print nclauses1. *) (* 2 *)
    Note: for every call, replace copies all lines into a list of string, modifies it, and writes it back
    This might be ineffecient
    TODO: potential site for optimization
    '''
def replace_coql(f, i, coq_op):
    #Get lines from file
    f.seek(0)
    lines = f.readlines()

    #Modify line
    lines[i] = "(* " + lines[i].rstrip() + " *) " + coq_op + "\n"

    #Write lines back to file
    f.seek(0)
    f.writelines(lines)

#Takes file object and returns number of lines in file
def file_length(f):
    f.seek(0)
    return len(f.readlines())


'''
Code to:
1. Create debug file
2. Open and write initial debug code
3. Write initial debug that needs coqc to be run
4. Write iterative debug code that goes through the SMTCoq state while running coqc
5. Close file
'''

#Steps 1. and 2.
i = sys.argv[1]
base_name = os.path.basename(i)
full_name = i + "debug.v"

#Make sure file is empty
with open(full_name, "w") as f:
    f.close()

with open(full_name, "r+") as f:
    f.write(
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
    "End " + base_name + "debug."
    )

    #print(run_coq(full_name))

    #Step 3.
    #TODO: Make this a function
    i = file_length(f) - 2
    coq_op = run_coq(full_name)
    replace_coql(f, i, coq_op)

    #Move cursor to beginning of last line
    #move_cursor_last(f)

    #TODO: Make this a function
    #Note: reading all lines, modifying and then writing all lines. Alternately, we can move the file pointer and then write
    #TODO: potential site for optimization
    f.seek(0)
    lines = f.readlines()
    next_line = "\n " + "Definition c1 := Eval vm_compute in (match trace1 with Certif _ a _ => a end). (* Certificate *)\n" + "Definition conf1 := Eval vm_compute in (match trace1 with Certif _ _ a => a end). (* Look here in the state for the empty clause*)\n" + " " + "Print conf1.\n"
    lines.insert(file_length(f) - 1, next_line)
    f.seek(0)
    f.writelines(lines)

    i = file_length(f) - 2
    coq_op = run_coq(full_name)
    replace_coql(f, i, coq_op)

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