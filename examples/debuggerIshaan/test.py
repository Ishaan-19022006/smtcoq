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