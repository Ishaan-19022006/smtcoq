Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool. 
Require Import Int31. 
Local Open Scope int31_scope.

Section ex2debug. 

 Parse_certif_verit t_i t_func t_atom t_form root used_roots trace 
 "ex2/ex2.smt2" 
 "ex2/ex2.pf". 

 Definition nclauses := Eval vm_compute in (match trace with Certif a _ _ => a end). (* Size of the state *)
(*  Print nclauses. *) (* 3 *)

  Definition c := Eval vm_compute in (match trace with Certif _ a _ => a end). (* Certificate *)
 Definition conf := Eval vm_compute in (match trace with Certif _ _ a => a end). (* Look here in the state for the empty clause*)
(*  Print conf. *) (* 1 *)

(*  Eval vm_compute in List.length (fst c). (* No. of steps in certificate *) *) (* 2 *)

(*  Eval vm_compute in (Form.check_form t_form && Atom.check_atom t_atom && Atom.wt t_i t_func t_atom). *) (* true *)

 (* States from c *) 

(* Start state *) 

 Definition s0 := Eval vm_compute in (add_roots (S.make nclauses) root used_roots). 
(*   Print s0. *) (* s0 = {| [4],[7] |} *)

(*  Eval vm_compute in List.nth 0 (fst c) _. *) (* EqCgr 2 6 (Some 5%int63  *)

 Definition s1 := Eval vm_compute in (step_checker s0 (List.nth 0 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s1. *) (* s1 = {| [4],[7],[5; 6] |} *)

(*  Eval vm_compute in List.nth 1 (fst c) _. *) (* Res 1 {|2,0,1|} *)

 Definition s2 := Eval vm_compute in (step_checker s1 (List.nth 1 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s2. *) (* s2 = {| [4],[],[5; 6] |} *)
End ex2debug.