Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool. 
Require Import Int31. 
Local Open Scope int31_scope.

Section ex1debug. 

 Parse_certif_verit t_i1 t_func1 t_atom1 t_form1 root1 used_roots1 trace1 
 "ex1/ex1.smt2" 
 "ex1/ex1.pf". 

 Definition nclauses1 := Eval vm_compute in (match trace1 with Certif a _ _ => a end). (* Size of the state *)
(*  Print nclauses1. *) (* 2 *)

 Definition c1 := Eval vm_compute in (match trace1 with Certif _ a _ => a end). (* Certificate *)
 Definition conf1 := Eval vm_compute in (match trace1 with Certif _ _ a => a end). (* Look here in the state for the empty clause*)
(*  Print conf1. *) (* 0 *)

(* Eval vm_compute in List.length (fst c1). (* No. of steps in certificate *) *) (* 3 *)
End ex1debug.