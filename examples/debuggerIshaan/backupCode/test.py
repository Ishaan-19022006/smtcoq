import re 

s = """s0 = 
({|
   PArray.Map.this :=
     PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 0%int63
       (4%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z;
   PArray.Map.is_bst :=
     PArray.Map.Raw.Proofs.add_bst 0%int63 
       (4%int63 :: nil)
       (PArray.Map.Raw.Proofs.empty_bst (list int))
 |}, 0%int63 :: nil, 2%int63)
     : PArray.Map.t C.t * C.t * int"""
s_lst = s.split("(PArray.Map.Raw.Leaf C.t)", 1)
new_str = s_lst[1]
final = new_str.split(";", 1)
#print(final[0])
long = """s1 = 
({|
   PArray.Map.this :=
     PArray.Map.Raw.Node
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 0%int63
          (8%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z)
       1%int63 (14%int63 :: nil)
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 2%int63
          (21%int63 :: nil)
          (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 3%int63
             (7%int63 :: 13%int63 :: 16%int63 :: nil)
             (PArray.Map.Raw.Leaf C.t) 1%Z) 2%Z) 3%Z;
   PArray.Map.is_bst :=
     PArray.Map.Raw.Proofs.add_bst 3%int63
       (7%int63 :: 13%int63 :: 16%int63 :: nil)
       (PArray.Map.Raw.Proofs.add_bst 2%int63 
          (21%int63 :: nil)
          (PArray.Map.Raw.Proofs.add_bst 1%int63
             (14%int63 :: nil)
             (PArray.Map.Raw.Proofs.add_bst 0%int63
                (8%int63 :: nil)
                (PArray.Map.Raw.Proofs.empty_bst (list int)))))
 |}, 0%int63 :: nil, 7%int63)
     : PArray.Map.t C.t * C.t * int"""
s2 = """
s1 = 
({|
   PArray.Map.this :=
     PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 0%int63
       (4%int63 :: nil)
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 1%int63
          (0%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z) 2%Z;
   PArray.Map.is_bst :=
     PArray.Map.Raw.Proofs.add_bst 1%int63 
       (0%int63 :: nil)
       (PArray.Map.Raw.Proofs.add_bst 0%int63 
          (4%int63 :: nil)
          (PArray.Map.Raw.Proofs.empty_bst (list int)))
 |}, 0%int63 :: nil, 2%int63)
     : PArray.Map.t C.t * C.t * int"""
s_lst = s2.split("(PArray.Map.Raw.Leaf C.t)", 1)
new_str = s_lst[1]
final = new_str.split(";", 1)
#print(final[0])

'''
Ideally, we can convert this:
0%int63
       (4%int63 :: nil)
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 1%int63
          (0%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z) 2%Z

to:
0%int63 (4%int63 :: nil) 1%int63 (0%int63 :: nil)

to
{| [4], [0] |}
'''
def parse_int(coq_op):
    l = coq_op.split("%", 1)
    return l[0].strip().strip("()")


def parse_coq_int(coq_op):
    
    after_equal = coq_op.split(' = ')[1]
    between = after_equal.split(' : ')[0]  
    num = between.strip()  
    return num



def parse_list(state_output):
    new_state = state_output.split("::")
    int_list =  ""
    for item in new_state[:-1]:  
        int_list += parse_int(item) + ";"

    return "[" + int_list[:-1] + "]"

'''

Function that takes 0%int63
          (8%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z)
       1%int63 (14%int63 :: nil)
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 2%int63
          (21%int63 :: nil)
          (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 3%int63
             (7%int63 :: 13%int63 :: 16%int63 :: nil)
             (PArray.Map.Raw.Leaf C.t) 1%Z) 2%Z) 3%Z
          
returns  [8],[14],[21],[7;13;16]

'''

s4= """0%int63
          (8%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z)
       1%int63 (14%int63 :: nil)
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 2%int63
          (21%int63 :: nil)
          (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 3%int63
             (7%int63 :: 13%int63 :: 16%int63 :: nil)
             (PArray.Map.Raw.Leaf C.t) 1%Z) 2%Z) 3%Z"""

s4_1 = """0%int63
          (8%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z)
       1%int63 (14%int63 :: nil)
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 2%int63
          (21%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z) 2%Z) """

s10 = """0%int63 nil
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 1%int63
          (0%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z) 2%Z)"""

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
            final_result += parse_multiple_list(word) + ","

    return final_result[:-1]

print(list_to_parse(s10) )




    #r = raw string, used in regex so that we are not finding patterns on strings which are automatically spaced out or tabbed out by python
    
    
   # group (\([^()]*? :: nil\)) will match a Coq list, which is of the form (x%int63 :: nil)
   # \( and /): literal parenthesis for the coq list
   # [] : charcter set, this is where we specify what characters we want to match
   # ^() : match anything that is not a parenthesis, so we can match more elements in the list
   # *? : this is the key component and allows us to match list with more than one element
   # * : zero or more matches, if there are zero matches, moves onto ? , otherwise matches as many digits as possible
   # ? : makes this character set optional, so if there are no elements after the first coq integer it will move onto :: nil

   # | : this is the OR keyword, so that we match either a coq list or the word nil
   # (nil) : this is the string literal nil which we want to match 

'''
Takes the string 
= ImmBuildProj (t_i:=t_i) t_func t_atom t_form 1
         0 0
     : step (t_i:=t_i) t_func t_atom t_form

returns ImmBuildProj 1 0 0
'''

s5 = """
= ImmBuildProj (t_i:=t_i) t_func t_atom t_form 1 
    0 0 
: step (t_i:=t_i) t_func t_atom t_form"""
def parse_Eval(coq_op):
    
    split = coq_op.split("(t_i:=t_i) t_func t_atom t_form")
    first_word = split[0].replace("=", "").strip()
    second_word = split[1].split(":")[0]

    final_word = (first_word + second_word).replace("\n", "")
    word = final_word.split()

    final_list = ""

    for w in word:
      final_list += w + " "
    
    return final_list

s6 = """= ImmBuildProj (t_i:=t_i) t_func t_atom t_form 0
         0 1 2 3 4
     : step (t_i:=t_i) t_func t_atom t_form"""

#print(parse_Eval(s6))


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

    return "(* " + var + " = " + "{| " + final_parse + " |} *)\n"

#print(parse_state_op(long))