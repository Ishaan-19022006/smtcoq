'''

This script is for working on Polina's Idea.

Goal: Generate the entire debug file and then run the parsing functions on it. 


'''

#Import parse functions
from parse_functions import *

#Get first command line argument into a string variable
import sys 
import os
import subprocess
from enum import Enum
import re

#Enum type to distinguish Coq output types
class Type(Enum):
    BOOL = 1. # Coq Bool
    INT = 2. # Coq Int
    STATE = 3. # Coq State
    STEP = 4 # Coq Step

'''

Takes 1. a string - the Coq debug file name
      2. an instance of the Type enum
Runs coqc on the debug file and returns the output after parsing
    Calls parse_coq_op() to parse output

'''


def run_coqc(fname, t):
    coqc = subprocess.run(['coqc', fname], text=True, capture_output=True)
    coqcop = coqc.stdout

    if (t == Type.BOOL):
        return parse_coq_bool_op(coqcop)
    elif(t == Type.INT):
        return parse_coq_int_op(coqcop)
    elif(t == Type.STATE):
        parsed = parse_state_op(coqcop)
        if check_for_zero(parsed):
            
            parsed += "  (* FLAGGED: contains [0] *)"
            return parsed
        else:
            return parse_state_op(coqcop)
    elif(t == Type.STEP):
            return parse_Step(coqcop)


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

Takes 1. file object 2. Type (Enum)
runs coq file; parses output; comments Coq command 
and adds commented output to file

'''

def run_coq_command(f, t):
    i = file_length(f) - 2
    coq_op = run_coqc(full_name, t)
    replace_coql(f, i, coq_op)


'''

Takes 1. file object 2. Type (Enum)
runs coq file; parses output; returns output as Python type

'''
def run_coq_command_return(f, t):
    i = file_length(f) - 2
    coq_op = run_coqc(full_name, t)
    if(t == Type.INT):
        uncommented_op = coq_op.strip("(* ").strip(" *)")
        return int(uncommented_op)

'''

Takes 1. file object 2. string
Adds string as a line before the last line (that closes the Coq section) of the file
Note: reading all lines, modifying and then writing all lines. Alternately, we can move the file pointer and then write
TODO: potential site for optimization

'''

def add_line(f, next_line):
    f.seek(0)
    lines = f.readlines()
    lines.insert(file_length(f) - 1, next_line)
    f.seek(0)
    f.writelines(lines)
    

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
        " " + "Parse_certif_verit t_i t_func t_atom t_form root used_roots trace \n"
        " \"" + i + ".smt2\" \n"
        " \"" + i + ".pf\". \n"
        "\n"
        " " + "Definition nclauses := Eval vm_compute in (match trace with Certif a _ _ => a end). (* Size of the state *)\n"
        " " + "Print nclauses.\n"
    "End " + base_name + "debug."
    )



    #Step 3.
    #Run Coq commands, capture output in Coq comments
    run_coq_command(f, Type.INT)

    add_line(f, "\n " + " " + "Definition c := Eval vm_compute in (match trace with Certif _ a _ => a end). (* Certificate *)\n" + " " + "Definition conf := Eval vm_compute in (match trace with Certif _ _ a => a end). (* Look here in the state for the empty clause*)\n" + " " + "Print conf.\n")

    run_coq_command(f, Type.INT)

    add_line(f, "\n" + " " + "Eval vm_compute in List.length (fst c). (* No. of steps in certificate *) \n" )

    n = run_coq_command_return(f, Type.INT) #No. of steps in certificate

    run_coq_command(f, Type.INT)

    add_line(f, "\n" + " " +"Eval vm_compute in (Form.check_form t_form && Atom.check_atom t_atom && Atom.wt t_i t_func t_atom). \n")

    run_coq_command(f, Type.BOOL)

    add_line(f, "\n" + " " + "(* States from c *) \n" + "\n" + "(* Start state *) \n")

    add_line(f, "\n" + " " + "Definition s0 := Eval vm_compute in (add_roots (S.make nclauses) root used_roots). \n" + " " + " Print s0. \n")

    run_coq_command(f, Type.STATE)

    for i in range(n):
        add_line(f, "\n" + " " +  "Eval vm_compute in List.nth " + str(i) + " (fst c) _.\n")
        run_coq_command(f, Type.STEP)
        add_line(f, "\n" + " " + "Definition s" + str(i + 1) + " := Eval vm_compute in (step_checker s" + str(i) + " (List.nth " + str(i) + " (fst c) (CTrue t_func t_atom t_form 0))). \n" + " " + "Print s" + str(i + 1) + ". \n")
        run_coq_command(f, Type.STATE)

