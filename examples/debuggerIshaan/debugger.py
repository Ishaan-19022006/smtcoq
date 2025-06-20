#Get first command line argument into a string variable
import sys 

for i in sys.argv[1:]:
        
    open(i + ".smt2", "w")#creating smt2 file
    open(i + ".pf", "w")#creating proof file
    open(i + ".v", "w")#creating checker file
    open(i + "debug.v", "w").write("This is the debug file for " + i)