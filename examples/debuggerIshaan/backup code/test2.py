import re 
'''
Parse

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

return Res 0 {| 1, 0 |}

'''


def parse_int(coq_op):
    l = coq_op.rsplit("%", 1)
    num = l[0]
    return num



s = '''= Res (t_i:=t_i) t_func t_atom t_form 5
         ({|
            PArray.Map.this :=
              PArray.Map.Raw.Node
                (PArray.Map.Raw.Leaf int) 0%int63
                21%int63
                (PArray.Map.Raw.Node
                   (PArray.Map.Raw.Leaf int) 1%int63
                   22%int63 (PArray.Map.Raw.Leaf int)
                   1%Z) 2%Z;
            PArray.Map.is_bst :=
              PArray.Map.Raw.Proofs.add_bst 1%int63
                0%int63
                (PArray.Map.Raw.Proofs.add_bst 0%int63
                   1%int63
                   (PArray.Map.Raw.Proofs.empty_bst
                      int))
          |}, 0%int63, 2%int63)
     : step (t_i:=t_i) t_func t_atom t_form '''


'''
    Get all Coq integers and then print them skip every other interval 
    ex : 0%int63
                1%int63 :return this 
                    1%int63
                        0%int63 :return this 
    return 1%int63 , 0%int63

    run parse_int() to return 1, 0 

    then return Res 0 {| 1, 0 |}
                   
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
    
def parse_Step(coq_op):
    
    if "Res" in coq_op.split():
        op = parse_Res(coq_op)
        return op
    
    else: #handles all steps which take upto 4 integers 
        split = coq_op.split("(t_i:=t_i) t_func t_atom t_form")
        first_word = split[0].replace("=", "").strip()
        second_word = split[1].split(":")[0]

        final_word = (first_word + second_word).replace("\n", "")
        word = final_word.split()
        final_list = ""

        for w in word:
            final_list += w + " "

        return "(* " + final_list + " *)"
    


op_1 = """= BBOp (t_i:=t_i) t_func t_atom t_form 1
          0 0 0 
     : step (t_i:=t_i) t_func t_atom t_form"""

print(parse_Step(op_1))