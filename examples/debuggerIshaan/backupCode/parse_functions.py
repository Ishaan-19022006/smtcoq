import re


'''

This file contains all the parse function for the debugger script.

'''



'''

Takes a string that contains a Coq integer
Returns a string just the integer
Ex: takes "0%int63", returns "0"

'''

def parse_int(coq_op):
    l = coq_op.rsplit("%", 1)
    num = l[0].strip("()")
    return num

'''

Takes a string that is the the entire coq output and returns a string that is the the coq integer
Ex: Takes
nclauses1 = 2%int63
     : int

Returns
2%int63

'''


def parse_coq_int(coq_op):
    
    after_equal = coq_op.split(' = ')[1]
    between = after_equal.split(' : ')[0]  
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

Takes a string that contains a Coq list
Returns a string with a simplified form of the list
Ex: 
1. single element list; takes 
(4%int63 :: nil)
returns [4]
2. multiple element list; takes
(4%int63 :: 0%int63 :: 17%int63 :: nil)
returns [4 ; 0 ; 17] 
3. empty list; takes
nil
returns []
'''


def parse_list(state_output):
    new_state = state_output.split("::")
    int_list =  ""
    for item in new_state[:-1]:  
        int_list += parse_int(item) + ";"

    return "[" + int_list[:-1] + "]"


'''

Takes 
1. 0%int63
       (4%int63 :: nil)
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 1%int63
          (0%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z) 2%Z
          
returns [4], [0]

2. 0%int63
       nil
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 1%int63
          (0%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z) 2%Z

returns [], [0]

'''

def list_to_parse(coq_op):
    coq_op = coq_op.strip()


    matches = re.findall(r'(\([^()]*? :: nil\))|(nil)', coq_op)

    result = []
    final_result = ""
    for match in matches:
      for m in match:
          if m:
            result.append(m)
          
        
    
    for word in result:
            final_result += parse_list(word) + ","

    return final_result[:-1]


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
  (* s0 = {| [4] |} *).   

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
    final_parse = list_to_parse(coq_op_stripped)

    return "(* " + var + " = " + "{| " + final_parse + " |} *)"



'''
Takes the String

= Res (t_i:=t_i) t_func t_atom t_form 0
         ({|
            PArray.Map.this :=
              PArray.Map.Raw.Node
                (PArray.Map.Raw.Leaf int) 0%int63
                1%int63
                (PArray.Map.Raw.Node
                   (PArray.Map.Raw.Leaf int) 1%int63
                   0%int63 (PArray.Map.Raw.Leaf int)
                   1%Z) 2%Z;
            PArray.Map.is_bst :=
              PArray.Map.Raw.Proofs.add_bst 1%int63
                0%int63
                (PArray.Map.Raw.Proofs.add_bst 0%int63
                   1%int63
                   (PArray.Map.Raw.Proofs.empty_bst
                      int))
          |}, 0%int63, 2%int63)
     : step (t_i:=t_i) t_func t_atom t_form

returns Res 0 {| 1, 0 |}

'''

def parse_Res(coq_op):
    coq_list = coq_op.split()
    var  = coq_list[1] #Variable Res
    firstnum = coq_list[6] #First number after Res 
    

    s_lst = coq_op.split("(PArray.Map.Raw.Leaf int)", 1)
    new_str = s_lst[1]
    final = new_str.split(";", 1) 
    words = final[0]
    
    matches = re.findall(r'(\d+%int63)', words)
    match = 1
    result = []
    final_result = ""
    while match < len(matches):
        result.append(matches[match])
        
        match += 2
    
    for word in result:
            final_result += parse_int(word) + ","

    return "(* " + var + " " + firstnum + " " + "{|" + (final_result[:-1]) + "|} *)"

'''


Parses all types of inductive steps 

Example :
1. Takes = ImmmbuildProj (t_i:=t_i) t_func t_atom t_form 1
          0 0 
     : step (t_i:=t_i) t_func t_atom t_form"""
    
     Returns (* ImmbuildProj 1 0 0 *)

2. Takes = DistElim (t_i:=t_i) t_func t_atom t_form 1
          [5%int63 :: 6%int63 :: nil] 0 
     : step (t_i:=t_i) t_func t_atom t_form"""
    
     Returns (* DistElim 1 [5; 6] 0 *)

