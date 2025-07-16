list  = ['nclauses1', '=', '2%int63', ':', 'int']
list2 = ['=', '3%nat', ':', 'nat']
for word in list2:

    if '%' in word:
        i_percent = word.index('%')
        num = word[0:i_percent]
        print("(* " + num + " *)")