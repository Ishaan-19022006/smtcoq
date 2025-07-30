s = '''0%int63
       (4%int63 :: nil)
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 1%int63
          (0%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z) 2%Z'''

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

'''Convert a Python int to a string representing a Coq int
Ex: takes 5, returns "5%int63"
'''
def to_coq_int(i):
    return (str(i) + "%int63")

'''
Looks for key in s; if found, returns s trimmed on the left until the end of key; otherwise returns the empty string
Ex: takes 
"0%int63
       (4%int63 :: nil)"
returns 
"(4%int63 :: nil)"
'''
def find_and_trim(key, s):
    pos = s.find(key)
    if(pos == -1):
        return ""
    else:
        new_pos = pos + len(key) - 1
        return s[new_pos:]

'''
Looks for the next Coq list in s (delimited by parentheses); returns a Python list with
2 elements - the first is a string with a simplified representation of the Coq list and
the second is the string s trimmed on the left until the end of the first Coq list in it
'''
def find_list_trim(s):
    start = s.find("(")
    end = s.find(")") + 1
    l = s[start:end]
    l_op = parse_list(l)
    new_s = s[end:]
    return [l_op, new_s]
'''
Converts the trimmed version of the Coq output containing an array of lists
into a simplified representation.
Ex: takes
"0%int63
       (4%int63 :: nil)
       (PArray.Map.Raw.Node (PArray.Map.Raw.Leaf C.t) 1%int63
          (0%int63 :: nil) (PArray.Map.Raw.Leaf C.t) 1%Z) 2%Z"
returns
"{| [4], [0], |}
'''
def parse_array(trimmed_op):
    index = 0
    flag = True
    res = "{| "
    while(flag):
        coq_index = to_coq_int(index)
        trimmed_op = find_and_trim(coq_index, trimmed_op)
        if(len(trimmed_op) > 0):
            l = find_list_trim(trimmed_op)
            trimmed_op = l[1]
            res += (l[0] + ", ")
            index += 1
        else:
            flag = False
    res += "|}"
    return res

