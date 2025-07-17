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
(*  Print nclauses. *) (* 2 *)

 Definition c := Eval vm_compute in (match trace with Certif _ a _ => a end). (* Certificate *)
 Definition conf := Eval vm_compute in (match trace with Certif _ _ a => a end). (* Look here in the state for the empty clause*)
(*  Print conf. *) (* 0 *)

(* Eval vm_compute in List.length (fst c). (* No. of steps in certificate *) *) (* 3 *)

(* Eval vm_compute in (Form.check_form t_form && Atom.check_atom t_atom && Atom.wt t_i t_func t_atom). *) (* true *)

(* States from c *) 

(* Start state *) 

Definition s0 := Eval vm_compute in (add_roots (S.make nclauses) root used_roots). 
  Print s0. 
End ex1debug.