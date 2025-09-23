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

(*  Eval vm_compute in List.length (fst c). (* No. of steps in certificate *) *) (* 3 *)

(*  Eval vm_compute in (Form.check_form t_form && Atom.check_atom t_atom && Atom.wt t_i t_func t_atom). *) (* true *)

 (* States from c *) 

(* Start state *) 

 Definition s0 := Eval vm_compute in (add_roots (S.make nclauses) root used_roots). 
(*   Print s0. *) (* s0 = {| [4] |} *)

(*  Eval vm_compute in List.nth 0 (fst c) _. *) (* ImmBuildProj 1 0 0  *)

 Definition s1 := Eval vm_compute in (step_checker s0 (List.nth 0 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s1. *) (* s1 = {| [4],[0] |} *)  (* FLAGGED: contains [0] *)

(*  Eval vm_compute in List.nth 1 (fst c) _. *) (* ImmBuildProj 0 0 1  *)

 Definition s2 := Eval vm_compute in (step_checker s1 (List.nth 1 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s2. *) (* s2 = {| [1],[0] |} *)  (* FLAGGED: contains [0] *)

(*  Eval vm_compute in List.nth 2 (fst c) _. *) (* Res 0 {|1,0|} *)

 Definition s3 := Eval vm_compute in (step_checker s2 (List.nth 2 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s3. *) (* s3 = {| [],[0] |} *)  (* FLAGGED: contains [0] *)
End ex1debug.