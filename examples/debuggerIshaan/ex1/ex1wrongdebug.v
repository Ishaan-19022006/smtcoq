Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool. 
Require Import Int31. 
Local Open Scope int31_scope.

Section ex1debug. 

 Parse_certif_verit t_i1 t_func1 t_atom1 t_form1 root1 used_roots1 trace1 
 "ex1/ex1.smt2" 
 "ex1/ex1wrong.pf". 

 Definition nclauses1 := Eval vm_compute in (match trace1 with Certif a _ _ => a end). (* Size of the state *)
 Print nclauses1.
End ex1debug. 
