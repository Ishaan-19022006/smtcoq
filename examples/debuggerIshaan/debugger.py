#Get first command line argument into a string variable
import sys 
import os

for i in sys.argv[1:]:
    base_name = os.path.basename(i)
    open(base_name + "debug.v", "w").write(
        "Add Rec LoadPath \"/Users/ishaankumar1902/Desktop/smtcoq/examples/debuggerIshaan\" as SMTCoq. \n"
        "Require Import SMTCoq.SMTCoq.\n"
        "Require Import Bool. \n" 
        "Require Import Int31. \n"  
        "Local Open Scope int31_scope.\n"
        "\n"
        "Section " + base_name + "debug. \n" 
            "\n"
            " " + "Parse_certif_verit t_i1 t_func1 t_atom1 t_form1 root1 used_roots1 trace1. \n"
            " \"" + base_name + ".smt2\" \n"
            " \"" + base_name + ".pf\" \n"
            "\n"
            " " + "Definition nclauses1 := Eval vm_compute in (match trace1 with Certif a _ _ => a end). (* Size of the state *)\n"
            " " + "Print nclauses1.\n"
            " " + "Definition c1 := Eval vm_compute in (match trace1 with Certif _ a _ => a end). (* Certificate *)\n"
            " " + "Print c1.\n"
            " " + "Definition conf1 := Eval vm_compute in (match trace1 with Certif _ _ a => a end). (* Look here in the state for the empty clause*)\n"
            " " + "Print conf1.\n"
            " " + "Eval vm_compute in List.length (fst c1). (* No. of steps in certificate *)\n"
            " " + "(* Sanity check that atoms and formulas are well-typed. Must return true *)\n"
            " " + "Eval vm_compute in (Form.check_form t_form1 && Atom.check_atom t_atom1 && Atom.wt t_i1 t_func1 t_atom1).\n"
            " \n"
            " \n"
            " " + "(* States from c1 *)\n"
            " \n"
            " " + "(* Start state *)\n"
            " " + "Definition s0_1 := Eval vm_compute in (add_roots (S.make nclauses1) root1 used_roots1).\n"
            " " + "Print s0_1.\n"
            " \n"
        
        "End " + base_name + "debug. \n"
        )