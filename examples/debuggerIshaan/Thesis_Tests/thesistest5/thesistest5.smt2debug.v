Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool. 
Require Import Int31. 
Local Open Scope int31_scope.

Section thesistest5.smt2debug. 

 Parse_certif_verit t_i t_func t_atom t_form root used_roots trace 
 "./Thesis_Tests/thesistest5/thesistest5.smt2.smt2" 
 "./Thesis_Tests/thesistest5/thesistest5.smt2.pf". 

 Definition nclauses := Eval vm_compute in (match trace with Certif a _ _ => a end). (* Size of the state *)
 Print nclauses.
End thesistest5.smt2debug.