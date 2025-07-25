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
print(final[0])

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
print(final[0])

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
def parse_coq_int(coq_op):
    l = coq_op.split("%", 1)
    return l[0]

#print(parse_coq_int("0%int63"))

def parse_coq_int(coq_op):
    
    after_equal = coq_op.split(' = ')[1]
    between = after_equal.split(' : ')[0]  
    num = between.strip()  
    print(" this is " , num)

parse_coq_int("nclauses1 = 2%int63 : int")