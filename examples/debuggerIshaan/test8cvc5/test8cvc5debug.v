Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool. 
Require Import Int31. 
Local Open Scope int31_scope.

Section test8cvc5debug. 

 Parse_certif_verit t_i t_func t_atom t_form root used_roots trace 
 "test8cvc5/test8cvc5.smt2" 
 "test8cvc5/test8cvc5.pf". 

 Definition nclauses := Eval vm_compute in (match trace with Certif a _ _ => a end). (* Size of the state *)
(*  Print nclauses. *) (* 9 *)

  Definition c := Eval vm_compute in (match trace with Certif _ a _ => a end). (* Certificate *)
 Definition conf := Eval vm_compute in (match trace with Certif _ _ a => a end). (* Look here in the state for the empty clause*)
(*  Print conf. *) (* 2 *)

(*  Eval vm_compute in List.length (fst c). (* No. of steps in certificate *) *) (* 183 *)

(*  Eval vm_compute in (Form.check_form t_form && Atom.check_atom t_atom && Atom.wt t_i t_func t_atom). *) (* true *)

 (* States from c *) 

(* Start state *) 

 Definition s0 := Eval vm_compute in (add_roots (S.make nclauses) root used_roots). 
(*   Print s0. *) (* s0 = {| [9] |} *)

