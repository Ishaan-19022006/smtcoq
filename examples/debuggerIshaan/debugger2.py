#Get first command line argument into a string variable
import sys 
import os
import subprocess
from enum import Enum

#Enum type to distinguish Coq Bools and Coq Ints
class Type(Enum):
    BOOL = 1
    INT = 2


'''

Takes a string that contains a Coq integer
Returns a string just the integer
Ex: takes "0%int63", returns "0"

'''

def parse_int(coq_op):
    l = coq_op.rsplit("%", 1)
    num = l[0]
    return num
    

'''

Takes a string that contains a Coq list
Returns a string with a simplified form of the list
Ex: takes 
(4%int63 :: 0%int63 :: 17%int63 :: nil) IMPORTANT : THIS IS ONE LIST WITH MULTIPLE ELEMNETS IN IT 

returns [4 ; 0 ; 17] 

'''


def parse_multiple_list(state_output):
    new_state = state_output.split("::")
    int_list =  ""
    for item in new_state[:-1]:  
        int_list += parse_int(item) + ";"

    return "[" + int_list[:-1] + "]"


'''

Takes a string that is the the entire coq output and returns a string that is the the coq integer
Ex: Takes
nclauses1 = 2%int63
     : int

Returns
2%int63

'''


def parse_coq_int(coq_op):
    
    after_equal = coq_op.split('=')[1]  
    between = after_equal.split(':')[0]  
    num = between.strip()  
    return num


'''

Takes a string - the Coq output
1. Gets string parsed into a Coq integer 
2. Returns the Coq integer as a number in a Coq comment 

Ex: takes
nclauses1 = 2%int63
     : int

Returns 
(* 2 *)

'''


def parse_coq_int_op(coq_op):
    coq_op_lines = parse_coq_int(coq_op)
    final_num = parse_int(coq_op_lines)
    return "(* " + final_num + " *)"


'''

TODO: Function that takes 0%int63
       (4%int63 :: nil)
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 1%int63
          (0%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z) 2%Z
          
returns 0%int63 (4%int63 :: nil) 1%int63 (0%int63 :: nil)

'''

def list_to_parse(coq_op):
    return "{| [" + "], [".join(coq_op) + "] |}"


'''


Takes the string 
= ImmBuildProj (t_i:=t_i) t_func t_atom t_form 1
         0 0
     : step (t_i:=t_i) t_func t_atom t_form

returns ImmBuildProj 1 0 0


'''


def parse_Eval(coq_op):
    
    split = coq_op.split("(t_i:=t_i) t_func t_atom t_form")
    first_word = split[0].replace("=", "").strip()
    second_word = split[1].split(":")[0]

    final_word = (first_word + second_word).replace("\n", "")
    word = final_word.split()
    final_list = ""

    for w in word:
      final_list += w + " "

    return(final_list)


'''

Parse function for Coq boolean output
Ex : Takes
  = true 
  : bool
Returns
 (* true *)

 '''


def parse_coq_bool_op(coq_op):
    coq_op_lines = str.split(coq_op)
    for word in coq_op_lines:
        if word == 'true' or word == 'false':
            coq_comment = "(* " + word + " *)"
            return coq_comment


'''

Parses outputs from states of debug file 
Ex : Parses:
s0 = 
({|
   PArray.Map.this :=
     PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 0%int63
       (4%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z;
   PArray.Map.is_bst :=
     PArray.Map.Raw.Proofs.add_bst 0%int63 
       (4%int63 :: nil)
       (PArray.Map.Raw.Proofs.empty_bst (list int))
 |}, 0%int63 :: nil, 2%int63)
     : PArray.Map.t C.t * C.t * int
into:
  (* s0 = {| [4] |} *).   (4%int63 :: 4%int63 :: nil)

'''


def parse_state_op(coq_op):
    '''
    - Get rid of everything 
    1. before the first occurrence of "0%int63"
    2. after the first occurrence of ";""
    '''

    #getting the variable name 
    var_split = coq_op.rsplit(" = ", 1)
    var = var_split[0].strip()

    #getting the parsed element
    temp_1 = coq_op.split("(PArray.Map.Raw.Leaf C.t)", 1)
    temp_2 = temp_1[1].split(";", 1)
    coq_op_stripped = temp_2[0]
    

    
   
    #return var + " = " + coq_list + "\n"

    '''
    - Define parse_coq_list that will take a Coq list
    and return a simplified version of it
    Ex: Takes 
    (4%int63 :: 5%int63 :: nil)
    returns
    [4; 5]

    - Pick out the list from the remaining string and 
    pass it to parse_coq_list

    - Do the above for every list in the array
'''


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
        " " + "Parse_certif_verit t_i t_func t_atom t_form root used_roots trace \n"
        " \"" + i + ".smt2\" \n"
        " \"" + i + ".pf\". \n"
        "\n"
        " " + "Definition nclauses := Eval vm_compute in (match trace with Certif a _ _ => a end). (* Size of the state *)\n"
        " " + "Print nclauses.\n"
    "End " + base_name + "debug."
    )

    #Step 3.
    '''

    Takes 1. file object 2. Type (Enum)
    runs coq file; parses output; comments Coq command 
    and adds commented output to file

    '''

    def run_coq_command(f, t):
        i = file_length(f) - 2
        coq_op = run_coqc(full_name, t)
        replace_coql(f, i, coq_op)
    
    run_coq_command(f, Type.INT)

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

    add_line(f, "\n " + " " + "Definition c := Eval vm_compute in (match trace with Certif _ a _ => a end). (* Certificate *)\n" + " " + "Definition conf := Eval vm_compute in (match trace with Certif _ _ a => a end). (* Look here in the state for the empty clause*)\n" + " " + "Print conf.\n")
    
    run_coq_command(f, Type.INT)

    add_line(f, "\n" + " " + "Eval vm_compute in List.length (fst c). (* No. of steps in certificate *) \n" )

    run_coq_command(f, Type.INT)

    add_line(f, "\n" + " " +"Eval vm_compute in (Form.check_form t_form && Atom.check_atom t_atom && Atom.wt t_i t_func t_atom). \n")

    run_coq_command(f, Type.BOOL)

    add_line(f, "\n" + " " + "(* States from c *) \n" + "\n" + "(* Start state *) \n")

    add_line(f, "\n" + " " + "Definition s0 := Eval vm_compute in (add_roots (S.make nclauses) root used_roots). \n" + " " + " Print s0. \n")

