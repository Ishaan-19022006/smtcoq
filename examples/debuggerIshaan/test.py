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
    return l[0]


def parse_coq_int(coq_op):
    
    after_equal = coq_op.split(' = ')[1]
    between = after_equal.split(' : ')[0]  
    num = between.strip()  
    print(" this is " , num)

#parse_coq_int("nclauses1 = 2%int63 : int")

def parse_multiple_list(state_output):
    new_state = state_output.split("::")
    int_list =  ""
    for item in new_state[:-1]:  
        int_list += parse_int(item) + ";"

    return "[" + int_list[:-1] + "]"

'''

TODO: Function that takes 0%int63
       (4%int63 :: nil)
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 1%int63
          (0%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z) 2%Z
          
returns 0%int63 (4%int63 :: nil) 1%int63 (0%int63 :: nil)

'''

s4= """0%int63
       (4%int63 :: nil)
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 1%int63
          (0%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z) 2%Z"""

def list_to_parse(coq_op):
    for word in coq_op.split():
        print(word)
            

#list_to_parse(s4)


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

    return(final_list)

s6 = """= ImmBuildProj (t_i:=t_i) t_func t_atom t_form 0
         0 1 2 3 4
     : step (t_i:=t_i) t_func t_atom t_form"""

print(parse_Eval(s6))