(*  Eval vm_compute in List.nth 0 (fst c) _. *) (* BuildDef2 1 13  *)

 Definition s1 := Eval vm_compute in (step_checker s0 (List.nth 0 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s1. *) (* s1 = {| [9],[2; 10; 13] |} *)

(*  Eval vm_compute in List.nth 1 (fst c) _. *) (* BuildDef2 2 19  *)

 Definition s2 := Eval vm_compute in (step_checker s1 (List.nth 1 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s2. *) (* s2 = {| [9],[2; 10; 13],[8; 17; 19] |} *)

(*  Eval vm_compute in List.nth 2 (fst c) _. *) (* EqTr 3 20 [] *)

 Definition s3 := Eval vm_compute in (step_checker s2 (List.nth 2 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s3. *) (* s3 = {| [9],[2; 10; 13],[8; 17; 19],[20] |} *)

(*  Eval vm_compute in List.nth 3 (fst c) _. *) (* this step is not valid *) 

 Definition s4 := Eval vm_compute in (step_checker s3 (List.nth 3 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s4. *) (* s4 = {| [9],[2; 10; 13],[8; 17; 19],[20],[22] |} *)

(*  Eval vm_compute in List.nth 4 (fst c) _. *) (* EqTr 5 24 [23;5;21] *)

 Definition s5 := Eval vm_compute in (step_checker s4 (List.nth 4 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s5. *) (* s5 = {| [9],[2; 10; 13],[8; 17; 19],[20],[22],[5; 21; 23; 24] |} *)

(*  Eval vm_compute in List.nth 5 (fst c) _. *) (* BuildDef2 6 26  *)

 Definition s6 := Eval vm_compute in (step_checker s5 (List.nth 5 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s6. *) (* s6 = {| [9],[2; 10; 13],[8; 17; 19],[20],[22],[5; 21; 23; 24],[4; 24; 26] |} *)

(*  Eval vm_compute in List.nth 6 (fst c) _. *) (* Res 6 {|5,6|} *)

 Definition s7 := Eval vm_compute in (step_checker s6 (List.nth 6 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s7. *) (* s7 = {| [9],[2; 10; 13],[8; 17; 19],[20],[22],[5; 21; 23; 24],[21; 23; 24; 26] |} *)

(*  Eval vm_compute in List.nth 7 (fst c) _. *) (* EqTr 5 4 [23;25;21] *)

 Definition s8 := Eval vm_compute in (step_checker s7 (List.nth 7 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s8. *) (* s8 = {| [9],[2; 10; 13],[8; 17; 19],[20],[22],[4; 21; 23; 25],[21; 23; 24; 26] |} *)

(*  Eval vm_compute in List.nth 8 (fst c) _. *) (* BuildDef 7 26  *)

 Definition s9 := Eval vm_compute in (step_checker s8 (List.nth 8 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s9. *) (* s9 = {| [9],[2; 10; 13],[8; 17; 19],[20],[22],[4; 21; 23; 25],[21; 23; 24; 26],[5; 25; 26] |} *)

(*  Eval vm_compute in List.nth 9 (fst c) _. *) (* Res 7 {|5,7|} *)

 Definition s10 := Eval vm_compute in (step_checker s9 (List.nth 9 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s10. *) (* s10 = {| [9],[2; 10; 13],[8; 17; 19],[20],[22],[4; 21; 23; 25],[21; 23; 24; 26],[21; 23; 25; 26] |} *)

(*  Eval vm_compute in List.nth 10 (fst c) _. *) (* Res 4 {|6,7,3,4|} *)

 Definition s11 := Eval vm_compute in (step_checker s10 (List.nth 10 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s11. *) (* s11 = {| [9],[2; 10; 13],[8; 17; 19],[20],[26],[4; 21; 23; 25],[21; 23; 24; 26],[21; 23; 25; 26] |} *)

(*  Eval vm_compute in List.nth 11 (fst c) _. *) (* this step is not valid *) 

 Definition s12 := Eval vm_compute in (step_checker s11 (List.nth 11 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s12. *) (* s12 = {| [9],[2; 10; 13],[8; 17; 19],[20],[26],[4; 21; 23; 25],[21; 23; 24; 26],[0] |} *)

(*  Eval vm_compute in List.nth 12 (fst c) _. *) (* BuildDef 6 27  *)

 Definition s13 := Eval vm_compute in (step_checker s12 (List.nth 12 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s13. *) (* s13 = {| [9],[2; 10; 13],[8; 17; 19],[20],[26],[4; 21; 23; 25],[4; 25; 27],[0] |} *)

(*  Eval vm_compute in List.nth 13 (fst c) _. *) (* Res 6 {|6,4|} *)

 Definition s14 := Eval vm_compute in (step_checker s13 (List.nth 13 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s14. *) (* s14 = {| [9],[2; 10; 13],[8; 17; 19],[20],[26],[4; 21; 23; 25],[4; 25],[0] |} *)

(*  Eval vm_compute in List.nth 14 (fst c) _. *) (* BuildDef 5 29  *)

 Definition s15 := Eval vm_compute in (step_checker s14 (List.nth 14 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s15. *) (* s15 = {| [9],[2; 10; 13],[8; 17; 19],[20],[26],[15; 24; 29],[4; 25],[0] |} *)

(*  Eval vm_compute in List.nth 15 (fst c) _. *) (* Res 5 {|5,7|} *)

 Definition s16 := Eval vm_compute in (step_checker s15 (List.nth 15 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s16. *) (* s16 = {| [9],[2; 10; 13],[8; 17; 19],[20],[26],[0; 0],[4; 25],[0] |} *)

(*  Eval vm_compute in List.nth 16 (fst c) _. *) (* Res 5 {|6,5|} *)

 Definition s17 := Eval vm_compute in (step_checker s16 (List.nth 16 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s17. *) (* s17 = {| [9],[2; 10; 13],[8; 17; 19],[20],[26],[0; 0; 0],[4; 25],[0] |} *)

(*  Eval vm_compute in List.nth 17 (fst c) _. *) (* BuildDef2 6 30  *)

 Definition s18 := Eval vm_compute in (step_checker s17 (List.nth 17 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s18. *) (* s18 = {| [9],[2; 10; 13],[8; 17; 19],[20],[26],[0; 0; 0],[4; 14; 30],[0] |} *)

(*  Eval vm_compute in List.nth 18 (fst c) _. *) (* Res 6 {|5,6|} *)

 Definition s19 := Eval vm_compute in (step_checker s18 (List.nth 18 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s19. *) (* s19 = {| [9],[2; 10; 13],[8; 17; 19],[20],[26],[0; 0; 0],[0; 0; 0; 0],[0] |} *)

(*  Eval vm_compute in List.nth 19 (fst c) _. *) (* BuildDef2 5 27  *)

 Definition s20 := Eval vm_compute in (step_checker s19 (List.nth 19 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s20. *) (* s20 = {| [9],[2; 10; 13],[8; 17; 19],[20],[26],[5; 24; 27],[0; 0; 0; 0],[0] |} *)

(*  Eval vm_compute in List.nth 20 (fst c) _. *) (* Res 4 {|5,4|} *)

 Definition s21 := Eval vm_compute in (step_checker s20 (List.nth 20 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s21. *) (* s21 = {| [9],[2; 10; 13],[8; 17; 19],[20],[5; 24],[5; 24; 27],[0; 0; 0; 0],[0] |} *)

(*  Eval vm_compute in List.nth 21 (fst c) _. *) (* BuildDef2 5 29  *)

 Definition s22 := Eval vm_compute in (step_checker s21 (List.nth 21 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s22. *) (* s22 = {| [9],[2; 10; 13],[8; 17; 19],[20],[5; 24],[14; 25; 29],[0; 0; 0; 0],[0] |} *)

(*  Eval vm_compute in List.nth 22 (fst c) _. *) (* Res 7 {|5,7|} *)

 Definition s23 := Eval vm_compute in (step_checker s22 (List.nth 22 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s23. *) (* s23 = {| [9],[2; 10; 13],[8; 17; 19],[20],[5; 24],[14; 25; 29],[0; 0; 0; 0],[0; 0] |} *)

(*  Eval vm_compute in List.nth 23 (fst c) _. *) (* Res 7 {|4,7|} *)

 Definition s24 := Eval vm_compute in (step_checker s23 (List.nth 23 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s24. *) (* s24 = {| [9],[2; 10; 13],[8; 17; 19],[20],[5; 24],[14; 25; 29],[0; 0; 0; 0],[0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 24 (fst c) _. *) (* BuildDef 4 30  *)

 Definition s25 := Eval vm_compute in (step_checker s24 (List.nth 24 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s25. *) (* s25 = {| [9],[2; 10; 13],[8; 17; 19],[20],[5; 15; 30],[14; 25; 29],[0; 0; 0; 0],[0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 25 (fst c) _. *) (* Res 4 {|7,4|} *)

 Definition s26 := Eval vm_compute in (step_checker s25 (List.nth 25 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s26. *) (* s26 = {| [9],[2; 10; 13],[8; 17; 19],[20],[0; 0; 0; 0],[14; 25; 29],[0; 0; 0; 0],[0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 26 (fst c) _. *) (* Res 4 {|6,4|} *)

 Definition s27 := Eval vm_compute in (step_checker s26 (List.nth 26 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s27. *) (* s27 = {| [9],[2; 10; 13],[8; 17; 19],[20],[0; 0; 0; 0; 0],[14; 25; 29],[0; 0; 0; 0],[0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 27 (fst c) _. *) (* EqTr 6 32 [] *)

 Definition s28 := Eval vm_compute in (step_checker s27 (List.nth 27 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s28. *) (* s28 = {| [9],[2; 10; 13],[8; 17; 19],[20],[0; 0; 0; 0; 0],[14; 25; 29],[32],[0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 28 (fst c) _. *) (* this step is not valid *) 

 Definition s29 := Eval vm_compute in (step_checker s28 (List.nth 28 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s29. *) (* s29 = {| [9],[2; 10; 13],[8; 17; 19],[20],[0; 0; 0; 0; 0],[14; 25; 29],[32],[34] |} *)

(*  Eval vm_compute in List.nth 29 (fst c) _. *) (* this step is not valid *) 

 Definition s30 := Eval vm_compute in (step_checker s29 (List.nth 29 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s30. *) (* s30 = {| [9],[2; 10; 13],[8; 17; 19],[20],[0; 0; 0; 0; 0],[36],[32],[34] |} *)

(*  Eval vm_compute in List.nth 30 (fst c) _. *) (* EqCgr 8 38 [S 21; S 37] *)

 Definition s31 := Eval vm_compute in (step_checker s30 (List.nth 30 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s31. *) (* s31 = {| [9],[2; 10; 13],[8; 17; 19],[20],[0; 0; 0; 0; 0],[36],[32],[34],[21; 37; 38] |} *)

(*  Eval vm_compute in List.nth 31 (fst c) _. *) (* Res 5 {|8,3,5|} *)

 Definition s32 := Eval vm_compute in (step_checker s31 (List.nth 31 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s32. *) (* s32 = {| [9],[2; 10; 13],[8; 17; 19],[20],[0; 0; 0; 0; 0],[38],[32],[34],[21; 37; 38] |} *)

(*  Eval vm_compute in List.nth 32 (fst c) _. *) (* this step is not valid *) 

 Definition s33 := Eval vm_compute in (step_checker s32 (List.nth 32 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s33. *) (* s33 = {| [9],[2; 10; 13],[8; 17; 19],[40],[0; 0; 0; 0; 0],[38],[32],[34],[21; 37; 38] |} *)

(*  Eval vm_compute in List.nth 33 (fst c) _. *) (* EqTr 8 42 [41;39] *)

 Definition s34 := Eval vm_compute in (step_checker s33 (List.nth 33 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s34. *) (* s34 = {| [9],[2; 10; 13],[8; 17; 19],[40],[0; 0; 0; 0; 0],[38],[32],[34],[39; 41; 42] |} *)

(*  Eval vm_compute in List.nth 34 (fst c) _. *) (* Res 3 {|8,5,3|} *)

 Definition s35 := Eval vm_compute in (step_checker s34 (List.nth 34 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s35. *) (* s35 = {| [9],[2; 10; 13],[8; 17; 19],[42],[0; 0; 0; 0; 0],[38],[32],[34],[39; 41; 42] |} *)

(*  Eval vm_compute in List.nth 35 (fst c) _. *) (* EqTr 5 44 [43;35] *)

 Definition s36 := Eval vm_compute in (step_checker s35 (List.nth 35 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s36. *) (* s36 = {| [9],[2; 10; 13],[8; 17; 19],[42],[0; 0; 0; 0; 0],[35; 43; 44],[32],[34],[39; 41; 42] |} *)

(*  Eval vm_compute in List.nth 36 (fst c) _. *) (* Res 3 {|5,7,3|} *)

 Definition s37 := Eval vm_compute in (step_checker s36 (List.nth 36 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s37. *) (* s37 = {| [9],[2; 10; 13],[8; 17; 19],[44],[0; 0; 0; 0; 0],[35; 43; 44],[32],[34],[39; 41; 42] |} *)

(*  Eval vm_compute in List.nth 37 (fst c) _. *) (* EqCgr 7 46 [S 45] *)

 Definition s38 := Eval vm_compute in (step_checker s37 (List.nth 37 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s38. *) (* s38 = {| [9],[2; 10; 13],[8; 17; 19],[44],[0; 0; 0; 0; 0],[35; 43; 44],[32],[45; 46],[39; 41; 42] |} *)

(*  Eval vm_compute in List.nth 38 (fst c) _. *) (* Res 3 {|7,3|} *)

 Definition s39 := Eval vm_compute in (step_checker s38 (List.nth 38 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s39. *) (* s39 = {| [9],[2; 10; 13],[8; 17; 19],[46],[0; 0; 0; 0; 0],[35; 43; 44],[32],[45; 46],[39; 41; 42] |} *)

(*  Eval vm_compute in List.nth 39 (fst c) _. *) (* EqTr 7 10 [47;7;33] *)

 Definition s40 := Eval vm_compute in (step_checker s39 (List.nth 39 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s40. *) (* s40 = {| [9],[2; 10; 13],[8; 17; 19],[46],[0; 0; 0; 0; 0],[35; 43; 44],[32],[7; 10; 33; 47],[39; 41; 42] |} *)

(*  Eval vm_compute in List.nth 40 (fst c) _. *) (* BuildDef2 5 48  *)

 Definition s41 := Eval vm_compute in (step_checker s40 (List.nth 40 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s41. *) (* s41 = {| [9],[2; 10; 13],[8; 17; 19],[46],[0; 0; 0; 0; 0],[6; 10; 48],[32],[7; 10; 33; 47],[39; 41; 42] |} *)

(*  Eval vm_compute in List.nth 41 (fst c) _. *) (* Res 5 {|7,5|} *)

 Definition s42 := Eval vm_compute in (step_checker s41 (List.nth 41 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s42. *) (* s42 = {| [9],[2; 10; 13],[8; 17; 19],[46],[0; 0; 0; 0; 0],[10; 33; 47; 48],[32],[7; 10; 33; 47],[39; 41; 42] |} *)

(*  Eval vm_compute in List.nth 42 (fst c) _. *) (* EqTr 7 6 [47;11;33] *)

 Definition s43 := Eval vm_compute in (step_checker s42 (List.nth 42 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s43. *) (* s43 = {| [9],[2; 10; 13],[8; 17; 19],[46],[0; 0; 0; 0; 0],[10; 33; 47; 48],[32],[6; 11; 33; 47],[39; 41; 42] |} *)

(*  Eval vm_compute in List.nth 43 (fst c) _. *) (* BuildDef 8 48  *)

 Definition s44 := Eval vm_compute in (step_checker s43 (List.nth 43 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s44. *) (* s44 = {| [9],[2; 10; 13],[8; 17; 19],[46],[0; 0; 0; 0; 0],[10; 33; 47; 48],[32],[6; 11; 33; 47],[7; 11; 48] |} *)

(*  Eval vm_compute in List.nth 44 (fst c) _. *) (* Res 8 {|7,8|} *)

 Definition s45 := Eval vm_compute in (step_checker s44 (List.nth 44 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s45. *) (* s45 = {| [9],[2; 10; 13],[8; 17; 19],[46],[0; 0; 0; 0; 0],[10; 33; 47; 48],[32],[6; 11; 33; 47],[11; 33; 47; 48] |} *)

(*  Eval vm_compute in List.nth 45 (fst c) _. *) (* Res 3 {|5,8,6,3|} *)

 Definition s46 := Eval vm_compute in (step_checker s45 (List.nth 45 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s46. *) (* s46 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0],[10; 33; 47; 48],[32],[6; 11; 33; 47],[11; 33; 47; 48] |} *)

(*  Eval vm_compute in List.nth 46 (fst c) _. *) (* BuildDef 6 9  *)

 Definition s47 := Eval vm_compute in (step_checker s46 (List.nth 46 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s47. *) (* s47 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0],[10; 33; 47; 48],[5; 6; 9],[6; 11; 33; 47],[11; 33; 47; 48] |} *)

(*  Eval vm_compute in List.nth 47 (fst c) _. *) (* BuildDef2 8 49  *)

 Definition s48 := Eval vm_compute in (step_checker s47 (List.nth 47 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s48. *) (* s48 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0],[10; 33; 47; 48],[5; 6; 9],[6; 11; 33; 47],[7; 10; 49] |} *)

(*  Eval vm_compute in List.nth 48 (fst c) _. *) (* Res 8 {|8,3|} *)

 Definition s49 := Eval vm_compute in (step_checker s48 (List.nth 48 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s49. *) (* s49 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0],[10; 33; 47; 48],[5; 6; 9],[6; 11; 33; 47],[7; 10] |} *)

(*  Eval vm_compute in List.nth 49 (fst c) _. *) (* BuildDef 5 31  *)

 Definition s50 := Eval vm_compute in (step_checker s49 (List.nth 49 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s50. *) (* s50 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0],[4; 15; 31],[5; 6; 9],[6; 11; 33; 47],[7; 10] |} *)

(*  Eval vm_compute in List.nth 50 (fst c) _. *) (* Res 5 {|5,4|} *)

 Definition s51 := Eval vm_compute in (step_checker s50 (List.nth 50 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s51. *) (* s51 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0],[5; 6; 9],[6; 11; 33; 47],[7; 10] |} *)

(*  Eval vm_compute in List.nth 51 (fst c) _. *) (* Res 5 {|6,8,5|} *)

 Definition s52 := Eval vm_compute in (step_checker s51 (List.nth 51 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s52. *) (* s52 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0],[5; 6; 9],[6; 11; 33; 47],[7; 10] |} *)

(*  Eval vm_compute in List.nth 52 (fst c) _. *) (* BuildProj 8 16 0  *)

 Definition s53 := Eval vm_compute in (step_checker s52 (List.nth 52 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s53. *) (* s53 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0],[5; 6; 9],[6; 11; 33; 47],[14; 16] |} *)

(*  Eval vm_compute in List.nth 53 (fst c) _. *) (* BuildProj 6 16 1  *)

 Definition s54 := Eval vm_compute in (step_checker s53 (List.nth 53 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s54. *) (* s54 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0],[11; 16],[6; 11; 33; 47],[14; 16] |} *)

(*  Eval vm_compute in List.nth 54 (fst c) _. *) (* Res 6 {|5,8,6|} *)

 Definition s55 := Eval vm_compute in (step_checker s54 (List.nth 54 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s55. *) (* s55 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[14; 16] |} *)

(*  Eval vm_compute in List.nth 55 (fst c) _. *) (* BuildDef 8 50  *)

 Definition s56 := Eval vm_compute in (step_checker s55 (List.nth 55 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s56. *) (* s56 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[9; 17; 50] |} *)

(*  Eval vm_compute in List.nth 56 (fst c) _. *) (* Res 8 {|6,8|} *)

 Definition s57 := Eval vm_compute in (step_checker s56 (List.nth 56 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s57. *) (* s57 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 57 (fst c) _. *) (* BuildDef 6 17  *)

 Definition s58 := Eval vm_compute in (step_checker s57 (List.nth 57 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s58. *) (* s58 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0],[10; 15; 17],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 58 (fst c) _. *) (* BuildDef2 5 31  *)

 Definition s59 := Eval vm_compute in (step_checker s58 (List.nth 58 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s59. *) (* s59 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0],[5; 14; 31],[10; 15; 17],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 59 (fst c) _. *) (* Res 4 {|5,4|} *)

 Definition s60 := Eval vm_compute in (step_checker s59 (List.nth 59 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s60. *) (* s60 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0; 0],[5; 14; 31],[10; 15; 17],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 60 (fst c) _. *) (* BuildDef 5 49  *)

 Definition s61 := Eval vm_compute in (step_checker s60 (List.nth 60 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s61. *) (* s61 = {| [9],[2; 10; 13],[8; 17; 19],[48],[0; 0; 0; 0; 0; 0],[6; 11; 49],[10; 15; 17],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 61 (fst c) _. *) (* Res 3 {|5,3|} *)

 Definition s62 := Eval vm_compute in (step_checker s61 (List.nth 61 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s62. *) (* s62 = {| [9],[2; 10; 13],[8; 17; 19],[6; 11],[0; 0; 0; 0; 0; 0],[6; 11; 49],[10; 15; 17],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 62 (fst c) _. *) (* Res 3 {|6,4,3|} *)

 Definition s63 := Eval vm_compute in (step_checker s62 (List.nth 62 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s63. *) (* s63 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0],[6; 11; 49],[10; 15; 17],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 63 (fst c) _. *) (* BuildProj 4 8 0  *)

 Definition s64 := Eval vm_compute in (step_checker s63 (List.nth 63 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s64. *) (* s64 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[4; 8],[6; 11; 49],[10; 15; 17],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 64 (fst c) _. *) (* BuildProj 6 8 1  *)

 Definition s65 := Eval vm_compute in (step_checker s64 (List.nth 64 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s65. *) (* s65 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[4; 8],[6; 11; 49],[7; 8],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 65 (fst c) _. *) (* Res 6 {|3,4,6|} *)

 Definition s66 := Eval vm_compute in (step_checker s65 (List.nth 65 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s66. *) (* s66 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[4; 8],[6; 11; 49],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 66 (fst c) _. *) (* BuildDef2 4 50  *)

 Definition s67 := Eval vm_compute in (step_checker s66 (List.nth 66 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s67. *) (* s67 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[8; 16; 50],[6; 11; 49],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 67 (fst c) _. *) (* Res 4 {|6,4|} *)

 Definition s68 := Eval vm_compute in (step_checker s67 (List.nth 67 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s68. *) (* s68 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 49],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 68 (fst c) _. *) (* Res 8 {|4,8|} *)

 Definition s69 := Eval vm_compute in (step_checker s68 (List.nth 68 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s69. *) (* s69 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 49],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 69 (fst c) _. *) (* BuildDef 4 51  *)

 Definition s70 := Eval vm_compute in (step_checker s69 (List.nth 69 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s70. *) (* s70 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[8; 17; 51],[6; 11; 49],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 70 (fst c) _. *) (* Res 4 {|4,8|} *)

 Definition s71 := Eval vm_compute in (step_checker s70 (List.nth 70 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s71. *) (* s71 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 49],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 71 (fst c) _. *) (* BuildDef 6 18  *)

 Definition s72 := Eval vm_compute in (step_checker s71 (List.nth 71 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s72. *) (* s72 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 49],[8; 16; 18],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 72 (fst c) _. *) (* Res 6 {|4,6|} *)

 Definition s73 := Eval vm_compute in (step_checker s72 (List.nth 72 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s73. *) (* s73 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 49],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 73 (fst c) _. *) (* BuildDef2 4 51  *)

 Definition s74 := Eval vm_compute in (step_checker s73 (List.nth 73 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s74. *) (* s74 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[9; 16; 51],[6; 11; 49],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 74 (fst c) _. *) (* Res 8 {|4,8|} *)

 Definition s75 := Eval vm_compute in (step_checker s74 (List.nth 74 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s75. *) (* s75 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[9; 16; 51],[6; 11; 49],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0] |} *)

(*  Eval vm_compute in List.nth 75 (fst c) _. *) (* BuildDef2 4 18  *)

 Definition s76 := Eval vm_compute in (step_checker s75 (List.nth 75 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s76. *) (* s76 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[9; 17; 18],[6; 11; 49],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0] |} *)

(*  Eval vm_compute in List.nth 76 (fst c) _. *) (* Res 4 {|8,4|} *)

 Definition s77 := Eval vm_compute in (step_checker s76 (List.nth 76 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s77. *) (* s77 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 49],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0] |} *)

(*  Eval vm_compute in List.nth 77 (fst c) _. *) (* Res 4 {|6,4|} *)

 Definition s78 := Eval vm_compute in (step_checker s77 (List.nth 77 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s78. *) (* s78 = {| [9],[2; 10; 13],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0] |} *)

(*  Eval vm_compute in List.nth 78 (fst c) _. *) (* Res 2 {|2,4,0|} *)

 Definition s79 := Eval vm_compute in (step_checker s78 (List.nth 78 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s79. *) (* s79 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 
                                               0; 
                                               0; 0],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0] |} *)

(*  Eval vm_compute in List.nth 79 (fst c) _. *) (* ImmBuildProj 2 2 0  *)

 Definition s80 := Eval vm_compute in (step_checker s79 (List.nth 79 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s80. *) (* s80 = {| [9],[2; 10; 13],[0],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0] |} *)

(*  Eval vm_compute in List.nth 80 (fst c) _. *) (* EqCgr 6 10 [S 15] *)

 Definition s81 := Eval vm_compute in (step_checker s80 (List.nth 80 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s81. *) (* s81 = {| [9],[2; 10; 13],[0],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[10; 15],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0] |} *)

(*  Eval vm_compute in List.nth 81 (fst c) _. *) (* Res 2 {|6,2|} *)

 Definition s82 := Eval vm_compute in (step_checker s81 (List.nth 81 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s82. *) (* s82 = {| [9],[2; 10; 13],[0; 0],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[10; 15],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0] |} *)

(*  Eval vm_compute in List.nth 82 (fst c) _. *) (* EqTr 6 52 [] *)

 Definition s83 := Eval vm_compute in (step_checker s82 (List.nth 82 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s83. *) (* s83 = {| [9],[2; 10; 13],[0; 0],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[52],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0] |} *)

(*  Eval vm_compute in List.nth 83 (fst c) _. *) (* BuildDef 8 54  *)

 Definition s84 := Eval vm_compute in (step_checker s83 (List.nth 83 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s84. *) (* s84 = {| [9],[2; 10; 13],[0; 0],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[52],[6; 11; 33; 47],[11; 53; 54] |} *)

(*  Eval vm_compute in List.nth 84 (fst c) _. *) (* EqTr 3 52 [] *)

 Definition s85 := Eval vm_compute in (step_checker s84 (List.nth 84 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s85. *) (* s85 = {| [9],[2; 10; 13],[0; 0],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[52],[6; 11; 33; 47],[11; 53; 54] |} *)

(*  Eval vm_compute in List.nth 85 (fst c) _. *) (* Res 8 {|3,8|} *)

 Definition s86 := Eval vm_compute in (step_checker s85 (List.nth 85 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s86. *) (* s86 = {| [9],[2; 10; 13],[0; 0],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[52],[6; 11; 33; 47],[11; 54] |} *)

(*  Eval vm_compute in List.nth 86 (fst c) _. *) (* Weaken 8 8 [53;54;11] *)

 Definition s87 := Eval vm_compute in (step_checker s86 (List.nth 86 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s87. *) (* s87 = {| [9],[2; 10; 13],[0; 0],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[52],[6; 11; 33; 47],[11; 53; 54] |} *)

(*  Eval vm_compute in List.nth 87 (fst c) _. *) (* Res 6 {|8,2,6|} *)

 Definition s88 := Eval vm_compute in (step_checker s87 (List.nth 87 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s88. *) (* s88 = {| [9],[2; 10; 13],[0; 0],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 0; 0; 0],[6; 11; 33; 47],[11; 53; 54] |} *)

(*  Eval vm_compute in List.nth 88 (fst c) _. *) (* BuildDef 2 55  *)

 Definition s89 := Eval vm_compute in (step_checker s88 (List.nth 88 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s89. *) (* s89 = {| [9],[2; 10; 13],[10; 53; 55],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 0; 0; 0],[6; 11; 33; 47],[11; 53; 54] |} *)

(*  Eval vm_compute in List.nth 89 (fst c) _. *) (* Res 2 {|2,6|} *)

 Definition s90 := Eval vm_compute in (step_checker s89 (List.nth 89 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s90. *) (* s90 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 0; 0; 0],[6; 11; 33; 47],[11; 53; 54] |} *)

(*  Eval vm_compute in List.nth 90 (fst c) _. *) (* BuildDef 8 56  *)

 Definition s91 := Eval vm_compute in (step_checker s90 (List.nth 90 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s91. *) (* s91 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 0; 0; 0],[6; 11; 33; 47],[10; 52; 56] |} *)

(*  Eval vm_compute in List.nth 91 (fst c) _. *) (* Res 8 {|2,8|} *)

 Definition s92 := Eval vm_compute in (step_checker s91 (List.nth 91 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s92. *) (* s92 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 92 (fst c) _. *) (* BuildDef2 2 55  *)

 Definition s93 := Eval vm_compute in (step_checker s92 (List.nth 92 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s93. *) (* s93 = {| [9],[2; 10; 13],[11; 52; 55],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 93 (fst c) _. *) (* Res 6 {|2,6|} *)

 Definition s94 := Eval vm_compute in (step_checker s93 (List.nth 93 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s94. *) (* s94 = {| [9],[2; 10; 13],[11; 52; 55],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 94 (fst c) _. *) (* BuildDef2 2 56  *)

 Definition s95 := Eval vm_compute in (step_checker s94 (List.nth 94 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s95. *) (* s95 = {| [9],[2; 10; 13],[11; 53; 56],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 95 (fst c) _. *) (* Res 2 {|6,2|} *)

 Definition s96 := Eval vm_compute in (step_checker s95 (List.nth 95 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s96. *) (* s96 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 96 (fst c) _. *) (* Res 2 {|8,2|} *)

 Definition s97 := Eval vm_compute in (step_checker s96 (List.nth 96 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s97. *) (* s97 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 0; 0; 0; 0],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 97 (fst c) _. *) (* BuildDef 8 58  *)

 Definition s98 := Eval vm_compute in (step_checker s97 (List.nth 97 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s98. *) (* s98 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 0; 0; 0; 0],[6; 11; 33; 47],[1; 53; 58] |} *)

(*  Eval vm_compute in List.nth 98 (fst c) _. *) (* BuildDef 6 66  *)

 Definition s99 := Eval vm_compute in (step_checker s98 (List.nth 98 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s99. *) (* s99 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 53; 66],[6; 11; 33; 47],[1; 53; 58] |} *)

(*  Eval vm_compute in List.nth 99 (fst c) _. *) (* Res 8 {|6,8|} *)

 Definition s100 := Eval vm_compute in (step_checker s99 (List.nth 99 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s100. *) (* s100 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 53; 66],[6; 11; 33; 47],[53; 58; 66] |} *)

(*  Eval vm_compute in List.nth 100 (fst c) _. *) (* BuildDef2 6 58  *)

 Definition s101 := Eval vm_compute in (step_checker s100 (List.nth 100 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s101. *) (* s101 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[52],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 52; 58],[6; 11; 33; 47],[53; 58; 66] |} *)

(*  Eval vm_compute in List.nth 101 (fst c) _. *) (* BuildDef 3 68  *)

 Definition s102 := Eval vm_compute in (step_checker s101 (List.nth 101 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s102. *) (* s102 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[1; 52; 68],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 52; 58],[6; 11; 33; 47],[53; 58; 66] |} *)

(*  Eval vm_compute in List.nth 102 (fst c) _. *) (* Res 6 {|3,6|} *)

 Definition s103 := Eval vm_compute in (step_checker s102 (List.nth 102 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s103. *) (* s103 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[1; 52; 68],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[52; 58; 68],[6; 11; 33; 47],[53; 58; 66] |} *)

(*  Eval vm_compute in List.nth 103 (fst c) _. *) (* Res 6 {|8,6|} *)

 Definition s104 := Eval vm_compute in (step_checker s103 (List.nth 103 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s104. *) (* s104 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[1; 52; 68],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[58; 66; 68],[6; 11; 33; 47],[53; 58; 66] |} *)

(*  Eval vm_compute in List.nth 104 (fst c) _. *) (* BuildDef 8 59  *)

 Definition s105 := Eval vm_compute in (step_checker s104 (List.nth 104 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s105. *) (* s105 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[1; 52; 68],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[58; 66; 68],[6; 11; 33; 47],[1; 52; 59] |} *)

(*  Eval vm_compute in List.nth 105 (fst c) _. *) (* Res 8 {|8,6|} *)

 Definition s106 := Eval vm_compute in (step_checker s105 (List.nth 105 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s106. *) (* s106 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[1; 52; 68],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[58; 66; 68],[6; 11; 33; 47],[1; 52; 66; 68] |} *)

(*  Eval vm_compute in List.nth 106 (fst c) _. *) (* BuildDef 3 60  *)

 Definition s107 := Eval vm_compute in (step_checker s106 (List.nth 106 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s107. *) (* s107 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 52; 60],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[58; 66; 68],[6; 11; 33; 47],[1; 52; 66; 68] |} *)

(*  Eval vm_compute in List.nth 107 (fst c) _. *) (* Res 3 {|8,3|} *)

 Definition s108 := Eval vm_compute in (step_checker s107 (List.nth 107 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s108. *) (* s108 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[52; 60; 66; 68],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[58; 66; 68],[6; 11; 33; 47],[1; 52; 66; 68] |} *)

(*  Eval vm_compute in List.nth 108 (fst c) _. *) (* BuildDef2 8 59  *)

 Definition s109 := Eval vm_compute in (step_checker s108 (List.nth 108 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s109. *) (* s109 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[52; 60; 66; 68],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[58; 66; 68],[6; 11; 33; 47],[0; 53; 59] |} *)

(*  Eval vm_compute in List.nth 109 (fst c) _. *) (* Res 6 {|8,6|} *)

 Definition s110 := Eval vm_compute in (step_checker s109 (List.nth 109 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s110. *) (* s110 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[52; 60; 66; 68],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 53; 66; 68],[6; 11; 33; 47],[0; 53; 59] |} *)

(*  Eval vm_compute in List.nth 110 (fst c) _. *) (* BuildDef2 8 60  *)

 Definition s111 := Eval vm_compute in (step_checker s110 (List.nth 110 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s111. *) (* s111 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[52; 60; 66; 68],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 53; 66; 68],[6; 11; 33; 47],[1; 53; 60] |} *)

(*  Eval vm_compute in List.nth 111 (fst c) _. *) (* Res 8 {|6,8|} *)

 Definition s112 := Eval vm_compute in (step_checker s111 (List.nth 111 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s112. *) (* s112 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[52; 60; 66; 68],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 53; 66; 68],[6; 11; 33; 47],[53; 60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 112 (fst c) _. *) (* Res 8 {|3,8|} *)

 Definition s113 := Eval vm_compute in (step_checker s112 (List.nth 112 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s113. *) (* s113 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[52; 60; 66; 68],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 53; 66; 68],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 113 (fst c) _. *) (* BuildDef 3 62  *)

 Definition s114 := Eval vm_compute in (step_checker s113 (List.nth 113 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s114. *) (* s114 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 3; 62],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 53; 66; 68],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 114 (fst c) _. *) (* BuildDef 6 70  *)

 Definition s115 := Eval vm_compute in (step_checker s114 (List.nth 114 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s115. *) (* s115 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 3; 62],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 2; 70],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 115 (fst c) _. *) (* Res 3 {|6,3|} *)

 Definition s116 := Eval vm_compute in (step_checker s115 (List.nth 115 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s116. *) (* s116 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 62; 70],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[0; 2; 70],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 116 (fst c) _. *) (* BuildDef2 6 62  *)

 Definition s117 := Eval vm_compute in (step_checker s116 (List.nth 116 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s117. *) (* s117 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 62; 70],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[6; 11; 49],[1; 2; 62],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 117 (fst c) _. *) (* BuildDef 5 72  *)

 Definition s118 := Eval vm_compute in (step_checker s117 (List.nth 117 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s118. *) (* s118 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 62; 70],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[1; 3; 72],[1; 2; 62],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 118 (fst c) _. *) (* Res 6 {|5,6|} *)

 Definition s119 := Eval vm_compute in (step_checker s118 (List.nth 118 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s119. *) (* s119 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 62; 70],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[1; 3; 72],[1; 62; 72],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 119 (fst c) _. *) (* Res 6 {|3,6|} *)

 Definition s120 := Eval vm_compute in (step_checker s119 (List.nth 119 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s120. *) (* s120 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 62; 70],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[1; 3; 72],[62; 70; 72],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 120 (fst c) _. *) (* BuildDef 3 61  *)

 Definition s121 := Eval vm_compute in (step_checker s120 (List.nth 120 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s121. *) (* s121 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 53; 61],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[1; 3; 72],[62; 70; 72],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 121 (fst c) _. *) (* Res 3 {|3,8|} *)

 Definition s122 := Eval vm_compute in (step_checker s121 (List.nth 121 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s122. *) (* s122 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 53; 66; 68],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[1; 3; 72],[62; 70; 72],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 122 (fst c) _. *) (* BuildDef 5 63  *)

 Definition s123 := Eval vm_compute in (step_checker s122 (List.nth 122 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s123. *) (* s123 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 53; 66; 68],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[1; 3; 63],[62; 70; 72],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 123 (fst c) _. *) (* Res 5 {|5,6|} *)

 Definition s124 := Eval vm_compute in (step_checker s123 (List.nth 123 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s124. *) (* s124 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 53; 66; 68],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[1; 3; 70; 72],[62; 70; 72],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 124 (fst c) _. *) (* Res 5 {|3,5|} *)

 Definition s125 := Eval vm_compute in (step_checker s124 (List.nth 124 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s125. *) (* s125 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 53; 66; 68],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[3; 53; 66; 68; 70; 72],[62; 70; 72],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 125 (fst c) _. *) (* BuildDef2 3 64  *)

 Definition s126 := Eval vm_compute in (step_checker s125 (List.nth 125 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s126. *) (* s126 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[2; 53; 64],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[3; 53; 66; 68; 70; 72],[62; 70; 72],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 126 (fst c) _. *) (* Res 3 {|5,3|} *)

 Definition s127 := Eval vm_compute in (step_checker s126 (List.nth 126 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s127. *) (* s127 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[53; 64; 66; 68; 70; 72],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[3; 53; 66; 68; 70; 72],[62; 70; 72],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 127 (fst c) _. *) (* BuildDef2 5 61  *)

 Definition s128 := Eval vm_compute in (step_checker s127 (List.nth 127 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s128. *) (* s128 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[53; 64; 66; 68; 70; 72],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[1; 52; 61],[62; 70; 72],[6; 11; 33; 47],[60; 66; 68] |} *)

(*  Eval vm_compute in List.nth 128 (fst c) _. *) (* Res 8 {|5,8|} *)

 Definition s129 := Eval vm_compute in (step_checker s128 (List.nth 128 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s129. *) (* s129 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[53; 64; 66; 68; 70; 72],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[1; 52; 61],[62; 70; 72],[6; 11; 33; 47],[1; 52; 66; 68] |} *)

(*  Eval vm_compute in List.nth 129 (fst c) _. *) (* BuildDef2 5 63  *)

 Definition s130 := Eval vm_compute in (step_checker s129 (List.nth 129 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s130. *) (* s130 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[53; 64; 66; 68; 70; 72],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[62; 70; 72],[6; 11; 33; 47],[1; 52; 66; 68] |} *)

(*  Eval vm_compute in List.nth 130 (fst c) _. *) (* Res 6 {|5,6|} *)

 Definition s131 := Eval vm_compute in (step_checker s130 (List.nth 130 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s131. *) (* s131 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[53; 64; 66; 68; 70; 72],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[0; 2; 70; 72],[6; 11; 33; 47],[1; 52; 66; 68] |} *)

(*  Eval vm_compute in List.nth 131 (fst c) _. *) (* Res 6 {|8,6|} *)

 Definition s132 := Eval vm_compute in (step_checker s131 (List.nth 131 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s132. *) (* s132 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[53; 64; 66; 68; 70; 72],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 66; 68; 70; 72],[6; 11; 33; 47],[1; 52; 66; 68] |} *)

(*  Eval vm_compute in List.nth 132 (fst c) _. *) (* BuildDef 8 64  *)

 Definition s133 := Eval vm_compute in (step_checker s132 (List.nth 132 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s133. *) (* s133 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[53; 64; 66; 68; 70; 72],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 66; 68; 70; 72],[6; 11; 33; 47],[3; 52; 64] |} *)

(*  Eval vm_compute in List.nth 133 (fst c) _. *) (* Res 8 {|6,8|} *)

 Definition s134 := Eval vm_compute in (step_checker s133 (List.nth 133 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s134. *) (* s134 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[53; 64; 66; 68; 70; 72],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 66; 68; 70; 72],[6; 11; 33; 47],[52; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 134 (fst c) _. *) (* Res 8 {|3,8|} *)

 Definition s135 := Eval vm_compute in (step_checker s134 (List.nth 134 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s135. *) (* s135 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[53; 64; 66; 68; 70; 72],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 66; 68; 70; 72],[6; 11; 33; 47],[64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 135 (fst c) _. *) (* BuildDef 3 57  *)

 Definition s136 := Eval vm_compute in (step_checker s135 (List.nth 135 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s136. *) (* s136 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[11; 52; 57],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 66; 68; 70; 72],[6; 11; 33; 47],[64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 136 (fst c) _. *) (* Res 3 {|3,2|} *)

 Definition s137 := Eval vm_compute in (step_checker s136 (List.nth 136 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s137. *) (* s137 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 66; 68; 70; 72],[6; 11; 33; 47],[64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 137 (fst c) _. *) (* BuildDef 6 65  *)

 Definition s138 := Eval vm_compute in (step_checker s137 (List.nth 137 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s138. *) (* s138 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[3; 53; 65],[6; 11; 33; 47],[64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 138 (fst c) _. *) (* Res 6 {|6,8|} *)

 Definition s139 := Eval vm_compute in (step_checker s138 (List.nth 138 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s139. *) (* s139 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[3; 53; 66; 68; 70; 72],[6; 11; 33; 47],[64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 139 (fst c) _. *) (* Res 6 {|3,6|} *)

 Definition s140 := Eval vm_compute in (step_checker s139 (List.nth 139 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s140. *) (* s140 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 140 (fst c) _. *) (* BuildDef2 3 12  *)

 Definition s141 := Eval vm_compute in (step_checker s140 (List.nth 140 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s141. *) (* s141 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[2; 11; 12],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 141 (fst c) _. *) (* Res 3 {|6,3|} *)

 Definition s142 := Eval vm_compute in (step_checker s141 (List.nth 141 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s142. *) (* s142 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[0; 0; 0; 0; 0; 0; 0; 0; 0],[6; 11; 33; 47],[64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 142 (fst c) _. *) (* BuildDef2 6 57  *)

 Definition s143 := Eval vm_compute in (step_checker s142 (List.nth 142 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s143. *) (* s143 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[10; 53; 57],[6; 11; 33; 47],[64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 143 (fst c) _. *) (* Res 2 {|6,2|} *)

 Definition s144 := Eval vm_compute in (step_checker s143 (List.nth 143 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s144. *) (* s144 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[10; 53; 57],[6; 11; 33; 47],[64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 144 (fst c) _. *) (* BuildDef2 6 65  *)

 Definition s145 := Eval vm_compute in (step_checker s144 (List.nth 144 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s145. *) (* s145 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 145 (fst c) _. *) (* Res 8 {|6,8|} *)

 Definition s146 := Eval vm_compute in (step_checker s145 (List.nth 145 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s146. *) (* s146 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[2; 52; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 146 (fst c) _. *) (* Res 8 {|2,8|} *)

 Definition s147 := Eval vm_compute in (step_checker s146 (List.nth 146 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s147. *) (* s147 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 147 (fst c) _. *) (* BuildDef 2 12  *)

 Definition s148 := Eval vm_compute in (step_checker s147 (List.nth 147 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s148. *) (* s148 = {| [9],[2; 10; 13],[3; 10; 12],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 148 (fst c) _. *) (* Res 2 {|8,2|} *)

 Definition s149 := Eval vm_compute in (step_checker s148 (List.nth 148 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s149. *) (* s149 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 149 (fst c) _. *) (* Res 2 {|3,2|} *)

 Definition s150 := Eval vm_compute in (step_checker s149 (List.nth 149 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s150. *) (* s150 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 150 (fst c) _. *) (* BuildDef2 3 19  *)

 Definition s151 := Eval vm_compute in (step_checker s150 (List.nth 150 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s151. *) (* s151 = {| [9],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 151 (fst c) _. *) (* Res 0 {|3,4,0|} *)

 Definition s152 := Eval vm_compute in (step_checker s151 (List.nth 151 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s152. *) (* s152 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 
                                               0; 
                                               0; 0],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 152 (fst c) _. *) (* ImmBuildProj 0 0 1  *)

 Definition s153 := Eval vm_compute in (step_checker s152 (List.nth 152 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s153. *) (* s153 = {| [0],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 153 (fst c) _. *) (* Res 0 {|1,2,0|} *)

 Definition s154 := Eval vm_compute in (step_checker s153 (List.nth 153 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s154. *) (* s154 = {| [0; 0],[2; 10; 13],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 154 (fst c) _. *) (* CFalse 2  *)

 Definition s155 := Eval vm_compute in (step_checker s154 (List.nth 154 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s155. *) (* s155 = {| [0; 0],[2; 10; 13],[3],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 155 (fst c) _. *) (* Res 2 {|0,2|} *)

 Definition s156 := Eval vm_compute in (step_checker s155 (List.nth 155 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s156. *) (* s156 = {| [0; 0],[2; 10; 13],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 156 (fst c) _. *) (* BuildProj 0 73 0  *)

 Definition s157 := Eval vm_compute in (step_checker s156 (List.nth 156 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s157. *) (* s157 = {| [2; 73],[2; 10; 13],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 157 (fst c) _. *) (* Res 0 {|2,0|} *)

 Definition s158 := Eval vm_compute in (step_checker s157 (List.nth 157 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s158. *) (* s158 = {| [0; 0; 0; 0],[2; 10; 13],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 158 (fst c) _. *) (* Weaken 0 0 [66;68;70;2;1] *)

 Definition s159 := Eval vm_compute in (step_checker s158 (List.nth 158 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s159. *) (* s159 = {| [0],[2; 10; 13],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 159 (fst c) _. *) (* CFalse 1  *)

 Definition s160 := Eval vm_compute in (step_checker s159 (List.nth 159 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s160. *) (* s160 = {| [0],[3],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 160 (fst c) _. *) (* Res 1 {|0,1|} *)

 Definition s161 := Eval vm_compute in (step_checker s160 (List.nth 160 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s161. *) (* s161 = {| [0],[0; 0],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 161 (fst c) _. *) (* BuildProj 0 73 1  *)

 Definition s162 := Eval vm_compute in (step_checker s161 (List.nth 161 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s162. *) (* s162 = {| [0; 73],[0; 0],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 162 (fst c) _. *) (* Res 0 {|2,0|} *)

 Definition s163 := Eval vm_compute in (step_checker s162 (List.nth 162 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s163. *) (* s163 = {| [0; 0; 0; 0],[0; 0],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 163 (fst c) _. *) (* Res 0 {|1,0|} *)

 Definition s164 := Eval vm_compute in (step_checker s163 (List.nth 163 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s164. *) (* s164 = {| [0; 0; 0],[0; 0],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 164 (fst c) _. *) (* BuildProj 1 71 0  *)

 Definition s165 := Eval vm_compute in (step_checker s164 (List.nth 164 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s165. *) (* s165 = {| [0; 0; 0],[1; 71],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 165 (fst c) _. *) (* Res 1 {|0,1|} *)

 Definition s166 := Eval vm_compute in (step_checker s165 (List.nth 165 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s166. *) (* s166 = {| [0; 0; 0],[0; 0; 71],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 166 (fst c) _. *) (* BuildProj 2 74 0  *)

 Definition s167 := Eval vm_compute in (step_checker s166 (List.nth 166 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s167. *) (* s167 = {| [0; 0; 0],[0; 0; 71],[0; 74],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 167 (fst c) _. *) (* Res 2 {|1,2|} *)

 Definition s168 := Eval vm_compute in (step_checker s167 (List.nth 167 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s168. *) (* s168 = {| [0; 0; 0],[0; 0; 71],[0; 0; 71; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 168 (fst c) _. *) (* BuildDef 1 75  *)

 Definition s169 := Eval vm_compute in (step_checker s168 (List.nth 168 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s169. *) (* s169 = {| [0; 0; 0],[1; 2; 75],[0; 0; 71; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 169 (fst c) _. *) (* Res 2 {|1,2|} *)

 Definition s170 := Eval vm_compute in (step_checker s169 (List.nth 169 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s170. *) (* s170 = {| [0; 0; 0],[1; 2; 75],[0; 2; 71; 0; 75],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 170 (fst c) _. *) (* CTrue 1  *)

 Definition s171 := Eval vm_compute in (step_checker s170 (List.nth 170 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s171. *) (* s171 = {| [0; 0; 0],[0],[0; 2; 71; 0; 75],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 171 (fst c) _. *) (* Res 1 {|2,1|} *)

 Definition s172 := Eval vm_compute in (step_checker s171 (List.nth 171 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s172. *) (* s172 = {| [0; 0; 0],[0; 0],[0; 2; 71; 0; 75],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 172 (fst c) _. *) (* BuildProj 2 71 1  *)

 Definition s173 := Eval vm_compute in (step_checker s172 (List.nth 172 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s173. *) (* s173 = {| [0; 0; 0],[0; 0],[3; 71],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 173 (fst c) _. *) (* Res 2 {|0,2|} *)

 Definition s174 := Eval vm_compute in (step_checker s173 (List.nth 173 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s174. *) (* s174 = {| [0; 0; 0],[0; 0],[0; 0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 174 (fst c) _. *) (* Res 2 {|1,2|} *)

 Definition s175 := Eval vm_compute in (step_checker s174 (List.nth 174 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s175. *) (* s175 = {| [0; 0; 0],[0; 0],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 175 (fst c) _. *) (* EqTr 1 52 [] *)

 Definition s176 := Eval vm_compute in (step_checker s175 (List.nth 175 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s176. *) (* s176 = {| [0; 0; 0],[52],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 176 (fst c) _. *) (* BuildProj 0 69 1  *)

 Definition s177 := Eval vm_compute in (step_checker s176 (List.nth 176 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s177. *) (* s177 = {| [53; 69],[52],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 177 (fst c) _. *) (* Res 0 {|2,0|} *)

 Definition s178 := Eval vm_compute in (step_checker s177 (List.nth 177 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s178. *) (* s178 = {| [0; 0; 0; 0],[52],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 178 (fst c) _. *) (* Res 0 {|1,0|} *)

 Definition s179 := Eval vm_compute in (step_checker s178 (List.nth 178 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s179. *) (* s179 = {| [0; 0; 0; 0; 0],[52],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 179 (fst c) _. *) (* CTrue 1  *)

 Definition s180 := Eval vm_compute in (step_checker s179 (List.nth 179 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s180. *) (* s180 = {| [0; 0; 0; 0; 0],[0],[0; 0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 180 (fst c) _. *) (* BuildProj 2 67 1  *)

 Definition s181 := Eval vm_compute in (step_checker s180 (List.nth 180 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s181. *) (* s181 = {| [0; 0; 0; 0; 0],[0],[1; 67],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 181 (fst c) _. *) (* Res 2 {|0,2|} *)

 Definition s182 := Eval vm_compute in (step_checker s181 (List.nth 181 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s182. *) (* s182 = {| [0; 0; 0; 0; 0],[0],[0; 0; 0; 0; 67],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)

(*  Eval vm_compute in List.nth 182 (fst c) _. *) (* Res 2 {|1,2|} *)

 Definition s183 := Eval vm_compute in (step_checker s182 (List.nth 182 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s183. *) (* s183 = {| [0; 0; 0; 0; 0],[0],[0; 0],[8; 17; 19],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 0],[0; 2; 63],[2; 52; 65],[6; 11; 33; 47],[0; 0; 0; 0; 0; 0; 0; 0; 0] |} *)
End test8cvc5debug.