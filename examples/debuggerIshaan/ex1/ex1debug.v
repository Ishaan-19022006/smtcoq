Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool. 
Require Import Int31. 
Local Open Scope int31_scope.

Section ex1debug. 

 Parse_certif_verit t_i t_func t_atom t_form root used_roots trace 
 "ex1/ex1.smt2" 
 "ex1/ex1.pf". 

 Definition nclauses := Eval vm_compute in (match trace with Certif a _ _ => a end). (* Size of the state *)
 Print nclauses.
End ex1debug.