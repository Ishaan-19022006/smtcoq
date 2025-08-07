Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool. 
Require Import Int31. 
Local Open Scope int31_scope.

Section test6cvc5debug. 

 Parse_certif_verit t_i t_func t_atom t_form root used_roots trace 
 "test6cvc5/test6cvc5.smt2" 
 "test6cvc5/test6cvc5.pf". 

 Definition nclauses := Eval vm_compute in (match trace with Certif a _ _ => a end). (* Size of the state *)
(*  Print nclauses. *) (* 10 *)

  Definition c := Eval vm_compute in (match trace with Certif _ a _ => a end). (* Certificate *)
 Definition conf := Eval vm_compute in (match trace with Certif _ _ a => a end). (* Look here in the state for the empty clause*)
(*  Print conf. *) (* 7 *)

(*  Eval vm_compute in List.length (fst c). (* No. of steps in certificate *) *) (* 234 *)

(*  Eval vm_compute in (Form.check_form t_form && Atom.check_atom t_atom && Atom.wt t_i t_func t_atom). *) (* true *)

 (* States from c *) 

(* Start state *) 

 Definition s0 := Eval vm_compute in (add_roots (S.make nclauses) root used_roots). 
(*   Print s0. *) (* s0 = {| [11] |} *)

(*  Eval vm_compute in List.nth 0 (fst c) _. *) (* BuildDef2 1 15  *)

 Definition s1 := Eval vm_compute in (step_checker s0 (List.nth 0 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s1. *) (* s1 = {| [11],[10; 13; 15] |} *)

(*  Eval vm_compute in List.nth 1 (fst c) _. *) (* BuildDef2 2 24  *)

 Definition s2 := Eval vm_compute in (step_checker s1 (List.nth 1 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s2. *) (* s2 = {| [11],[10; 13; 15],[10; 24] |} *)

(*  Eval vm_compute in List.nth 2 (fst c) _. *) (* Weaken 2 2 [24;10] *)

 Definition s3 := Eval vm_compute in (step_checker s2 (List.nth 2 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s3. *) (* s3 = {| [11],[10; 13; 15],[10; 24] |} *)

(*  Eval vm_compute in List.nth 3 (fst c) _. *) (* BuildDef 3 24  *)

 Definition s4 := Eval vm_compute in (step_checker s3 (List.nth 3 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s4. *) (* s4 = {| [11],[10; 13; 15],[10; 24],[11; 24] |} *)

(*  Eval vm_compute in List.nth 4 (fst c) _. *) (* Weaken 3 3 [24;11] *)

 Definition s5 := Eval vm_compute in (step_checker s4 (List.nth 4 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s5. *) (* s5 = {| [11],[10; 13; 15],[10; 24],[11; 24] |} *)

(*  Eval vm_compute in List.nth 5 (fst c) _. *) (* Res 3 {|2,3|} *)

 Definition s6 := Eval vm_compute in (step_checker s5 (List.nth 5 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s6. *) (* s6 = {| [11],[10; 13; 15],[10; 24],[24] |} *)

(*  Eval vm_compute in List.nth 6 (fst c) _. *) (* BuildDef 2 26  *)

 Definition s7 := Eval vm_compute in (step_checker s6 (List.nth 6 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s7. *) (* s7 = {| [11],[10; 13; 15],[10; 26],[24] |} *)

(*  Eval vm_compute in List.nth 7 (fst c) _. *) (* Weaken 2 2 [25;26;10] *)

 Definition s8 := Eval vm_compute in (step_checker s7 (List.nth 7 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s8. *) (* s8 = {| [11],[10; 13; 15],[10; 25; 26],[24] |} *)

(*  Eval vm_compute in List.nth 8 (fst c) _. *) (* Res 2 {|2,3|} *)

 Definition s9 := Eval vm_compute in (step_checker s8 (List.nth 8 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s9. *) (* s9 = {| [11],[10; 13; 15],[10; 26],[24] |} *)

(*  Eval vm_compute in List.nth 9 (fst c) _. *) (* BuildDef2 4 26  *)

 Definition s10 := Eval vm_compute in (step_checker s9 (List.nth 9 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s10. *) (* s10 = {| [11],[10; 13; 15],[10; 26],[24],[11; 26] |} *)

(*  Eval vm_compute in List.nth 10 (fst c) _. *) (* Weaken 4 4 [25;26;11] *)

 Definition s11 := Eval vm_compute in (step_checker s10 (List.nth 10 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s11. *) (* s11 = {| [11],[10; 13; 15],[10; 26],[24],[11; 25; 26] |} *)

(*  Eval vm_compute in List.nth 11 (fst c) _. *) (* Res 3 {|4,3|} *)

 Definition s12 := Eval vm_compute in (step_checker s11 (List.nth 11 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s12. *) (* s12 = {| [11],[10; 13; 15],[10; 26],[11; 26],[11; 25; 26] |} *)

(*  Eval vm_compute in List.nth 12 (fst c) _. *) (* Res 3 {|2,3|} *)

 Definition s13 := Eval vm_compute in (step_checker s12 (List.nth 12 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s13. *) (* s13 = {| [11],[10; 13; 15],[10; 26],[26],[11; 25; 26] |} *)

(*  Eval vm_compute in List.nth 13 (fst c) _. *) (* Weaken 2 0 [27;11] *)

 Definition s14 := Eval vm_compute in (step_checker s13 (List.nth 13 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s14. *) (* s14 = {| [11],[10; 13; 15],[11; 27],[26],[11; 25; 26] |} *)

(*  Eval vm_compute in List.nth 14 (fst c) _. *) (* Res 3 {|2,3|} *)

 Definition s15 := Eval vm_compute in (step_checker s14 (List.nth 14 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s15. *) (* s15 = {| [11],[10; 13; 15],[11; 27],[11],[11; 25; 26] |} *)

(*  Eval vm_compute in List.nth 15 (fst c) _. *) (* ImmBuildProj 3 3 0  *)

 Definition s16 := Eval vm_compute in (step_checker s15 (List.nth 15 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s16. *) (* s16 = {| [11],[10; 13; 15],[11; 27],[4],[11; 25; 26] |} *)

(*  Eval vm_compute in List.nth 16 (fst c) _. *) (* EqTr 2 28 [] *)

 Definition s17 := Eval vm_compute in (step_checker s16 (List.nth 16 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s17. *) (* s17 = {| [11],[10; 13; 15],[28],[4],[11; 25; 26] |} *)

(*  Eval vm_compute in List.nth 17 (fst c) _. *) (* BuildDef 4 30  *)

 Definition s18 := Eval vm_compute in (step_checker s17 (List.nth 17 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s18. *) (* s18 = {| [11],[10; 13; 15],[28],[4],[5; 29; 30] |} *)

(*  Eval vm_compute in List.nth 18 (fst c) _. *) (* EqTr 5 28 [] *)

 Definition s19 := Eval vm_compute in (step_checker s18 (List.nth 18 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s19. *) (* s19 = {| [11],[10; 13; 15],[28],[4],[5; 29; 30],[28] |} *)

(*  Eval vm_compute in List.nth 19 (fst c) _. *) (* Res 4 {|5,4|} *)

 Definition s20 := Eval vm_compute in (step_checker s19 (List.nth 19 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s20. *) (* s20 = {| [11],[10; 13; 15],[28],[4],[5; 30],[28] |} *)

(*  Eval vm_compute in List.nth 20 (fst c) _. *) (* Weaken 4 4 [29;30;5] *)

 Definition s21 := Eval vm_compute in (step_checker s20 (List.nth 20 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s21. *) (* s21 = {| [11],[10; 13; 15],[28],[4],[5; 29; 30],[28] |} *)

(*  Eval vm_compute in List.nth 21 (fst c) _. *) (* Res 2 {|4,3,2|} *)

 Definition s22 := Eval vm_compute in (step_checker s21 (List.nth 21 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s22. *) (* s22 = {| [11],[10; 13; 15],[30],[4],[5; 29; 30],[28] |} *)

(*  Eval vm_compute in List.nth 22 (fst c) _. *) (* BuildDef 4 31  *)

 Definition s23 := Eval vm_compute in (step_checker s22 (List.nth 22 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s23. *) (* s23 = {| [11],[10; 13; 15],[30],[4],[4; 29; 31],[28] |} *)

(*  Eval vm_compute in List.nth 23 (fst c) _. *) (* Res 4 {|4,2|} *)

 Definition s24 := Eval vm_compute in (step_checker s23 (List.nth 23 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s24. *) (* s24 = {| [11],[10; 13; 15],[30],[4],[4; 29],[28] |} *)

(*  Eval vm_compute in List.nth 24 (fst c) _. *) (* BuildDef 5 32  *)

 Definition s25 := Eval vm_compute in (step_checker s24 (List.nth 24 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s25. *) (* s25 = {| [11],[10; 13; 15],[30],[4],[4; 29],[4; 28; 32] |} *)

(*  Eval vm_compute in List.nth 25 (fst c) _. *) (* Res 5 {|4,5|} *)

 Definition s26 := Eval vm_compute in (step_checker s25 (List.nth 25 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s26. *) (* s26 = {| [11],[10; 13; 15],[30],[4],[4; 29],[4; 32] |} *)

(*  Eval vm_compute in List.nth 26 (fst c) _. *) (* BuildDef2 4 31  *)

 Definition s27 := Eval vm_compute in (step_checker s26 (List.nth 26 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s27. *) (* s27 = {| [11],[10; 13; 15],[30],[4],[5; 28; 31],[4; 32] |} *)

(*  Eval vm_compute in List.nth 27 (fst c) _. *) (* Res 2 {|4,2|} *)

 Definition s28 := Eval vm_compute in (step_checker s27 (List.nth 27 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s28. *) (* s28 = {| [11],[10; 13; 15],[5; 28],[4],[5; 28; 31],[4; 32] |} *)

(*  Eval vm_compute in List.nth 28 (fst c) _. *) (* BuildDef2 4 32  *)

 Definition s29 := Eval vm_compute in (step_checker s28 (List.nth 28 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s29. *) (* s29 = {| [11],[10; 13; 15],[5; 28],[4],[5; 29; 32],[4; 32] |} *)

(*  Eval vm_compute in List.nth 29 (fst c) _. *) (* Res 4 {|2,4|} *)

 Definition s30 := Eval vm_compute in (step_checker s29 (List.nth 29 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s30. *) (* s30 = {| [11],[10; 13; 15],[5; 28],[4],[5; 32],[4; 32] |} *)

(*  Eval vm_compute in List.nth 30 (fst c) _. *) (* Res 4 {|5,4|} *)

 Definition s31 := Eval vm_compute in (step_checker s30 (List.nth 30 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s31. *) (* s31 = {| [11],[10; 13; 15],[5; 28],[4],[32],[4; 32] |} *)

(*  Eval vm_compute in List.nth 31 (fst c) _. *) (* EqCgrP 5 9 6 [S 5] *)

 Definition s32 := Eval vm_compute in (step_checker s31 (List.nth 31 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s32. *) (* s32 = {| [11],[10; 13; 15],[5; 28],[4],[32],[5; 6; 9] |} *)

(*  Eval vm_compute in List.nth 32 (fst c) _. *) (* BuildDef2 2 34  *)

 Definition s33 := Eval vm_compute in (step_checker s32 (List.nth 32 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s33. *) (* s33 = {| [11],[10; 13; 15],[6; 8; 34],[4],[32],[5; 6; 9] |} *)

(*  Eval vm_compute in List.nth 33 (fst c) _. *) (* Res 2 {|5,2|} *)

 Definition s34 := Eval vm_compute in (step_checker s33 (List.nth 33 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s34. *) (* s34 = {| [11],[10; 13; 15],[5; 6; 34],[4],[32],[5; 6; 9] |} *)

(*  Eval vm_compute in List.nth 34 (fst c) _. *) (* EqCgrP 5 7 8 [S 5] *)

 Definition s35 := Eval vm_compute in (step_checker s34 (List.nth 34 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s35. *) (* s35 = {| [11],[10; 13; 15],[5; 6; 34],[4],[32],[5; 7; 8] |} *)

(*  Eval vm_compute in List.nth 35 (fst c) _. *) (* BuildDef 6 34  *)

 Definition s36 := Eval vm_compute in (step_checker s35 (List.nth 35 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s36. *) (* s36 = {| [11],[10; 13; 15],[5; 6; 34],[4],[32],[5; 7; 8],[7; 9; 34] |} *)

(*  Eval vm_compute in List.nth 36 (fst c) _. *) (* Res 6 {|5,6|} *)

 Definition s37 := Eval vm_compute in (step_checker s36 (List.nth 36 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s37. *) (* s37 = {| [11],[10; 13; 15],[5; 6; 34],[4],[32],[5; 7; 8],[5; 7; 34] |} *)

(*  Eval vm_compute in List.nth 37 (fst c) _. *) (* Res 3 {|2,6,3|} *)

 Definition s38 := Eval vm_compute in (step_checker s37 (List.nth 37 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s38. *) (* s38 = {| [11],[10; 13; 15],[5; 6; 34],[34],[32],[5; 7; 8],[5; 7; 34] |} *)

(*  Eval vm_compute in List.nth 38 (fst c) _. *) (* BuildDef 6 11  *)

 Definition s39 := Eval vm_compute in (step_checker s38 (List.nth 38 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s39. *) (* s39 = {| [11],[10; 13; 15],[5; 6; 34],[34],[32],[5; 7; 8],[5; 7; 8; 11] |} *)

(*  Eval vm_compute in List.nth 39 (fst c) _. *) (* BuildDef2 2 35  *)

 Definition s40 := Eval vm_compute in (step_checker s39 (List.nth 39 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s40. *) (* s40 = {| [11],[10; 13; 15],[6; 9; 35],[34],[32],[5; 7; 8],[5; 7; 8; 11] |} *)

(*  Eval vm_compute in List.nth 40 (fst c) _. *) (* Res 2 {|2,3|} *)

 Definition s41 := Eval vm_compute in (step_checker s40 (List.nth 40 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s41. *) (* s41 = {| [11],[10; 13; 15],[6; 9],[34],[32],[5; 7; 8],[5; 7; 8; 11] |} *)

(*  Eval vm_compute in List.nth 41 (fst c) _. *) (* BuildDef2 5 33  *)

 Definition s42 := Eval vm_compute in (step_checker s41 (List.nth 41 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s42. *) (* s42 = {| [11],[10; 13; 15],[6; 9],[34],[32],[4; 29; 33],[5; 7; 8; 11] |} *)

(*  Eval vm_compute in List.nth 42 (fst c) _. *) (* Res 5 {|5,4|} *)

 Definition s43 := Eval vm_compute in (step_checker s42 (List.nth 42 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s43. *) (* s43 = {| [11],[10; 13; 15],[6; 9],[34],[32],[4; 29],[5; 7; 8; 11] |} *)

(*  Eval vm_compute in List.nth 43 (fst c) _. *) (* BuildProj 7 36 2  *)

 Definition s44 := Eval vm_compute in (step_checker s43 (List.nth 43 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s44. *) (* s44 = {| [11],[10; 13; 15],[6; 9],[34],[32],[4; 29],[5; 7; 8; 11],[7; 36] |} *)

(*  Eval vm_compute in List.nth 44 (fst c) _. *) (* BuildProj 8 36 1  *)

 Definition s45 := Eval vm_compute in (step_checker s44 (List.nth 44 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s45. *) (* s45 = {| [11],[10; 13; 15],[6; 9],[34],[32],[4; 29],[5; 7; 8; 11],[7; 36],[6; 36] |} *)

(*  Eval vm_compute in List.nth 45 (fst c) _. *) (* BuildProj 9 36 0  *)

 Definition s46 := Eval vm_compute in (step_checker s45 (List.nth 45 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s46. *) (* s46 = {| [11],[10; 13; 15],[6; 9],[34],[32],[4; 29],[5; 7; 8; 11],[7; 36],[6; 36],[28; 36] |} *)

(*  Eval vm_compute in List.nth 46 (fst c) _. *) (* Res 9 {|6,2,5,7,8,9|} *)

 Definition s47 := Eval vm_compute in (step_checker s46 (List.nth 46 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s47. *) (* s47 = {| [11],[10; 13; 15],[6; 9],[34],[32],[4; 29],[5; 7; 8; 11],[7; 36],[6; 36],[8; 9; 11; 0; 36] |} *)

(*  Eval vm_compute in List.nth 47 (fst c) _. *) (* BuildDef2 8 38  *)

 Definition s48 := Eval vm_compute in (step_checker s47 (List.nth 47 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s48. *) (* s48 = {| [11],[10; 13; 15],[6; 9],[34],[32],[4; 29],[5; 7; 8; 11],[7; 36],[10; 36; 38],[8; 9; 11; 0; 36] |} *)

(*  Eval vm_compute in List.nth 48 (fst c) _. *) (* Res 8 {|9,8|} *)

 Definition s49 := Eval vm_compute in (step_checker s48 (List.nth 48 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s49. *) (* s49 = {| [11],[10; 13; 15],[6; 9],[34],[32],[4; 29],[5; 7; 8; 11],[7; 36],[8; 9; 0; 36; 38],[8; 9; 11; 0; 36] |} *)

(*  Eval vm_compute in List.nth 49 (fst c) _. *) (* BuildDef 9 35  *)

 Definition s50 := Eval vm_compute in (step_checker s49 (List.nth 49 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s50. *) (* s50 = {| [11],[10; 13; 15],[6; 9],[34],[32],[4; 29],[5; 7; 8; 11],[7; 36],[8; 9; 0; 36; 38],[7; 8; 35] |} *)

(*  Eval vm_compute in List.nth 50 (fst c) _. *) (* Res 3 {|9,3|} *)

 Definition s51 := Eval vm_compute in (step_checker s50 (List.nth 50 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s51. *) (* s51 = {| [11],[10; 13; 15],[6; 9],[7; 8],[32],[4; 29],[5; 7; 8; 11],[7; 36],[8; 9; 0; 36; 38],[7; 8; 35] |} *)

(*  Eval vm_compute in List.nth 51 (fst c) _. *) (* BuildDef 9 33  *)

 Definition s52 := Eval vm_compute in (step_checker s51 (List.nth 51 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s52. *) (* s52 = {| [11],[10; 13; 15],[6; 9],[7; 8],[32],[4; 29],[5; 7; 8; 11],[7; 36],[8; 9; 0; 36; 38],[5; 28; 33] |} *)

(*  Eval vm_compute in List.nth 52 (fst c) _. *) (* Res 4 {|9,4|} *)

 Definition s53 := Eval vm_compute in (step_checker s52 (List.nth 52 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s53. *) (* s53 = {| [11],[10; 13; 15],[6; 9],[7; 8],[5; 28],[4; 29],[5; 7; 8; 11],[7; 36],[8; 9; 0; 36; 38],[5; 28; 33] |} *)

(*  Eval vm_compute in List.nth 53 (fst c) _. *) (* BuildProj 9 10 2  *)

 Definition s54 := Eval vm_compute in (step_checker s53 (List.nth 53 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s54. *) (* s54 = {| [11],[10; 13; 15],[6; 9],[7; 8],[5; 28],[4; 29],[5; 7; 8; 11],[7; 36],[8; 9; 0; 36; 38],[9; 10] |} *)

(*  Eval vm_compute in List.nth 54 (fst c) _. *) (* BuildProj 7 10 1  *)

 Definition s55 := Eval vm_compute in (step_checker s54 (List.nth 54 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s55. *) (* s55 = {| [11],[10; 13; 15],[6; 9],[7; 8],[5; 28],[4; 29],[5; 7; 8; 11],[6; 10],[8; 9; 0; 36; 38],[9; 10] |} *)

(*  Eval vm_compute in List.nth 55 (fst c) _. *) (* BuildProj 5 10 0  *)

 Definition s56 := Eval vm_compute in (step_checker s55 (List.nth 55 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s56. *) (* s56 = {| [11],[10; 13; 15],[6; 9],[7; 8],[5; 28],[4; 10],[5; 7; 8; 11],[6; 10],[8; 9; 0; 36; 38],[9; 10] |} *)

(*  Eval vm_compute in List.nth 56 (fst c) _. *) (* Weaken 3 3 [37;29;8;7] *)

 Definition s57 := Eval vm_compute in (step_checker s56 (List.nth 56 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s57. *) (* s57 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[4; 10],[5; 7; 8; 11],[6; 10],[8; 9; 0; 36; 38],[9; 10] |} *)

(*  Eval vm_compute in List.nth 57 (fst c) _. *) (* Res 5 {|3,4,9,7,5|} *)

 Definition s58 := Eval vm_compute in (step_checker s57 (List.nth 57 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s58. *) (* s58 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[10; 37],[5; 7; 8; 11],[6; 10],[8; 9; 0; 36; 38],[9; 10] |} *)

(*  Eval vm_compute in List.nth 58 (fst c) _. *) (* BuildDef 7 38  *)

 Definition s59 := Eval vm_compute in (step_checker s58 (List.nth 58 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s59. *) (* s59 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[10; 37],[5; 7; 8; 11],[11; 37; 38],[8; 9; 0; 36; 38],[9; 10] |} *)

(*  Eval vm_compute in List.nth 59 (fst c) _. *) (* Res 7 {|5,7|} *)

 Definition s60 := Eval vm_compute in (step_checker s59 (List.nth 59 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s60. *) (* s60 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[10; 37],[5; 7; 8; 11],[37; 38],[8; 9; 0; 36; 38],[9; 10] |} *)

(*  Eval vm_compute in List.nth 60 (fst c) _. *) (* Res 7 {|8,7|} *)

 Definition s61 := Eval vm_compute in (step_checker s60 (List.nth 60 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s61. *) (* s61 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[10; 37],[5; 7; 8; 11],[8; 9; 0; 38],[8; 9; 0; 36; 38],[9; 10] |} *)

(*  Eval vm_compute in List.nth 61 (fst c) _. *) (* BuildDef 8 39  *)

 Definition s62 := Eval vm_compute in (step_checker s61 (List.nth 61 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s62. *) (* s62 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[10; 37],[5; 7; 8; 11],[8; 9; 0; 38],[10; 37; 39],[9; 10] |} *)

(*  Eval vm_compute in List.nth 62 (fst c) _. *) (* Res 8 {|8,7|} *)

 Definition s63 := Eval vm_compute in (step_checker s62 (List.nth 62 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s63. *) (* s63 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[10; 37],[5; 7; 8; 11],[8; 9; 0; 38],[8; 9; 0; 10; 37],[9; 10] |} *)

(*  Eval vm_compute in List.nth 63 (fst c) _. *) (* BuildDef 5 40  *)

 Definition s64 := Eval vm_compute in (step_checker s63 (List.nth 63 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s64. *) (* s64 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[10; 36; 40],[5; 7; 8; 11],[8; 9; 0; 38],[8; 9; 0; 10; 37],[9; 10] |} *)

(*  Eval vm_compute in List.nth 64 (fst c) _. *) (* Res 5 {|8,5|} *)

 Definition s65 := Eval vm_compute in (step_checker s64 (List.nth 64 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s65. *) (* s65 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[8; 9; 0; 10; 40],[5; 7; 8; 11],[8; 9; 0; 38],[8; 9; 0; 10; 37],[9; 10] |} *)

(*  Eval vm_compute in List.nth 65 (fst c) _. *) (* BuildDef2 8 39  *)

 Definition s66 := Eval vm_compute in (step_checker s65 (List.nth 65 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s66. *) (* s66 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[8; 9; 0; 10; 40],[5; 7; 8; 11],[8; 9; 0; 38],[11; 36; 39],[9; 10] |} *)

(*  Eval vm_compute in List.nth 66 (fst c) _. *) (* Res 7 {|8,7|} *)

 Definition s67 := Eval vm_compute in (step_checker s66 (List.nth 66 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s67. *) (* s67 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[8; 9; 0; 10; 40],[5; 7; 8; 11],[8; 9; 0; 11; 36],[11; 36; 39],[9; 10] |} *)

(*  Eval vm_compute in List.nth 67 (fst c) _. *) (* BuildDef2 8 40  *)

 Definition s68 := Eval vm_compute in (step_checker s67 (List.nth 67 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s68. *) (* s68 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[8; 9; 0; 10; 40],[5; 7; 8; 11],[8; 9; 0; 11; 36],[11; 37; 40],[9; 10] |} *)

(*  Eval vm_compute in List.nth 68 (fst c) _. *) (* Res 8 {|7,8|} *)

 Definition s69 := Eval vm_compute in (step_checker s68 (List.nth 68 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s69. *) (* s69 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[8; 9; 0; 10; 40],[5; 7; 8; 11],[8; 9; 0; 11; 36],[8; 9; 0; 11; 40],[9; 10] |} *)

(*  Eval vm_compute in List.nth 69 (fst c) _. *) (* Res 8 {|5,8|} *)

 Definition s70 := Eval vm_compute in (step_checker s69 (List.nth 69 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s70. *) (* s70 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[8; 9; 0; 10; 40],[5; 7; 8; 11],[8; 9; 0; 11; 36],[8; 9; 0; 40],[9; 10] |} *)

(*  Eval vm_compute in List.nth 70 (fst c) _. *) (* BuildDef 5 42  *)

 Definition s71 := Eval vm_compute in (step_checker s70 (List.nth 70 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s71. *) (* s71 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[1; 29; 42],[5; 7; 8; 11],[8; 9; 0; 11; 36],[8; 9; 0; 40],[9; 10] |} *)

(*  Eval vm_compute in List.nth 71 (fst c) _. *) (* BuildDef 7 62  *)

 Definition s72 := Eval vm_compute in (step_checker s71 (List.nth 71 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s72. *) (* s72 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[1; 29; 42],[5; 7; 8; 11],[0; 29; 62],[8; 9; 0; 40],[9; 10] |} *)

(*  Eval vm_compute in List.nth 72 (fst c) _. *) (* Res 5 {|7,5|} *)

 Definition s73 := Eval vm_compute in (step_checker s72 (List.nth 72 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s73. *) (* s73 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[29; 42; 62],[5; 7; 8; 11],[0; 29; 62],[8; 9; 0; 40],[9; 10] |} *)

(*  Eval vm_compute in List.nth 73 (fst c) _. *) (* BuildDef2 7 42  *)

 Definition s74 := Eval vm_compute in (step_checker s73 (List.nth 73 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s74. *) (* s74 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[29; 42; 62],[5; 7; 8; 11],[0; 28; 42],[8; 9; 0; 40],[9; 10] |} *)

(*  Eval vm_compute in List.nth 74 (fst c) _. *) (* BuildDef 9 64  *)

 Definition s75 := Eval vm_compute in (step_checker s74 (List.nth 74 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s75. *) (* s75 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[29; 42; 62],[5; 7; 8; 11],[0; 28; 42],[8; 9; 0; 40],[1; 28; 64] |} *)

(*  Eval vm_compute in List.nth 75 (fst c) _. *) (* Res 7 {|9,7|} *)

 Definition s76 := Eval vm_compute in (step_checker s75 (List.nth 75 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s76. *) (* s76 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[29; 42; 62],[5; 7; 8; 11],[28; 42; 64],[8; 9; 0; 40],[1; 28; 64] |} *)

(*  Eval vm_compute in List.nth 76 (fst c) _. *) (* Res 7 {|5,7|} *)

 Definition s77 := Eval vm_compute in (step_checker s76 (List.nth 76 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s77. *) (* s77 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[29; 42; 62],[5; 7; 8; 11],[42; 62; 64],[8; 9; 0; 40],[1; 28; 64] |} *)

(*  Eval vm_compute in List.nth 77 (fst c) _. *) (* BuildDef 5 43  *)

 Definition s78 := Eval vm_compute in (step_checker s77 (List.nth 77 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s78. *) (* s78 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[1; 28; 43],[5; 7; 8; 11],[42; 62; 64],[8; 9; 0; 40],[1; 28; 64] |} *)

(*  Eval vm_compute in List.nth 78 (fst c) _. *) (* Res 5 {|5,7|} *)

 Definition s79 := Eval vm_compute in (step_checker s78 (List.nth 78 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s79. *) (* s79 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[1; 28; 62; 64],[5; 7; 8; 11],[42; 62; 64],[8; 9; 0; 40],[1; 28; 64] |} *)

(*  Eval vm_compute in List.nth 79 (fst c) _. *) (* BuildDef 9 44  *)

 Definition s80 := Eval vm_compute in (step_checker s79 (List.nth 79 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s80. *) (* s80 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[1; 28; 62; 64],[5; 7; 8; 11],[42; 62; 64],[8; 9; 0; 40],[0; 28; 44] |} *)

(*  Eval vm_compute in List.nth 80 (fst c) _. *) (* Res 9 {|5,9|} *)

 Definition s81 := Eval vm_compute in (step_checker s80 (List.nth 80 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s81. *) (* s81 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[1; 28; 62; 64],[5; 7; 8; 11],[42; 62; 64],[8; 9; 0; 40],[28; 44; 62; 64] |} *)

(*  Eval vm_compute in List.nth 81 (fst c) _. *) (* BuildDef2 5 43  *)

 Definition s82 := Eval vm_compute in (step_checker s81 (List.nth 81 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s82. *) (* s82 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[0; 29; 43],[5; 7; 8; 11],[42; 62; 64],[8; 9; 0; 40],[28; 44; 62; 64] |} *)

(*  Eval vm_compute in List.nth 82 (fst c) _. *) (* Res 7 {|5,7|} *)

 Definition s83 := Eval vm_compute in (step_checker s82 (List.nth 82 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s83. *) (* s83 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[0; 29; 43],[5; 7; 8; 11],[0; 29; 62; 64],[8; 9; 0; 40],[28; 44; 62; 64] |} *)

(*  Eval vm_compute in List.nth 83 (fst c) _. *) (* BuildDef2 5 44  *)

 Definition s84 := Eval vm_compute in (step_checker s83 (List.nth 83 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s84. *) (* s84 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[1; 29; 44],[5; 7; 8; 11],[0; 29; 62; 64],[8; 9; 0; 40],[28; 44; 62; 64] |} *)

(*  Eval vm_compute in List.nth 84 (fst c) _. *) (* Res 5 {|7,5|} *)

 Definition s85 := Eval vm_compute in (step_checker s84 (List.nth 84 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s85. *) (* s85 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[29; 44; 62; 64],[5; 7; 8; 11],[0; 29; 62; 64],[8; 9; 0; 40],[28; 44; 62; 64] |} *)

(*  Eval vm_compute in List.nth 85 (fst c) _. *) (* Res 5 {|9,5|} *)

 Definition s86 := Eval vm_compute in (step_checker s85 (List.nth 85 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s86. *) (* s86 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[44; 62; 64],[5; 7; 8; 11],[0; 29; 62; 64],[8; 9; 0; 40],[28; 44; 62; 64] |} *)

(*  Eval vm_compute in List.nth 86 (fst c) _. *) (* BuildDef 9 46  *)

 Definition s87 := Eval vm_compute in (step_checker s86 (List.nth 86 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s87. *) (* s87 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[44; 62; 64],[5; 7; 8; 11],[0; 29; 62; 64],[8; 9; 0; 40],[0; 3; 46] |} *)

(*  Eval vm_compute in List.nth 87 (fst c) _. *) (* BuildDef 7 66  *)

 Definition s88 := Eval vm_compute in (step_checker s87 (List.nth 87 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s88. *) (* s88 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[44; 62; 64],[5; 7; 8; 11],[0; 2; 66],[8; 9; 0; 40],[0; 3; 46] |} *)

(*  Eval vm_compute in List.nth 88 (fst c) _. *) (* Res 9 {|7,9|} *)

 Definition s89 := Eval vm_compute in (step_checker s88 (List.nth 88 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s89. *) (* s89 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[44; 62; 64],[5; 7; 8; 11],[0; 2; 66],[8; 9; 0; 40],[0; 46; 66] |} *)

(*  Eval vm_compute in List.nth 89 (fst c) _. *) (* BuildDef2 7 46  *)

 Definition s90 := Eval vm_compute in (step_checker s89 (List.nth 89 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s90. *) (* s90 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[5; 28],[44; 62; 64],[5; 7; 8; 11],[1; 2; 46],[8; 9; 0; 40],[0; 46; 66] |} *)

(*  Eval vm_compute in List.nth 90 (fst c) _. *) (* BuildDef 4 68  *)

 Definition s91 := Eval vm_compute in (step_checker s90 (List.nth 90 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s91. *) (* s91 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[1; 3; 68],[44; 62; 64],[5; 7; 8; 11],[1; 2; 46],[8; 9; 0; 40],[0; 46; 66] |} *)

(*  Eval vm_compute in List.nth 91 (fst c) _. *) (* Res 7 {|4,7|} *)

 Definition s92 := Eval vm_compute in (step_checker s91 (List.nth 91 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s92. *) (* s92 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[1; 3; 68],[44; 62; 64],[5; 7; 8; 11],[1; 46; 68],[8; 9; 0; 40],[0; 46; 66] |} *)

(*  Eval vm_compute in List.nth 92 (fst c) _. *) (* Res 7 {|9,7|} *)

 Definition s93 := Eval vm_compute in (step_checker s92 (List.nth 92 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s93. *) (* s93 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[1; 3; 68],[44; 62; 64],[5; 7; 8; 11],[46; 66; 68],[8; 9; 0; 40],[0; 46; 66] |} *)

(*  Eval vm_compute in List.nth 93 (fst c) _. *) (* BuildDef 9 45  *)

 Definition s94 := Eval vm_compute in (step_checker s93 (List.nth 93 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s94. *) (* s94 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[1; 3; 68],[44; 62; 64],[5; 7; 8; 11],[46; 66; 68],[8; 9; 0; 40],[0; 29; 45] |} *)

(*  Eval vm_compute in List.nth 94 (fst c) _. *) (* Res 9 {|9,5|} *)

 Definition s95 := Eval vm_compute in (step_checker s94 (List.nth 94 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s95. *) (* s95 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[1; 3; 68],[44; 62; 64],[5; 7; 8; 11],[46; 66; 68],[8; 9; 0; 40],[0; 29; 62; 64] |} *)

(*  Eval vm_compute in List.nth 95 (fst c) _. *) (* BuildDef 4 47  *)

 Definition s96 := Eval vm_compute in (step_checker s95 (List.nth 95 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s96. *) (* s96 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[1; 3; 47],[44; 62; 64],[5; 7; 8; 11],[46; 66; 68],[8; 9; 0; 40],[0; 29; 62; 64] |} *)

(*  Eval vm_compute in List.nth 96 (fst c) _. *) (* Res 4 {|4,7|} *)

 Definition s97 := Eval vm_compute in (step_checker s96 (List.nth 96 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s97. *) (* s97 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[1; 3; 66; 68],[44; 62; 64],[5; 7; 8; 11],[46; 66; 68],[8; 9; 0; 40],[0; 29; 62; 64] |} *)

(*  Eval vm_compute in List.nth 97 (fst c) _. *) (* Res 4 {|9,4|} *)

 Definition s98 := Eval vm_compute in (step_checker s97 (List.nth 97 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s98. *) (* s98 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[3; 29; 62; 64; 66; 68],[44; 62; 64],[5; 7; 8; 11],[46; 66; 68],[8; 9; 0; 40],[0; 29; 62; 64] |} *)

(*  Eval vm_compute in List.nth 98 (fst c) _. *) (* BuildDef2 9 48  *)

 Definition s99 := Eval vm_compute in (step_checker s98 (List.nth 98 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s99. *) (* s99 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[3; 29; 62; 64; 66; 68],[44; 62; 64],[5; 7; 8; 11],[46; 66; 68],[8; 9; 0; 40],[2; 29; 48] |} *)

(*  Eval vm_compute in List.nth 99 (fst c) _. *) (* Res 9 {|4,9|} *)

 Definition s100 := Eval vm_compute in (step_checker s99 (List.nth 99 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s100. *) (* s100 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[3; 29; 62; 64; 66; 68],[44; 62; 64],[5; 7; 8; 11],[46; 66; 68],[8; 9; 0; 40],[29; 48; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 100 (fst c) _. *) (* BuildDef2 4 45  *)

 Definition s101 := Eval vm_compute in (step_checker s100 (List.nth 100 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s101. *) (* s101 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[1; 28; 45],[44; 62; 64],[5; 7; 8; 11],[46; 66; 68],[8; 9; 0; 40],[29; 48; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 101 (fst c) _. *) (* Res 5 {|4,5|} *)

 Definition s102 := Eval vm_compute in (step_checker s101 (List.nth 101 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s102. *) (* s102 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[1; 28; 45],[1; 28; 62; 64],[5; 7; 8; 11],[46; 66; 68],[8; 9; 0; 40],[29; 48; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 102 (fst c) _. *) (* BuildDef2 4 47  *)

 Definition s103 := Eval vm_compute in (step_checker s102 (List.nth 102 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s103. *) (* s103 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[0; 2; 47],[1; 28; 62; 64],[5; 7; 8; 11],[46; 66; 68],[8; 9; 0; 40],[29; 48; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 103 (fst c) _. *) (* Res 7 {|4,7|} *)

 Definition s104 := Eval vm_compute in (step_checker s103 (List.nth 103 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s104. *) (* s104 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[0; 2; 47],[1; 28; 62; 64],[5; 7; 8; 11],[0; 2; 66; 68],[8; 9; 0; 40],[29; 48; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 104 (fst c) _. *) (* Res 7 {|5,7|} *)

 Definition s105 := Eval vm_compute in (step_checker s104 (List.nth 104 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s105. *) (* s105 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[0; 2; 47],[1; 28; 62; 64],[5; 7; 8; 11],[2; 28; 62; 64; 66; 68],[8; 9; 0; 40],[29; 48; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 105 (fst c) _. *) (* BuildDef 5 48  *)

 Definition s106 := Eval vm_compute in (step_checker s105 (List.nth 105 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s106. *) (* s106 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[0; 2; 47],[3; 28; 48],[5; 7; 8; 11],[2; 28; 62; 64; 66; 68],[8; 9; 0; 40],[29; 48; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 106 (fst c) _. *) (* Res 5 {|7,5|} *)

 Definition s107 := Eval vm_compute in (step_checker s106 (List.nth 106 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s107. *) (* s107 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[0; 2; 47],[28; 48; 62; 64; 66; 68],[5; 7; 8; 11],[2; 28; 62; 64; 66; 68],[8; 9; 0; 40],[29; 48; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 107 (fst c) _. *) (* Res 5 {|9,5|} *)

 Definition s108 := Eval vm_compute in (step_checker s107 (List.nth 107 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s108. *) (* s108 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[0; 2; 47],[48; 62; 64; 66; 68],[5; 7; 8; 11],[2; 28; 62; 64; 66; 68],[8; 9; 0; 40],[29; 48; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 108 (fst c) _. *) (* BuildDef2 9 49  *)

 Definition s109 := Eval vm_compute in (step_checker s108 (List.nth 108 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s109. *) (* s109 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[0; 2; 47],[48; 62; 64; 66; 68],[5; 7; 8; 11],[2; 28; 62; 64; 66; 68],[8; 9; 0; 40],[2; 28; 49] |} *)

(*  Eval vm_compute in List.nth 109 (fst c) _. *) (* Res 9 {|9,5|} *)

 Definition s110 := Eval vm_compute in (step_checker s109 (List.nth 109 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s110. *) (* s110 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[0; 2; 47],[48; 62; 64; 66; 68],[5; 7; 8; 11],[2; 28; 62; 64; 66; 68],[8; 9; 0; 40],[2; 28; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 110 (fst c) _. *) (* BuildProj 7 52 2  *)

 Definition s111 := Eval vm_compute in (step_checker s110 (List.nth 110 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s111. *) (* s111 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[0; 2; 47],[48; 62; 64; 66; 68],[5; 7; 8; 11],[7; 52],[8; 9; 0; 40],[2; 28; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 111 (fst c) _. *) (* BuildProj 4 52 1  *)

 Definition s112 := Eval vm_compute in (step_checker s111 (List.nth 111 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s112. *) (* s112 = {| [11],[10; 13; 15],[6; 9],[7; 8; 29; 37],[6; 52],[48; 62; 64; 66; 68],[5; 7; 8; 11],[7; 52],[8; 9; 0; 40],[2; 28; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 112 (fst c) _. *) (* BuildProj 3 52 0  *)

 Definition s113 := Eval vm_compute in (step_checker s112 (List.nth 112 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s113. *) (* s113 = {| [11],[10; 13; 15],[6; 9],[3; 52],[6; 52],[48; 62; 64; 66; 68],[5; 7; 8; 11],[7; 52],[8; 9; 0; 40],[2; 28; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 113 (fst c) _. *) (* Weaken 7 7 [37;29;52;7] *)

 Definition s114 := Eval vm_compute in (step_checker s113 (List.nth 113 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s114. *) (* s114 = {| [11],[10; 13; 15],[6; 9],[3; 52],[6; 52],[48; 62; 64; 66; 68],[5; 7; 8; 11],[7; 29; 37; 52],[8; 9; 0; 40],[2; 28; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 114 (fst c) _. *) (* Res 3 {|7,9,4,3|} *)

 Definition s115 := Eval vm_compute in (step_checker s114 (List.nth 114 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s115. *) (* s115 = {| [11],[10; 13; 15],[6; 9],[37; 52; 62; 64; 66; 68],[6; 52],[48; 62; 64; 66; 68],[5; 7; 8; 11],[7; 29; 37; 52],[8; 9; 0; 40],[2; 28; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 115 (fst c) _. *) (* BuildDef2 4 54  *)

 Definition s116 := Eval vm_compute in (step_checker s115 (List.nth 115 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s116. *) (* s116 = {| [11],[10; 13; 15],[6; 9],[37; 52; 62; 64; 66; 68],[36; 52; 54],[48; 62; 64; 66; 68],[5; 7; 8; 11],[7; 29; 37; 52],[8; 9; 0; 40],[2; 28; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 116 (fst c) _. *) (* Res 4 {|3,4|} *)

 Definition s117 := Eval vm_compute in (step_checker s116 (List.nth 116 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s117. *) (* s117 = {| [11],[10; 13; 15],[6; 9],[37; 52; 62; 64; 66; 68],[52; 54; 62; 64; 66; 68],[48; 62; 64; 66; 68],[5; 7; 8; 11],[7; 29; 37; 52],[8; 9; 0; 40],[2; 28; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 117 (fst c) _. *) (* BuildDef 3 49  *)

 Definition s118 := Eval vm_compute in (step_checker s117 (List.nth 117 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s118. *) (* s118 = {| [11],[10; 13; 15],[6; 9],[3; 29; 49],[52; 54; 62; 64; 66; 68],[48; 62; 64; 66; 68],[5; 7; 8; 11],[7; 29; 37; 52],[8; 9; 0; 40],[2; 28; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 118 (fst c) _. *) (* Res 5 {|3,5|} *)

 Definition s119 := Eval vm_compute in (step_checker s118 (List.nth 118 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s119. *) (* s119 = {| [11],[10; 13; 15],[6; 9],[3; 29; 49],[52; 54; 62; 64; 66; 68],[3; 29; 62; 64; 66; 68],[5; 7; 8; 11],[7; 29; 37; 52],[8; 9; 0; 40],[2; 28; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 119 (fst c) _. *) (* BuildProj 3 36 2  *)

 Definition s120 := Eval vm_compute in (step_checker s119 (List.nth 119 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s120. *) (* s120 = {| [11],[10; 13; 15],[6; 9],[7; 36],[52; 54; 62; 64; 66; 68],[3; 29; 62; 64; 66; 68],[5; 7; 8; 11],[7; 29; 37; 52],[8; 9; 0; 40],[2; 28; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 120 (fst c) _. *) (* BuildProj 9 36 1  *)

 Definition s121 := Eval vm_compute in (step_checker s120 (List.nth 120 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s121. *) (* s121 = {| [11],[10; 13; 15],[6; 9],[7; 36],[52; 54; 62; 64; 66; 68],[3; 29; 62; 64; 66; 68],[5; 7; 8; 11],[7; 29; 37; 52],[8; 9; 0; 40],[6; 36] |} *)

(*  Eval vm_compute in List.nth 121 (fst c) _. *) (* BuildProj 7 36 0  *)

 Definition s122 := Eval vm_compute in (step_checker s121 (List.nth 121 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s122. *) (* s122 = {| [11],[10; 13; 15],[6; 9],[7; 36],[52; 54; 62; 64; 66; 68],[3; 29; 62; 64; 66; 68],[5; 7; 8; 11],[28; 36],[8; 9; 0; 40],[6; 36] |} *)

(*  Eval vm_compute in List.nth 122 (fst c) _. *) (* Weaken 3 3 [53;2;36;7] *)

 Definition s123 := Eval vm_compute in (step_checker s122 (List.nth 122 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s123. *) (* s123 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[52; 54; 62; 64; 66; 68],[3; 29; 62; 64; 66; 68],[5; 7; 8; 11],[28; 36],[8; 9; 0; 40],[6; 36] |} *)

(*  Eval vm_compute in List.nth 123 (fst c) _. *) (* Res 7 {|3,5,9,7|} *)

 Definition s124 := Eval vm_compute in (step_checker s123 (List.nth 123 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s124. *) (* s124 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[52; 54; 62; 64; 66; 68],[3; 29; 62; 64; 66; 68],[5; 7; 8; 11],[36; 53; 62; 64; 66; 68],[8; 9; 0; 40],[6; 36] |} *)

(*  Eval vm_compute in List.nth 124 (fst c) _. *) (* BuildDef 9 54  *)

 Definition s125 := Eval vm_compute in (step_checker s124 (List.nth 124 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s125. *) (* s125 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[52; 54; 62; 64; 66; 68],[3; 29; 62; 64; 66; 68],[5; 7; 8; 11],[36; 53; 62; 64; 66; 68],[8; 9; 0; 40],[37; 53; 54] |} *)

(*  Eval vm_compute in List.nth 125 (fst c) _. *) (* Res 9 {|7,9|} *)

 Definition s126 := Eval vm_compute in (step_checker s125 (List.nth 125 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s126. *) (* s126 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[52; 54; 62; 64; 66; 68],[3; 29; 62; 64; 66; 68],[5; 7; 8; 11],[36; 53; 62; 64; 66; 68],[8; 9; 0; 40],[53; 54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 126 (fst c) _. *) (* Res 9 {|4,9|} *)

 Definition s127 := Eval vm_compute in (step_checker s126 (List.nth 126 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s127. *) (* s127 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[52; 54; 62; 64; 66; 68],[3; 29; 62; 64; 66; 68],[5; 7; 8; 11],[36; 53; 62; 64; 66; 68],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 127 (fst c) _. *) (* BuildDef 4 56  *)

 Definition s128 := Eval vm_compute in (step_checker s127 (List.nth 127 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s128. *) (* s128 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[13; 53; 56],[3; 29; 62; 64; 66; 68],[5; 7; 8; 11],[36; 53; 62; 64; 66; 68],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 128 (fst c) _. *) (* BuildDef 7 70  *)

 Definition s129 := Eval vm_compute in (step_checker s128 (List.nth 128 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s129. *) (* s129 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[13; 53; 56],[3; 29; 62; 64; 66; 68],[5; 7; 8; 11],[12; 53; 70],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 129 (fst c) _. *) (* Res 4 {|7,4|} *)

 Definition s130 := Eval vm_compute in (step_checker s129 (List.nth 129 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s130. *) (* s130 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[53; 56; 70],[3; 29; 62; 64; 66; 68],[5; 7; 8; 11],[12; 53; 70],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 130 (fst c) _. *) (* BuildDef2 7 56  *)

 Definition s131 := Eval vm_compute in (step_checker s130 (List.nth 130 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s131. *) (* s131 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[53; 56; 70],[3; 29; 62; 64; 66; 68],[5; 7; 8; 11],[12; 52; 56],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 131 (fst c) _. *) (* BuildDef 5 72  *)

 Definition s132 := Eval vm_compute in (step_checker s131 (List.nth 131 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s132. *) (* s132 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[53; 56; 70],[13; 52; 72],[5; 7; 8; 11],[12; 52; 56],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 132 (fst c) _. *) (* Res 7 {|5,7|} *)

 Definition s133 := Eval vm_compute in (step_checker s132 (List.nth 132 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s133. *) (* s133 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[53; 56; 70],[13; 52; 72],[5; 7; 8; 11],[52; 56; 72],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 133 (fst c) _. *) (* Res 7 {|4,7|} *)

 Definition s134 := Eval vm_compute in (step_checker s133 (List.nth 133 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s134. *) (* s134 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[53; 56; 70],[13; 52; 72],[5; 7; 8; 11],[56; 70; 72],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 134 (fst c) _. *) (* BuildDef 4 55  *)

 Definition s135 := Eval vm_compute in (step_checker s134 (List.nth 134 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s135. *) (* s135 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[36; 53; 55],[13; 52; 72],[5; 7; 8; 11],[56; 70; 72],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 135 (fst c) _. *) (* Res 4 {|4,9|} *)

 Definition s136 := Eval vm_compute in (step_checker s135 (List.nth 135 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s136. *) (* s136 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[36; 53; 62; 64; 66; 68],[13; 52; 72],[5; 7; 8; 11],[56; 70; 72],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 136 (fst c) _. *) (* BuildDef 5 57  *)

 Definition s137 := Eval vm_compute in (step_checker s136 (List.nth 136 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s137. *) (* s137 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[36; 53; 62; 64; 66; 68],[13; 52; 57],[5; 7; 8; 11],[56; 70; 72],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 137 (fst c) _. *) (* Res 5 {|5,7|} *)

 Definition s138 := Eval vm_compute in (step_checker s137 (List.nth 137 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s138. *) (* s138 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[36; 53; 62; 64; 66; 68],[13; 52; 70; 72],[5; 7; 8; 11],[56; 70; 72],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 138 (fst c) _. *) (* Res 5 {|4,5|} *)

 Definition s139 := Eval vm_compute in (step_checker s138 (List.nth 138 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s139. *) (* s139 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[36; 53; 62; 64; 66; 68],[13; 36; 62; 64; 66; 68; 70; 72],[5; 7; 8; 11],[56; 70; 72],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 139 (fst c) _. *) (* BuildDef2 4 58  *)

 Definition s140 := Eval vm_compute in (step_checker s139 (List.nth 139 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s140. *) (* s140 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[12; 36; 58],[13; 36; 62; 64; 66; 68; 70; 72],[5; 7; 8; 11],[56; 70; 72],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 140 (fst c) _. *) (* Res 4 {|5,4|} *)

 Definition s141 := Eval vm_compute in (step_checker s140 (List.nth 140 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s141. *) (* s141 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[36; 58; 62; 64; 66; 68; 70; 72],[13; 36; 62; 64; 66; 68; 70; 72],[5; 7; 8; 11],[56; 70; 72],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 141 (fst c) _. *) (* BuildDef2 5 55  *)

 Definition s142 := Eval vm_compute in (step_checker s141 (List.nth 141 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s142. *) (* s142 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[36; 58; 62; 64; 66; 68; 70; 72],[37; 52; 55],[5; 7; 8; 11],[56; 70; 72],[8; 9; 0; 40],[54; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 142 (fst c) _. *) (* Res 9 {|5,9|} *)

 Definition s143 := Eval vm_compute in (step_checker s142 (List.nth 142 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s143. *) (* s143 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[36; 58; 62; 64; 66; 68; 70; 72],[37; 52; 55],[5; 7; 8; 11],[56; 70; 72],[8; 9; 0; 40],[37; 52; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 143 (fst c) _. *) (* BuildDef2 5 57  *)

 Definition s144 := Eval vm_compute in (step_checker s143 (List.nth 143 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s144. *) (* s144 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[36; 58; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[56; 70; 72],[8; 9; 0; 40],[37; 52; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 144 (fst c) _. *) (* Res 7 {|5,7|} *)

 Definition s145 := Eval vm_compute in (step_checker s144 (List.nth 144 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s145. *) (* s145 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[36; 58; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[12; 53; 70; 72],[8; 9; 0; 40],[37; 52; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 145 (fst c) _. *) (* Res 7 {|9,7|} *)

 Definition s146 := Eval vm_compute in (step_checker s145 (List.nth 145 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s146. *) (* s146 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[36; 58; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[12; 37; 62; 64; 66; 68; 70; 72],[8; 9; 0; 40],[37; 52; 62; 64; 66; 68] |} *)

(*  Eval vm_compute in List.nth 146 (fst c) _. *) (* BuildDef 9 58  *)

 Definition s147 := Eval vm_compute in (step_checker s146 (List.nth 146 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s147. *) (* s147 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[36; 58; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[12; 37; 62; 64; 66; 68; 70; 72],[8; 9; 0; 40],[13; 37; 58] |} *)

(*  Eval vm_compute in List.nth 147 (fst c) _. *) (* Res 9 {|7,9|} *)

 Definition s148 := Eval vm_compute in (step_checker s147 (List.nth 147 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s148. *) (* s148 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[36; 58; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[12; 37; 62; 64; 66; 68; 70; 72],[8; 9; 0; 40],[37; 58; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 148 (fst c) _. *) (* Res 9 {|4,9|} *)

 Definition s149 := Eval vm_compute in (step_checker s148 (List.nth 148 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s149. *) (* s149 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[36; 58; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[12; 37; 62; 64; 66; 68; 70; 72],[8; 9; 0; 40],[58; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 149 (fst c) _. *) (* BuildDef 4 59  *)

 Definition s150 := Eval vm_compute in (step_checker s149 (List.nth 149 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s150. *) (* s150 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[13; 36; 59],[12; 53; 57],[5; 7; 8; 11],[12; 37; 62; 64; 66; 68; 70; 72],[8; 9; 0; 40],[58; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 150 (fst c) _. *) (* Res 4 {|4,9|} *)

 Definition s151 := Eval vm_compute in (step_checker s150 (List.nth 150 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s151. *) (* s151 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[13; 36; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[12; 37; 62; 64; 66; 68; 70; 72],[8; 9; 0; 40],[58; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 151 (fst c) _. *) (* BuildDef 7 60  *)

 Definition s152 := Eval vm_compute in (step_checker s151 (List.nth 151 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s152. *) (* s152 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[13; 36; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[12; 36; 60],[8; 9; 0; 40],[58; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 152 (fst c) _. *) (* Res 7 {|4,7|} *)

 Definition s153 := Eval vm_compute in (step_checker s152 (List.nth 152 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s153. *) (* s153 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[13; 36; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[36; 60; 62; 64; 66; 68; 70; 72],[8; 9; 0; 40],[58; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 153 (fst c) _. *) (* BuildDef2 4 59  *)

 Definition s154 := Eval vm_compute in (step_checker s153 (List.nth 153 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s154. *) (* s154 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[12; 37; 59],[12; 53; 57],[5; 7; 8; 11],[36; 60; 62; 64; 66; 68; 70; 72],[8; 9; 0; 40],[58; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 154 (fst c) _. *) (* Res 9 {|4,9|} *)

 Definition s155 := Eval vm_compute in (step_checker s154 (List.nth 154 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s155. *) (* s155 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[12; 37; 59],[12; 53; 57],[5; 7; 8; 11],[36; 60; 62; 64; 66; 68; 70; 72],[8; 9; 0; 40],[12; 37; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 155 (fst c) _. *) (* BuildDef2 4 60  *)

 Definition s156 := Eval vm_compute in (step_checker s155 (List.nth 155 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s156. *) (* s156 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[13; 37; 60],[12; 53; 57],[5; 7; 8; 11],[36; 60; 62; 64; 66; 68; 70; 72],[8; 9; 0; 40],[12; 37; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 156 (fst c) _. *) (* Res 4 {|9,4|} *)

 Definition s157 := Eval vm_compute in (step_checker s156 (List.nth 156 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s157. *) (* s157 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[37; 60; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[36; 60; 62; 64; 66; 68; 70; 72],[8; 9; 0; 40],[12; 37; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 157 (fst c) _. *) (* Res 4 {|7,4|} *)

 Definition s158 := Eval vm_compute in (step_checker s157 (List.nth 157 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s158. *) (* s158 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[60; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[36; 60; 62; 64; 66; 68; 70; 72],[8; 9; 0; 40],[12; 37; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 158 (fst c) _. *) (* BuildDef 7 41  *)

 Definition s159 := Eval vm_compute in (step_checker s158 (List.nth 158 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s159. *) (* s159 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[60; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[11; 36; 41],[8; 9; 0; 40],[12; 37; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 159 (fst c) _. *) (* Res 7 {|7,8|} *)

 Definition s160 := Eval vm_compute in (step_checker s159 (List.nth 159 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s160. *) (* s160 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[60; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 36],[8; 9; 0; 40],[12; 37; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 160 (fst c) _. *) (* BuildDef 9 61  *)

 Definition s161 := Eval vm_compute in (step_checker s160 (List.nth 160 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s161. *) (* s161 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[60; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 36],[8; 9; 0; 40],[12; 37; 61] |} *)

(*  Eval vm_compute in List.nth 161 (fst c) _. *) (* Res 9 {|9,4|} *)

 Definition s162 := Eval vm_compute in (step_checker s161 (List.nth 161 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s162. *) (* s162 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[60; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 36],[8; 9; 0; 40],[12; 37; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 162 (fst c) _. *) (* Res 9 {|7,9|} *)

 Definition s163 := Eval vm_compute in (step_checker s162 (List.nth 162 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s163. *) (* s163 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[60; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 36],[8; 9; 0; 40],[8; 9; 0; 11; 12; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 163 (fst c) _. *) (* BuildDef2 7 14  *)

 Definition s164 := Eval vm_compute in (step_checker s163 (List.nth 163 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s164. *) (* s164 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[60; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[11; 13; 14],[8; 9; 0; 40],[8; 9; 0; 11; 12; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 164 (fst c) _. *) (* Res 7 {|9,7|} *)

 Definition s165 := Eval vm_compute in (step_checker s164 (List.nth 164 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s165. *) (* s165 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[60; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[8; 9; 0; 40],[8; 9; 0; 11; 12; 62; 64; 66; 68; 70; 72] |} *)

(*  Eval vm_compute in List.nth 165 (fst c) _. *) (* BuildDef2 9 41  *)

 Definition s166 := Eval vm_compute in (step_checker s165 (List.nth 165 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s166. *) (* s166 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[60; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[8; 9; 0; 40],[10; 37; 41] |} *)

(*  Eval vm_compute in List.nth 166 (fst c) _. *) (* Res 8 {|9,8|} *)

 Definition s167 := Eval vm_compute in (step_checker s166 (List.nth 166 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s167. *) (* s167 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[60; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[8; 9; 0; 10; 37],[10; 37; 41] |} *)

(*  Eval vm_compute in List.nth 167 (fst c) _. *) (* BuildDef2 9 61  *)

 Definition s168 := Eval vm_compute in (step_checker s167 (List.nth 167 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s168. *) (* s168 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[60; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[8; 9; 0; 10; 37],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 168 (fst c) _. *) (* Res 4 {|9,4|} *)

 Definition s169 := Eval vm_compute in (step_checker s168 (List.nth 168 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s169. *) (* s169 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[13; 36; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[8; 9; 0; 10; 37],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 169 (fst c) _. *) (* Res 4 {|8,4|} *)

 Definition s170 := Eval vm_compute in (step_checker s169 (List.nth 169 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s170. *) (* s170 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[8; 9; 0; 10; 37],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 170 (fst c) _. *) (* BuildDef 8 14  *)

 Definition s171 := Eval vm_compute in (step_checker s170 (List.nth 170 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s171. *) (* s171 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[10; 12; 14],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 171 (fst c) _. *) (* Res 8 {|4,8|} *)

 Definition s172 := Eval vm_compute in (step_checker s171 (List.nth 171 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s172. *) (* s172 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[8; 9; 0; 10; 14; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 172 (fst c) _. *) (* Res 8 {|7,8|} *)

 Definition s173 := Eval vm_compute in (step_checker s172 (List.nth 172 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s173. *) (* s173 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[8; 9; 0; 14; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 173 (fst c) _. *) (* BuildDef 7 15  *)

 Definition s174 := Eval vm_compute in (step_checker s173 (List.nth 173 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s174. *) (* s174 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[11; 12; 15],[8; 9; 0; 14; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 174 (fst c) _. *) (* Res 7 {|7,8|} *)

 Definition s175 := Eval vm_compute in (step_checker s174 (List.nth 174 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s175. *) (* s175 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 12; 62; 64; 66; 68; 70; 72],[8; 9; 0; 14; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 175 (fst c) _. *) (* BuildDef2 4 14  *)

 Definition s176 := Eval vm_compute in (step_checker s175 (List.nth 175 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s176. *) (* s176 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[11; 13; 14],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 12; 62; 64; 66; 68; 70; 72],[8; 9; 0; 14; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 176 (fst c) _. *) (* Res 4 {|7,4|} *)

 Definition s177 := Eval vm_compute in (step_checker s176 (List.nth 176 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s177. *) (* s177 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 11; 12; 62; 64; 66; 68; 70; 72],[8; 9; 0; 14; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 177 (fst c) _. *) (* BuildDef2 7 15  *)

 Definition s178 := Eval vm_compute in (step_checker s177 (List.nth 177 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s178. *) (* s178 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[10; 13; 15],[8; 9; 0; 14; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 178 (fst c) _. *) (* Res 8 {|7,8|} *)

 Definition s179 := Eval vm_compute in (step_checker s178 (List.nth 178 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s179. *) (* s179 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[10; 13; 15],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 179 (fst c) _. *) (* BuildDef 7 14  *)

 Definition s180 := Eval vm_compute in (step_checker s179 (List.nth 179 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s180. *) (* s180 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[10; 12; 14],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 180 (fst c) _. *) (* Res 7 {|8,7|} *)

 Definition s181 := Eval vm_compute in (step_checker s180 (List.nth 180 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s181. *) (* s181 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 10; 14; 62; 64; 66; 68; 70; 72],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 181 (fst c) _. *) (* Res 7 {|4,7|} *)

 Definition s182 := Eval vm_compute in (step_checker s181 (List.nth 181 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s182. *) (* s182 = {| [11],[10; 13; 15],[6; 9],[2; 7; 36; 53],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 14; 62; 64; 66; 68; 70; 72],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 182 (fst c) _. *) (* Res 0 {|1,7,0|} *)

 Definition s183 := Eval vm_compute in (step_checker s182 (List.nth 182 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s183. *) (* s183 = {| [8; 9; 0; 13; 62; 64; 66; 68; 70; 72],[10; 13; 15],[6; 9],[2; 7; 36; 53],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 14; 62; 64; 66; 68; 70; 72],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 183 (fst c) _. *) (* BuildProj 7 12 1  *)

 Definition s184 := Eval vm_compute in (step_checker s183 (List.nth 183 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s184. *) (* s184 = {| [8; 9; 0; 13; 62; 64; 66; 68; 70; 72],[10; 13; 15],[6; 9],[2; 7; 36; 53],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[7; 12],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 184 (fst c) _. *) (* Res 7 {|7,0|} *)

 Definition s185 := Eval vm_compute in (step_checker s184 (List.nth 184 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s185. *) (* s185 = {| [8; 9; 0; 13; 62; 64; 66; 68; 70; 72],[10; 13; 15],[6; 9],[2; 7; 36; 53],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[7; 8; 9; 0; 62; 64; 66; 68; 70; 72],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 185 (fst c) _. *) (* BuildProj 1 12 0  *)

 Definition s186 := Eval vm_compute in (step_checker s185 (List.nth 185 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s186. *) (* s186 = {| [8; 9; 0; 13; 62; 64; 66; 68; 70; 72],[6; 12],[6; 9],[2; 7; 36; 53],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[7; 8; 9; 0; 62; 64; 66; 68; 70; 72],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 186 (fst c) _. *) (* Res 0 {|1,0|} *)

 Definition s187 := Eval vm_compute in (step_checker s186 (List.nth 186 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s187. *) (* s187 = {| [6; 8; 9; 0; 62; 64; 66; 68; 70; 72],[6; 12],[6; 9],[2; 7; 36; 53],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[7; 8; 9; 0; 62; 64; 66; 68; 70; 72],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 187 (fst c) _. *) (* Res 0 {|7,0|} *)

 Definition s188 := Eval vm_compute in (step_checker s187 (List.nth 187 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s188. *) (* s188 = {| [8; 9; 0; 62; 64; 66; 68; 70; 72],[6; 12],[6; 9],[2; 7; 36; 53],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[7; 8; 9; 0; 62; 64; 66; 68; 70; 72],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 188 (fst c) _. *) (* BuildProj 7 73 0  *)

 Definition s189 := Eval vm_compute in (step_checker s188 (List.nth 188 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s189. *) (* s189 = {| [8; 9; 0; 62; 64; 66; 68; 70; 72],[6; 12],[6; 9],[2; 7; 36; 53],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[12; 73],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 189 (fst c) _. *) (* Res 7 {|0,7|} *)

 Definition s190 := Eval vm_compute in (step_checker s189 (List.nth 189 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s190. *) (* s190 = {| [8; 9; 0; 62; 64; 66; 68; 70; 72],[6; 12],[6; 9],[2; 7; 36; 53],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 12; 62; 64; 66; 68; 70],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 190 (fst c) _. *) (* BuildProj 1 52 2  *)

 Definition s191 := Eval vm_compute in (step_checker s190 (List.nth 190 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s191. *) (* s191 = {| [8; 9; 0; 62; 64; 66; 68; 70; 72],[7; 52],[6; 9],[2; 7; 36; 53],[8; 9; 0; 11; 14; 62; 64; 66; 68; 70; 72],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 12; 62; 64; 66; 68; 70],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 191 (fst c) _. *) (* BuildProj 4 52 1  *)

 Definition s192 := Eval vm_compute in (step_checker s191 (List.nth 191 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s192. *) (* s192 = {| [8; 9; 0; 62; 64; 66; 68; 70; 72],[7; 52],[6; 9],[2; 7; 36; 53],[6; 52],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 12; 62; 64; 66; 68; 70],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 192 (fst c) _. *) (* Weaken 1 1 [62;64;66;68;70;13;52;7] *)

 Definition s193 := Eval vm_compute in (step_checker s192 (List.nth 192 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s193. *) (* s193 = {| [8; 9; 0; 62; 64; 66; 68; 70; 72],[7; 13; 52; 62; 64; 66; 68; 70],[6; 9],[2; 7; 36; 53],[6; 52],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 12; 62; 64; 66; 68; 70],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 193 (fst c) _. *) (* Res 7 {|1,4,7|} *)

 Definition s194 := Eval vm_compute in (step_checker s193 (List.nth 193 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s194. *) (* s194 = {| [8; 9; 0; 62; 64; 66; 68; 70; 72],[7; 13; 52; 62; 64; 66; 68; 70],[6; 9],[2; 7; 36; 53],[6; 52],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 52; 62; 64; 66; 68; 70],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 194 (fst c) _. *) (* BuildProj 4 73 1  *)

 Definition s195 := Eval vm_compute in (step_checker s194 (List.nth 194 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s195. *) (* s195 = {| [8; 9; 0; 62; 64; 66; 68; 70; 72],[7; 13; 52; 62; 64; 66; 68; 70],[6; 9],[2; 7; 36; 53],[53; 73],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 52; 62; 64; 66; 68; 70],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 195 (fst c) _. *) (* Res 4 {|0,4|} *)

 Definition s196 := Eval vm_compute in (step_checker s195 (List.nth 195 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s196. *) (* s196 = {| [8; 9; 0; 62; 64; 66; 68; 70; 72],[7; 13; 52; 62; 64; 66; 68; 70],[6; 9],[2; 7; 36; 53],[8; 9; 0; 53; 62; 64; 66; 68; 70],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 52; 62; 64; 66; 68; 70],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 196 (fst c) _. *) (* Res 4 {|7,4|} *)

 Definition s197 := Eval vm_compute in (step_checker s196 (List.nth 196 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s197. *) (* s197 = {| [8; 9; 0; 62; 64; 66; 68; 70; 72],[7; 13; 52; 62; 64; 66; 68; 70],[6; 9],[2; 7; 36; 53],[8; 9; 0; 62; 64; 66; 68; 70],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 52; 62; 64; 66; 68; 70],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 197 (fst c) _. *) (* BuildProj 7 71 0  *)

 Definition s198 := Eval vm_compute in (step_checker s197 (List.nth 197 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s198. *) (* s198 = {| [8; 9; 0; 62; 64; 66; 68; 70; 72],[7; 13; 52; 62; 64; 66; 68; 70],[6; 9],[2; 7; 36; 53],[8; 9; 0; 62; 64; 66; 68; 70],[12; 53; 57],[5; 7; 8; 11],[52; 71],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 198 (fst c) _. *) (* Res 7 {|4,7|} *)

 Definition s199 := Eval vm_compute in (step_checker s198 (List.nth 198 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s199. *) (* s199 = {| [8; 9; 0; 62; 64; 66; 68; 70; 72],[7; 13; 52; 62; 64; 66; 68; 70],[6; 9],[2; 7; 36; 53],[8; 9; 0; 62; 64; 66; 68; 70],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 52; 62; 64; 66; 68],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 199 (fst c) _. *) (* CFalse 0  *)

 Definition s200 := Eval vm_compute in (step_checker s199 (List.nth 199 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s200. *) (* s200 = {| [3],[7; 13; 52; 62; 64; 66; 68; 70],[6; 9],[2; 7; 36; 53],[8; 9; 0; 62; 64; 66; 68; 70],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 52; 62; 64; 66; 68],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 200 (fst c) _. *) (* BuildProj 1 12 1  *)

 Definition s201 := Eval vm_compute in (step_checker s200 (List.nth 200 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s201. *) (* s201 = {| [3],[7; 12],[6; 9],[2; 7; 36; 53],[8; 9; 0; 62; 64; 66; 68; 70],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 52; 62; 64; 66; 68],[8; 9; 0; 10; 13; 62; 64; 66; 68; 70; 72],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 201 (fst c) _. *) (* BuildProj 8 12 0  *)

 Definition s202 := Eval vm_compute in (step_checker s201 (List.nth 201 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s202. *) (* s202 = {| [3],[7; 12],[6; 9],[2; 7; 36; 53],[8; 9; 0; 62; 64; 66; 68; 70],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 52; 62; 64; 66; 68],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 202 (fst c) _. *) (* Weaken 1 1 [62;64;66;68;53;2;12;7] *)

 Definition s203 := Eval vm_compute in (step_checker s202 (List.nth 202 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s203. *) (* s203 = {| [3],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[8; 9; 0; 62; 64; 66; 68; 70],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 52; 62; 64; 66; 68],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 203 (fst c) _. *) (* Res 0 {|1,8,7,0|} *)

 Definition s204 := Eval vm_compute in (step_checker s203 (List.nth 203 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s204. *) (* s204 = {| [8; 9; 0; 12; 62; 64; 66; 68],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[8; 9; 0; 62; 64; 66; 68; 70],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 52; 62; 64; 66; 68],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 204 (fst c) _. *) (* BuildProj 7 71 1  *)

 Definition s205 := Eval vm_compute in (step_checker s204 (List.nth 204 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s205. *) (* s205 = {| [8; 9; 0; 12; 62; 64; 66; 68],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[8; 9; 0; 62; 64; 66; 68; 70],[12; 53; 57],[5; 7; 8; 11],[13; 71],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 205 (fst c) _. *) (* Res 7 {|4,7|} *)

 Definition s206 := Eval vm_compute in (step_checker s205 (List.nth 205 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s206. *) (* s206 = {| [8; 9; 0; 12; 62; 64; 66; 68],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[8; 9; 0; 62; 64; 66; 68; 70],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 13; 62; 64; 66; 68],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 206 (fst c) _. *) (* Res 7 {|0,7|} *)

 Definition s207 := Eval vm_compute in (step_checker s206 (List.nth 206 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s207. *) (* s207 = {| [8; 9; 0; 12; 62; 64; 66; 68],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[8; 9; 0; 62; 64; 66; 68; 70],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 62; 64; 66; 68],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 207 (fst c) _. *) (* BuildProj 0 69 0  *)

 Definition s208 := Eval vm_compute in (step_checker s207 (List.nth 207 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s208. *) (* s208 = {| [2; 69],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[8; 9; 0; 62; 64; 66; 68; 70],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 62; 64; 66; 68],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 208 (fst c) _. *) (* Res 0 {|7,0|} *)

 Definition s209 := Eval vm_compute in (step_checker s208 (List.nth 208 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s209. *) (* s209 = {| [2; 8; 9; 0; 62; 64; 66],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[8; 9; 0; 62; 64; 66; 68; 70],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 62; 64; 66; 68],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 209 (fst c) _. *) (* Weaken 0 0 [62;64;66;2;1] *)

 Definition s210 := Eval vm_compute in (step_checker s209 (List.nth 209 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s210. *) (* s210 = {| [0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[8; 9; 0; 62; 64; 66; 68; 70],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 62; 64; 66; 68],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 210 (fst c) _. *) (* CFalse 4  *)

 Definition s211 := Eval vm_compute in (step_checker s210 (List.nth 210 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s211. *) (* s211 = {| [0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[3],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 62; 64; 66; 68],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 211 (fst c) _. *) (* Res 4 {|0,4|} *)

 Definition s212 := Eval vm_compute in (step_checker s211 (List.nth 211 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s212. *) (* s212 = {| [0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0; 0],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 62; 64; 66; 68],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 212 (fst c) _. *) (* BuildProj 0 69 1  *)

 Definition s213 := Eval vm_compute in (step_checker s212 (List.nth 212 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s213. *) (* s213 = {| [0; 69],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0; 0],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 62; 64; 66; 68],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 213 (fst c) _. *) (* Res 0 {|7,0|} *)

 Definition s214 := Eval vm_compute in (step_checker s213 (List.nth 213 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s214. *) (* s214 = {| [0; 8; 9; 0; 62; 64; 66],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0; 0],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 62; 64; 66; 68],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 214 (fst c) _. *) (* Res 0 {|4,0|} *)

 Definition s215 := Eval vm_compute in (step_checker s214 (List.nth 214 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s215. *) (* s215 = {| [0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0; 0],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 62; 64; 66; 68],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 215 (fst c) _. *) (* BuildProj 4 67 0  *)

 Definition s216 := Eval vm_compute in (step_checker s215 (List.nth 215 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s216. *) (* s216 = {| [0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[1; 67],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 62; 64; 66; 68],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 216 (fst c) _. *) (* Res 4 {|0,4|} *)

 Definition s217 := Eval vm_compute in (step_checker s216 (List.nth 216 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s217. *) (* s217 = {| [0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0; 0; 67],[12; 53; 57],[5; 7; 8; 11],[8; 9; 0; 62; 64; 66; 68],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 217 (fst c) _. *) (* BuildProj 7 74 0  *)

 Definition s218 := Eval vm_compute in (step_checker s217 (List.nth 217 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s218. *) (* s218 = {| [0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0; 0; 67],[12; 53; 57],[5; 7; 8; 11],[0; 74],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 218 (fst c) _. *) (* Res 7 {|4,7|} *)

 Definition s219 := Eval vm_compute in (step_checker s218 (List.nth 218 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s219. *) (* s219 = {| [0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0; 0; 67],[12; 53; 57],[5; 7; 8; 11],[0; 0; 67; 0],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 219 (fst c) _. *) (* BuildDef 4 75  *)

 Definition s220 := Eval vm_compute in (step_checker s219 (List.nth 219 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s220. *) (* s220 = {| [0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[1; 2; 75],[12; 53; 57],[5; 7; 8; 11],[0; 0; 67; 0],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 220 (fst c) _. *) (* Res 7 {|4,7|} *)

 Definition s221 := Eval vm_compute in (step_checker s220 (List.nth 220 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s221. *) (* s221 = {| [0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[1; 2; 75],[12; 53; 57],[5; 7; 8; 11],[0; 2; 67; 0; 75],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 221 (fst c) _. *) (* CTrue 4  *)

 Definition s222 := Eval vm_compute in (step_checker s221 (List.nth 221 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s222. *) (* s222 = {| [0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0],[12; 53; 57],[5; 7; 8; 11],[0; 2; 67; 0; 75],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 222 (fst c) _. *) (* Res 4 {|7,4|} *)

 Definition s223 := Eval vm_compute in (step_checker s222 (List.nth 222 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s223. *) (* s223 = {| [0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0; 0],[12; 53; 57],[5; 7; 8; 11],[0; 2; 67; 0; 75],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 223 (fst c) _. *) (* BuildProj 7 67 1  *)

 Definition s224 := Eval vm_compute in (step_checker s223 (List.nth 223 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s224. *) (* s224 = {| [0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0; 0],[12; 53; 57],[5; 7; 8; 11],[3; 67],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 224 (fst c) _. *) (* Res 7 {|0,7|} *)

 Definition s225 := Eval vm_compute in (step_checker s224 (List.nth 224 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s225. *) (* s225 = {| [0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0; 0],[12; 53; 57],[5; 7; 8; 11],[0; 0; 0; 0],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 225 (fst c) _. *) (* Res 7 {|4,7|} *)

 Definition s226 := Eval vm_compute in (step_checker s225 (List.nth 225 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s226. *) (* s226 = {| [0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0; 0],[12; 53; 57],[5; 7; 8; 11],[0; 0; 0],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 226 (fst c) _. *) (* EqTr 4 28 [] *)

 Definition s227 := Eval vm_compute in (step_checker s226 (List.nth 226 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s227. *) (* s227 = {| [0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[28],[12; 53; 57],[5; 7; 8; 11],[0; 0; 0],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 227 (fst c) _. *) (* BuildProj 0 65 1  *)

 Definition s228 := Eval vm_compute in (step_checker s227 (List.nth 227 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s228. *) (* s228 = {| [29; 65],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[28],[12; 53; 57],[5; 7; 8; 11],[0; 0; 0],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 228 (fst c) _. *) (* Res 0 {|7,0|} *)

 Definition s229 := Eval vm_compute in (step_checker s228 (List.nth 228 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s229. *) (* s229 = {| [0; 0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[28],[12; 53; 57],[5; 7; 8; 11],[0; 0; 0],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 229 (fst c) _. *) (* Res 0 {|4,0|} *)

 Definition s230 := Eval vm_compute in (step_checker s229 (List.nth 229 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s230. *) (* s230 = {| [0; 0; 0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[28],[12; 53; 57],[5; 7; 8; 11],[0; 0; 0],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 230 (fst c) _. *) (* CTrue 4  *)

 Definition s231 := Eval vm_compute in (step_checker s230 (List.nth 230 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s231. *) (* s231 = {| [0; 0; 0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0],[12; 53; 57],[5; 7; 8; 11],[0; 0; 0],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 231 (fst c) _. *) (* BuildProj 7 63 1  *)

 Definition s232 := Eval vm_compute in (step_checker s231 (List.nth 231 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s232. *) (* s232 = {| [0; 0; 0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0],[12; 53; 57],[5; 7; 8; 11],[1; 63],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 232 (fst c) _. *) (* Res 7 {|0,7|} *)

 Definition s233 := Eval vm_compute in (step_checker s232 (List.nth 232 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s233. *) (* s233 = {| [0; 0; 0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0],[12; 53; 57],[5; 7; 8; 11],[0; 0; 0; 0; 63],[6; 12],[13; 36; 61] |} *)

(*  Eval vm_compute in List.nth 233 (fst c) _. *) (* Res 7 {|4,7|} *)

 Definition s234 := Eval vm_compute in (step_checker s233 (List.nth 233 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s234. *) (* s234 = {| [0; 0; 0; 0; 0],[2; 7; 12; 53; 62; 64; 66; 68],[6; 9],[2; 7; 36; 53],[0],[12; 53; 57],[5; 7; 8; 11],[0; 0],[6; 12],[13; 36; 61] |} *)
End test6cvc5debug.