3. Takes = EqCgr (t_i:=t_i) t_func t_atom t_form 1
          0 (Some 5%int63 :: Some 6%int63 :: None :: nil)
     : step (t_i:=t_i) t_func t_atom t_form"""
    
     Returns (* EqCgr 1 0 [S 5 ; S 6 ; N] *)


'''

def parse_Step(coq_op):

    no_step = ["RowNeq", "LiaMicromega", "SplArith", "Hole", "ForallInst"]

    if "Res" in coq_op.split():
        op = parse_Res(coq_op)
        return op
    
    elif "EqTr" in coq_op.split() or "Weaken" in coq_op.split():
        split = coq_op.split("(t_i:=t_i) t_func t_atom t_form")

        first_word = split[0].replace("=", "").strip()  

        second_word = split[1].split("step")[0] 

        sw_split = second_word.split()

        first_num = sw_split[0] 
        second_num = sw_split[1] 

        
        
        matches = re.findall(r'(\d+%int63)', second_word)
        final_result = ""
        for match in matches:
            final_result += parse_int(match) + ";"
        
        return "(* " + first_word + " " + first_num + " " + second_num + " " + "[" + final_result[:-1] + "]" + " *)" 
    
    elif "DistElim" in coq_op.split():
        split = coq_op.split("(t_i:=t_i) t_func t_atom t_form")

        first_word = split[0].replace("=", "").strip() 

        second_word = split[1].split("step")[0] 

        sw_split = second_word.split()
        
        first_num = sw_split[0] 
        last_num = sw_split[len(sw_split)-2] 
        
        matches = re.findall(r'(\d+%int63)', second_word)
        final_result = ""
        for match in matches:
            final_result += parse_int(match) + ";"
        
        return "(* " + first_word + " " + first_num + " " + "[" + final_result[:-1] + "]" + " " + last_num + " *)" 
    
      
    elif "EqCgr" in coq_op.split():
        split = coq_op.split("(t_i:=t_i) t_func t_atom t_form")

        first_word = split[0].replace("=", "").strip() 

        second_word = split[1].split("step")[0] 

        sw_split = second_word.split()

        first_num = sw_split[0] 
        second_num = sw_split[1] 

        matches = re.findall(r'(\([^()]*? :: nil\))|(nil)', second_word)
        result = []
        final_result = ""
        for match in matches:
          for m in match:
              if m:
                result.append(m)
              
        for word in result:
                
                final_result += parse_list(word) 
        
        final_matches = re.findall(r'Some|None', final_result)
        for fm in final_matches:
          
          if fm == "Some" :
              final_result = final_result.replace("Some", "S")
          elif fm == "None" :
              final_result = final_result.replace("None", "N")
        
        
        
        return "(* " + first_word + " " + first_num + " " + second_num + " " +  final_result  + " *)"
            
    
    elif "EqCgrP" in coq_op.split():
        split = coq_op.split("(t_i:=t_i) t_func t_atom t_form")

        first_word = split[0].replace("=", "").strip() 

        second_word = split[1].split("step")[0] 

        sw_split = second_word.split()

        first_num = sw_split[0] 
        second_num = sw_split[1] 
        third_num = sw_split[2] 

        matches = re.findall(r'(\([^()]*? :: nil\))|(nil)', second_word)
        result = []
        final_result = ""
        for match in matches:
          for m in match:
              if m:
                result.append(m)
            
        for word in result:
                final_result += parse_list(word) 
        
        final_matches = re.findall(r'Some|None', final_result)
        for fm in final_matches:
          
          if fm == "Some" :
              final_result = final_result.replace("Some", "S")
          elif fm == "None" :
              final_result = final_result.replace("None", "N")
                 
        return "(* " + first_word + " " + first_num + " " + second_num + " " + third_num + " " +  final_result  + " *)"
                    
        

    elif any(step in coq_op.split() for step in no_step):
      return ("(* this step is not valid *) ") 

    else: 
        split = coq_op.split("(t_i:=t_i) t_func t_atom t_form")
        first_word = split[0].replace("=", "").strip() 
        
        second_word = split[1].split(":")[0] 
        
        final_word = (first_word + second_word).replace("\n", "")
        word = final_word.split()
        final_list = ""

        for w in word:
            final_list += w + " "

        return "(* " + final_list + " *)"
    
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
Checker for flagging outputs that have [0] in them

'''
def check_for_zero(parsed_state_comment):
    return "[0]" in parsed_state_comment





