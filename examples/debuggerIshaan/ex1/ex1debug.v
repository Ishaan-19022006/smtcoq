Add Rec LoadPath "/Users/ishaankumar1902/Desktop/smtcoq/examples/debuggerIshaan" as SMTCoq. 
Require Import SMTCoq.SMTCoq.
Require Import Bool. 
Require Import Int31. 
Local Open Scope int31_scope.

Section ex1debug. 

 Parse_certif_verit t_i1 t_func1 t_atom1 t_form1 root1 used_roots1 trace1. 
 "ex1.smt2" 
 "ex1.pf" 

 Definition nclauses1 := Eval vm_compute in (match trace1 with Certif a _ _ => a end). (* Size of the state *)
 Print nclauses1.
 Definition c1 := Eval vm_compute in (match trace1 with Certif _ a _ => a end). (* Certificate *)
 Print c1.
 Definition conf1 := Eval vm_compute in (match trace1 with Certif _ _ a => a end). (* Look here in the state for the empty clause*)
 Print conf1.
 Eval vm_compute in List.length (fst c1). (* No. of steps in certificate *)
 (* Sanity check that atoms and formulas are well-typed. Must return true *)
 Eval vm_compute in (Form.check_form t_form1 && Atom.check_atom t_atom1 && Atom.wt t_i1 t_func1 t_atom1).
 
 
 (* States from c1 *)
 
 (* Start state *)
 Definition s0_1 := Eval vm_compute in (add_roots (S.make nclauses1) root1 used_roots1).
 Print s0_1.
 
End ex1debug. 
