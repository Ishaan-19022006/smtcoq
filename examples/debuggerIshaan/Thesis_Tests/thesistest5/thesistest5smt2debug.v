Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool. 
Require Import Int31. 
Local Open Scope int31_scope.

Section thesistest5smt2debug.

 Parse_certif_verit t_i t_func t_atom t_form root used_roots trace 
 "Thesis_Tests/thesistest5/thesistest5.smt2" 
 "Thesis_Tests/thesistest5/thesistest5.pf". 

 Definition nclauses := Eval vm_compute in (match trace with Certif a _ _ => a end). (* Size of the state *)
(*  Print nclauses. *) (* 12 *)

  Definition c := Eval vm_compute in (match trace with Certif _ a _ => a end). (* Certificate *)
 Definition conf := Eval vm_compute in (match trace with Certif _ _ a => a end). (* Look here in the state for the empty clause*)
(*  Print conf. *) (* 5 *)

(*  Eval vm_compute in List.length (fst c). (* No. of steps in certificate *) *) (* 104 *)

(*  Eval vm_compute in (Form.check_form t_form && Atom.check_atom t_atom && Atom.wt t_i t_func t_atom). *) (* true *)

 (* States from c *) 

(* Start state *) 

 Definition s0 := Eval vm_compute in (add_roots (S.make nclauses) root used_roots). 
(*   Print s0. *) (* s0 = {| [5],[6],[8],[10] |} *)

(*  Eval vm_compute in List.nth 0 (fst c) _. *) (* BuildDef2 4 16  *)

 Definition s1 := Eval vm_compute in (step_checker s0 (List.nth 0 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s1. *) (* s1 = {| [5],[6],[8],[10],[14; 16] |} *)

(*  Eval vm_compute in List.nth 1 (fst c) _. *) (* Weaken 4 4 [16;14] *)

 Definition s2 := Eval vm_compute in (step_checker s1 (List.nth 1 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s2. *) (* s2 = {| [5],[6],[8],[10],[14; 16] |} *)

(*  Eval vm_compute in List.nth 2 (fst c) _. *) (* BuildDef 5 16  *)

 Definition s3 := Eval vm_compute in (step_checker s2 (List.nth 2 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s3. *) (* s3 = {| [5],[6],[8],[10],[14; 16],[15; 16] |} *)

(*  Eval vm_compute in List.nth 3 (fst c) _. *) (* Weaken 5 5 [16;15] *)

 Definition s4 := Eval vm_compute in (step_checker s3 (List.nth 3 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s4. *) (* s4 = {| [5],[6],[8],[10],[14; 16],[15; 16] |} *)

(*  Eval vm_compute in List.nth 4 (fst c) _. *) (* Res 5 {|4,5|} *)

 Definition s5 := Eval vm_compute in (step_checker s4 (List.nth 4 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s5. *) (* s5 = {| [5],[6],[8],[10],[14; 16],[16] |} *)

(*  Eval vm_compute in List.nth 5 (fst c) _. *) (* BuildDef 4 24  *)

 Definition s6 := Eval vm_compute in (step_checker s5 (List.nth 5 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s6. *) (* s6 = {| [5],[6],[8],[10],[4; 13; 24],[16] |} *)

(*  Eval vm_compute in List.nth 6 (fst c) _. *) (* BuildProj 6 26 0  *)

 Definition s7 := Eval vm_compute in (step_checker s6 (List.nth 6 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s7. *) (* s7 = {| [5],[6],[8],[10],[4; 13; 24],[16],[24; 26] |} *)

(*  Eval vm_compute in List.nth 7 (fst c) _. *) (* BuildDef 7 52  *)

 Definition s8 := Eval vm_compute in (step_checker s7 (List.nth 7 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s8. *) (* s8 = {| [5],[6],[8],[10],[4; 13; 24],[16],[24; 26],[4; 11; 13; 52] |} *)

(*  Eval vm_compute in List.nth 8 (fst c) _. *) (* BuildProj 8 25 0  *)

 Definition s9 := Eval vm_compute in (step_checker s8 (List.nth 8 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s9. *) (* s9 = {| [5],[6],[8],[10],[4; 13; 24],[16],[24; 26],[4; 11; 13; 52],[5; 25] |} *)

(*  Eval vm_compute in List.nth 9 (fst c) _. *) (* BuildProj 9 25 1  *)

 Definition s10 := Eval vm_compute in (step_checker s9 (List.nth 9 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s10. *) (* s10 = {| [5],[6],[8],[10],[4; 13; 24],[16],[24; 26],[4; 11; 13; 52],[5; 25],[12; 25] |} *)

(*  Eval vm_compute in List.nth 10 (fst c) _. *) (* Res 9 {|7,8,9|} *)

 Definition s11 := Eval vm_compute in (step_checker s10 (List.nth 10 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s11. *) (* s11 = {| [5],[6],[8],[10],[4; 13; 24],[16],[24; 26],[4; 11; 13; 52],[5; 25],[11; 25; 52] |} *)

(*  Eval vm_compute in List.nth 11 (fst c) _. *) (* Res 9 {|6,9|} *)

 Definition s12 := Eval vm_compute in (step_checker s11 (List.nth 11 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s12. *) (* s12 = {| [5],[6],[8],[10],[4; 13; 24],[16],[24; 26],[4; 11; 13; 52],[5; 25],[11; 26; 52] |} *)

(*  Eval vm_compute in List.nth 12 (fst c) _. *) (* BuildProj 6 26 1  *)

 Definition s13 := Eval vm_compute in (step_checker s12 (List.nth 12 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s13. *) (* s13 = {| [5],[6],[8],[10],[4; 13; 24],[16],[10; 26],[4; 11; 13; 52],[5; 25],[11; 26; 52] |} *)

(*  Eval vm_compute in List.nth 13 (fst c) _. *) (* Res 6 {|9,6|} *)

 Definition s14 := Eval vm_compute in (step_checker s13 (List.nth 13 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s14. *) (* s14 = {| [5],[6],[8],[10],[4; 13; 24],[16],[26; 52],[4; 11; 13; 52],[5; 25],[11; 26; 52] |} *)

(*  Eval vm_compute in List.nth 14 (fst c) _. *) (* BuildDef 9 27  *)

 Definition s15 := Eval vm_compute in (step_checker s14 (List.nth 14 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s15. *) (* s15 = {| [5],[6],[8],[10],[4; 13; 24],[16],[26; 52],[4; 11; 13; 52],[5; 25],[11; 25; 27] |} *)

(*  Eval vm_compute in List.nth 15 (fst c) _. *) (* Res 6 {|9,6|} *)

 Definition s16 := Eval vm_compute in (step_checker s15 (List.nth 15 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s16. *) (* s16 = {| [5],[6],[8],[10],[4; 13; 24],[16],[11; 25; 52],[4; 11; 13; 52],[5; 25],[11; 25; 27] |} *)

(*  Eval vm_compute in List.nth 16 (fst c) _. *) (* Res 6 {|4,6|} *)

 Definition s17 := Eval vm_compute in (step_checker s16 (List.nth 16 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s17. *) (* s17 = {| [5],[6],[8],[10],[4; 13; 24],[16],[4; 11; 13; 52],[4; 11; 13; 52],[5; 25],[11; 25; 27] |} *)

(*  Eval vm_compute in List.nth 17 (fst c) _. *) (* BuildProj 4 14 0  *)

 Definition s18 := Eval vm_compute in (step_checker s17 (List.nth 17 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s18. *) (* s18 = {| [5],[6],[8],[10],[5; 14],[16],[4; 11; 13; 52],[4; 11; 13; 52],[5; 25],[11; 25; 27] |} *)

(*  Eval vm_compute in List.nth 18 (fst c) _. *) (* BuildProj 9 14 1  *)

 Definition s19 := Eval vm_compute in (step_checker s18 (List.nth 18 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s19. *) (* s19 = {| [5],[6],[8],[10],[5; 14],[16],[4; 11; 13; 52],[4; 11; 13; 52],[5; 25],[12; 14] |} *)

(*  Eval vm_compute in List.nth 19 (fst c) _. *) (* BuildProj 8 14 2  *)

 Definition s20 := Eval vm_compute in (step_checker s19 (List.nth 19 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s20. *) (* s20 = {| [5],[6],[8],[10],[5; 14],[16],[4; 11; 13; 52],[4; 11; 13; 52],[10; 14],[12; 14] |} *)

(*  Eval vm_compute in List.nth 20 (fst c) _. *) (* Res 8 {|6,4,9,8|} *)

 Definition s21 := Eval vm_compute in (step_checker s20 (List.nth 20 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s21. *) (* s21 = {| [5],[6],[8],[10],[5; 14],[16],[4; 11; 13; 52],[4; 11; 13; 52],[14; 52],[12; 14] |} *)

(*  Eval vm_compute in List.nth 21 (fst c) _. *) (* Weaken 8 8 [17;52;14] *)

 Definition s22 := Eval vm_compute in (step_checker s21 (List.nth 21 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s22. *) (* s22 = {| [5],[6],[8],[10],[5; 14],[16],[4; 11; 13; 52],[4; 11; 13; 52],[14; 17; 52],[12; 14] |} *)

(*  Eval vm_compute in List.nth 22 (fst c) _. *) (* Res 5 {|8,5|} *)

 Definition s23 := Eval vm_compute in (step_checker s22 (List.nth 22 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s23. *) (* s23 = {| [5],[6],[8],[10],[5; 14],[14; 52],[4; 11; 13; 52],[4; 11; 13; 52],[14; 17; 52],[12; 14] |} *)

(*  Eval vm_compute in List.nth 23 (fst c) _. *) (* BuildDef 8 15  *)

 Definition s24 := Eval vm_compute in (step_checker s23 (List.nth 23 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s24. *) (* s24 = {| [5],[6],[8],[10],[5; 14],[14; 52],[4; 11; 13; 52],[4; 11; 13; 52],[4; 11; 13; 15],[12; 14] |} *)

(*  Eval vm_compute in List.nth 24 (fst c) _. *) (* Res 5 {|8,5|} *)

 Definition s25 := Eval vm_compute in (step_checker s24 (List.nth 24 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s25. *) (* s25 = {| [5],[6],[8],[10],[5; 14],[4; 11; 13; 52],[4; 11; 13; 52],[4; 11; 13; 52],[4; 11; 13; 15],[12; 14] |} *)

(*  Eval vm_compute in List.nth 25 (fst c) _. *) (* BuildDef2 8 35  *)

 Definition s26 := Eval vm_compute in (step_checker s25 (List.nth 25 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s26. *) (* s26 = {| [5],[6],[8],[10],[5; 14],[4; 11; 13; 52],[4; 11; 13; 52],[4; 11; 13; 52],[7; 12; 35],[12; 14] |} *)

(*  Eval vm_compute in List.nth 26 (fst c) _. *) (* EqTr 9 36 [] *)

 Definition s27 := Eval vm_compute in (step_checker s26 (List.nth 26 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s27. *) (* s27 = {| [5],[6],[8],[10],[5; 14],[4; 11; 13; 52],[4; 11; 13; 52],[4; 11; 13; 52],[7; 12; 35],[36] |} *)

(*  Eval vm_compute in List.nth 27 (fst c) _. *) (* EqTr 4 38 [] *)

 Definition s28 := Eval vm_compute in (step_checker s27 (List.nth 27 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s28. *) (* s28 = {| [5],[6],[8],[10],[38],[4; 11; 13; 52],[4; 11; 13; 52],[4; 11; 13; 52],[7; 12; 35],[36] |} *)

(*  Eval vm_compute in List.nth 28 (fst c) _. *) (* EqTr 6 40 [] *)

 Definition s29 := Eval vm_compute in (step_checker s28 (List.nth 28 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s29. *) (* s29 = {| [5],[6],[8],[10],[38],[4; 11; 13; 52],[40],[4; 11; 13; 52],[7; 12; 35],[36] |} *)

(*  Eval vm_compute in List.nth 29 (fst c) _. *) (* EqTr 7 42 [] *)

 Definition s30 := Eval vm_compute in (step_checker s29 (List.nth 29 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s30. *) (* s30 = {| [5],[6],[8],[10],[38],[4; 11; 13; 52],[40],[42],[7; 12; 35],[36] |} *)

(*  Eval vm_compute in List.nth 30 (fst c) _. *) (* EqCgr 10 44 [S 39; S 41; S 43; S 9] *)

 Definition s31 := Eval vm_compute in (step_checker s30 (List.nth 30 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s31. *) (* s31 = {| [5],[6],[8],[10],[38],[4; 11; 13; 52],[40],[42],[7; 12; 35],[36],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 31 (fst c) _. *) (* Res 7 {|10,4,6,7,2|} *)

 Definition s32 := Eval vm_compute in (step_checker s31 (List.nth 31 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s32. *) (* s32 = {| [5],[6],[8],[10],[38],[4; 11; 13; 52],[40],[44],[7; 12; 35],[36],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 32 (fst c) _. *) (* EqTr 6 12 [45;7;37] *)

 Definition s33 := Eval vm_compute in (step_checker s32 (List.nth 32 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s33. *) (* s33 = {| [5],[6],[8],[10],[38],[4; 11; 13; 52],[7; 12; 37; 45],[44],[7; 12; 35],[36],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 33 (fst c) _. *) (* BuildDef2 4 34  *)

 Definition s34 := Eval vm_compute in (step_checker s33 (List.nth 33 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s34. *) (* s34 = {| [5],[6],[8],[10],[6; 12; 34],[4; 11; 13; 52],[7; 12; 37; 45],[44],[7; 12; 35],[36],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 34 (fst c) _. *) (* Res 4 {|6,4|} *)

 Definition s35 := Eval vm_compute in (step_checker s34 (List.nth 34 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s35. *) (* s35 = {| [5],[6],[8],[10],[12; 34; 37; 45],[4; 11; 13; 52],[7; 12; 37; 45],[44],[7; 12; 35],[36],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 35 (fst c) _. *) (* EqTr 6 6 [45;13;37] *)

 Definition s36 := Eval vm_compute in (step_checker s35 (List.nth 35 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s36. *) (* s36 = {| [5],[6],[8],[10],[12; 34; 37; 45],[4; 11; 13; 52],[6; 13; 37; 45],[44],[7; 12; 35],[36],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 36 (fst c) _. *) (* BuildDef 10 34  *)

 Definition s37 := Eval vm_compute in (step_checker s36 (List.nth 36 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s37. *) (* s37 = {| [5],[6],[8],[10],[12; 34; 37; 45],[4; 11; 13; 52],[6; 13; 37; 45],[44],[7; 12; 35],[36],[7; 13; 34] |} *)

(*  Eval vm_compute in List.nth 37 (fst c) _. *) (* Res 10 {|6,10|} *)

 Definition s38 := Eval vm_compute in (step_checker s37 (List.nth 37 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s38. *) (* s38 = {| [5],[6],[8],[10],[12; 34; 37; 45],[4; 11; 13; 52],[6; 13; 37; 45],[44],[7; 12; 35],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 38 (fst c) _. *) (* Res 7 {|4,10,9,7|} *)

 Definition s39 := Eval vm_compute in (step_checker s38 (List.nth 38 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s39. *) (* s39 = {| [5],[6],[8],[10],[12; 34; 37; 45],[4; 11; 13; 52],[6; 13; 37; 45],[34],[7; 12; 35],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 39 (fst c) _. *) (* Res 7 {|8,7,1|} *)

 Definition s40 := Eval vm_compute in (step_checker s39 (List.nth 39 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s40. *) (* s40 = {| [5],[6],[8],[10],[12; 34; 37; 45],[4; 11; 13; 52],[6; 13; 37; 45],[12],[7; 12; 35],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 40 (fst c) _. *) (* Res 0 {|5,3,7,0|} *)

 Definition s41 := Eval vm_compute in (step_checker s40 (List.nth 40 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s41. *) (* s41 = {| [52],[6],[8],[10],[12; 34; 37; 45],[4; 11; 13; 52],[6; 13; 37; 45],[12],[7; 12; 35],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 41 (fst c) _. *) (* BuildProj 7 53 0  *)

 Definition s42 := Eval vm_compute in (step_checker s41 (List.nth 41 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s42. *) (* s42 = {| [52],[6],[8],[10],[12; 34; 37; 45],[4; 11; 13; 52],[6; 13; 37; 45],[5; 53],[7; 12; 35],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 42 (fst c) _. *) (* Res 7 {|0,7|} *)

 Definition s43 := Eval vm_compute in (step_checker s42 (List.nth 42 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s43. *) (* s43 = {| [52],[6],[8],[10],[12; 34; 37; 45],[4; 11; 13; 52],[6; 13; 37; 45],[5],[7; 12; 35],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 43 (fst c) _. *) (* BuildDef 3 30  *)

 Definition s44 := Eval vm_compute in (step_checker s43 (List.nth 43 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s44. *) (* s44 = {| [52],[6],[8],[10; 29; 30],[12; 34; 37; 45],[4; 11; 13; 52],[6; 13; 37; 45],[5],[7; 12; 35],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 44 (fst c) _. *) (* BuildDef 5 54  *)

 Definition s45 := Eval vm_compute in (step_checker s44 (List.nth 44 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s45. *) (* s45 = {| [52],[6],[8],[10; 29; 30],[12; 34; 37; 45],[11; 29; 54],[6; 13; 37; 45],[5],[7; 12; 35],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 45 (fst c) _. *) (* Res 3 {|5,3|} *)

 Definition s46 := Eval vm_compute in (step_checker s45 (List.nth 45 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s46. *) (* s46 = {| [52],[6],[8],[29; 30; 54],[12; 34; 37; 45],[11; 29; 54],[6; 13; 37; 45],[5],[7; 12; 35],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 46 (fst c) _. *) (* BuildDef2 5 30  *)

 Definition s47 := Eval vm_compute in (step_checker s46 (List.nth 46 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s47. *) (* s47 = {| [52],[6],[8],[29; 30; 54],[12; 34; 37; 45],[11; 28; 30],[6; 13; 37; 45],[5],[7; 12; 35],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 47 (fst c) _. *) (* BuildDef 8 56  *)

 Definition s48 := Eval vm_compute in (step_checker s47 (List.nth 47 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s48. *) (* s48 = {| [52],[6],[8],[29; 30; 54],[12; 34; 37; 45],[11; 28; 30],[6; 13; 37; 45],[5],[10; 28; 56],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 48 (fst c) _. *) (* Res 5 {|8,5|} *)

 Definition s49 := Eval vm_compute in (step_checker s48 (List.nth 48 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s49. *) (* s49 = {| [52],[6],[8],[29; 30; 54],[12; 34; 37; 45],[28; 30; 56],[6; 13; 37; 45],[5],[10; 28; 56],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 49 (fst c) _. *) (* Res 5 {|3,5|} *)

 Definition s50 := Eval vm_compute in (step_checker s49 (List.nth 49 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s50. *) (* s50 = {| [52],[6],[8],[29; 30; 54],[12; 34; 37; 45],[30; 54; 56],[6; 13; 37; 45],[5],[10; 28; 56],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 50 (fst c) _. *) (* BuildDef2 3 31  *)

 Definition s51 := Eval vm_compute in (step_checker s50 (List.nth 50 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s51. *) (* s51 = {| [52],[6],[8],[11; 29; 31],[12; 34; 37; 45],[30; 54; 56],[6; 13; 37; 45],[5],[10; 28; 56],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 51 (fst c) _. *) (* Res 5 {|3,5|} *)

 Definition s52 := Eval vm_compute in (step_checker s51 (List.nth 51 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s52. *) (* s52 = {| [52],[6],[8],[11; 29; 31],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[10; 28; 56],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 52 (fst c) _. *) (* EqTr 3 32 [] *)

 Definition s53 := Eval vm_compute in (step_checker s52 (List.nth 52 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s53. *) (* s53 = {| [52],[6],[8],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[10; 28; 56],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 53 (fst c) _. *) (* BuildDef2 8 35  *)

 Definition s54 := Eval vm_compute in (step_checker s53 (List.nth 53 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s54. *) (* s54 = {| [52],[6],[8],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[7; 12; 35],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 54 (fst c) _. *) (* EqTr 9 36 [] *)

 Definition s55 := Eval vm_compute in (step_checker s54 (List.nth 54 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s55. *) (* s55 = {| [52],[6],[8],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[7; 12; 35],[36],[13; 34; 37; 45] |} *)

(*  Eval vm_compute in List.nth 55 (fst c) _. *) (* EqTr 10 38 [] *)

 Definition s56 := Eval vm_compute in (step_checker s55 (List.nth 55 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s56. *) (* s56 = {| [52],[6],[8],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[7; 12; 35],[36],[38] |} *)

(*  Eval vm_compute in List.nth 56 (fst c) _. *) (* EqTr 4 40 [] *)

 Definition s57 := Eval vm_compute in (step_checker s56 (List.nth 56 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s57. *) (* s57 = {| [52],[6],[8],[32],[40],[11; 29; 54; 56],[6; 13; 37; 45],[5],[7; 12; 35],[36],[38] |} *)

(*  Eval vm_compute in List.nth 57 (fst c) _. *) (* EqTr 6 42 [] *)

 Definition s58 := Eval vm_compute in (step_checker s57 (List.nth 57 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s58. *) (* s58 = {| [52],[6],[8],[32],[40],[11; 29; 54; 56],[42],[5],[7; 12; 35],[36],[38] |} *)

(*  Eval vm_compute in List.nth 58 (fst c) _. *) (* EqCgr 11 44 [S 39; S 41; S 43; S 9] *)

 Definition s59 := Eval vm_compute in (step_checker s58 (List.nth 58 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s59. *) (* s59 = {| [52],[6],[8],[32],[40],[11; 29; 54; 56],[42],[5],[7; 12; 35],[36],[38],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 59 (fst c) _. *) (* Res 2 {|11,10,4,6,2|} *)

 Definition s60 := Eval vm_compute in (step_checker s59 (List.nth 59 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s60. *) (* s60 = {| [52],[6],[44],[32],[40],[11; 29; 54; 56],[42],[5],[7; 12; 35],[36],[38],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 60 (fst c) _. *) (* EqTr 6 12 [45;7;37] *)

 Definition s61 := Eval vm_compute in (step_checker s60 (List.nth 60 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s61. *) (* s61 = {| [52],[6],[44],[32],[40],[11; 29; 54; 56],[7; 12; 37; 45],[5],[7; 12; 35],[36],[38],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 61 (fst c) _. *) (* BuildDef2 4 34  *)

 Definition s62 := Eval vm_compute in (step_checker s61 (List.nth 61 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s62. *) (* s62 = {| [52],[6],[44],[32],[6; 12; 34],[11; 29; 54; 56],[7; 12; 37; 45],[5],[7; 12; 35],[36],[38],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 62 (fst c) _. *) (* Res 4 {|6,4|} *)

 Definition s63 := Eval vm_compute in (step_checker s62 (List.nth 62 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s63. *) (* s63 = {| [52],[6],[44],[32],[12; 34; 37; 45],[11; 29; 54; 56],[7; 12; 37; 45],[5],[7; 12; 35],[36],[38],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 63 (fst c) _. *) (* EqTr 6 6 [45;13;37] *)

 Definition s64 := Eval vm_compute in (step_checker s63 (List.nth 63 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s64. *) (* s64 = {| [52],[6],[44],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[7; 12; 35],[36],[38],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 64 (fst c) _. *) (* BuildDef 10 34  *)

 Definition s65 := Eval vm_compute in (step_checker s64 (List.nth 64 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s65. *) (* s65 = {| [52],[6],[44],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[7; 12; 35],[36],[7; 13; 34],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 65 (fst c) _. *) (* Res 10 {|6,10|} *)

 Definition s66 := Eval vm_compute in (step_checker s65 (List.nth 65 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s66. *) (* s66 = {| [52],[6],[44],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[7; 12; 35],[36],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 66 (fst c) _. *) (* Res 2 {|4,10,9,2|} *)

 Definition s67 := Eval vm_compute in (step_checker s66 (List.nth 66 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s67. *) (* s67 = {| [52],[6],[34],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[7; 12; 35],[36],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 67 (fst c) _. *) (* Res 1 {|8,2,1|} *)

 Definition s68 := Eval vm_compute in (step_checker s67 (List.nth 67 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s68. *) (* s68 = {| [52],[12],[34],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[7; 12; 35],[36],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 68 (fst c) _. *) (* EqTr 2 4 [13;11;33] *)

 Definition s69 := Eval vm_compute in (step_checker s68 (List.nth 68 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s69. *) (* s69 = {| [52],[12],[4; 11; 13; 33],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[7; 12; 35],[36],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 69 (fst c) _. *) (* BuildDef2 8 46  *)

 Definition s70 := Eval vm_compute in (step_checker s69 (List.nth 69 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s70. *) (* s70 = {| [52],[12],[4; 11; 13; 33],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[4; 10; 46],[36],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 70 (fst c) _. *) (* Res 8 {|2,8|} *)

 Definition s71 := Eval vm_compute in (step_checker s70 (List.nth 70 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s71. *) (* s71 = {| [52],[12],[4; 11; 13; 33],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[4; 13; 33; 46],[36],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 71 (fst c) _. *) (* EqTr 2 10 [33;5;13] *)

 Definition s72 := Eval vm_compute in (step_checker s71 (List.nth 71 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s72. *) (* s72 = {| [52],[12],[5; 10; 13; 33],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[4; 13; 33; 46],[36],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 72 (fst c) _. *) (* BuildDef 9 46  *)

 Definition s73 := Eval vm_compute in (step_checker s72 (List.nth 72 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s73. *) (* s73 = {| [52],[12],[5; 10; 13; 33],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[4; 13; 33; 46],[5; 11; 46],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 73 (fst c) _. *) (* Res 9 {|2,9|} *)

 Definition s74 := Eval vm_compute in (step_checker s73 (List.nth 73 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s74. *) (* s74 = {| [52],[12],[5; 10; 13; 33],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[4; 13; 33; 46],[5; 13; 33; 46],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 74 (fst c) _. *) (* Res 1 {|8,9,3,1|} *)

 Definition s75 := Eval vm_compute in (step_checker s74 (List.nth 74 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s75. *) (* s75 = {| [52],[46],[5; 10; 13; 33],[32],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[4; 13; 33; 46],[5; 13; 33; 46],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 75 (fst c) _. *) (* BuildDef 3 50  *)

 Definition s76 := Eval vm_compute in (step_checker s75 (List.nth 75 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s76. *) (* s76 = {| [52],[46],[5; 10; 13; 33],[4; 49; 50],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[4; 13; 33; 46],[5; 13; 33; 46],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 76 (fst c) _. *) (* BuildDef 9 58  *)

 Definition s77 := Eval vm_compute in (step_checker s76 (List.nth 76 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s77. *) (* s77 = {| [52],[46],[5; 10; 13; 33],[4; 49; 50],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[4; 13; 33; 46],[5; 49; 58],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 77 (fst c) _. *) (* Res 3 {|9,3|} *)

 Definition s78 := Eval vm_compute in (step_checker s77 (List.nth 77 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s78. *) (* s78 = {| [52],[46],[5; 10; 13; 33],[49; 50; 58],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[4; 13; 33; 46],[5; 49; 58],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 78 (fst c) _. *) (* BuildDef2 9 50  *)

 Definition s79 := Eval vm_compute in (step_checker s78 (List.nth 78 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s79. *) (* s79 = {| [52],[46],[5; 10; 13; 33],[49; 50; 58],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[4; 13; 33; 46],[5; 48; 50],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 79 (fst c) _. *) (* BuildDef 8 60  *)

 Definition s80 := Eval vm_compute in (step_checker s79 (List.nth 79 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s80. *) (* s80 = {| [52],[46],[5; 10; 13; 33],[49; 50; 58],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[4; 48; 60],[5; 48; 50],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 80 (fst c) _. *) (* Res 9 {|8,9|} *)

 Definition s81 := Eval vm_compute in (step_checker s80 (List.nth 80 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s81. *) (* s81 = {| [52],[46],[5; 10; 13; 33],[49; 50; 58],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[4; 48; 60],[48; 50; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 81 (fst c) _. *) (* Res 9 {|3,9|} *)

 Definition s82 := Eval vm_compute in (step_checker s81 (List.nth 81 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s82. *) (* s82 = {| [52],[46],[5; 10; 13; 33],[49; 50; 58],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[4; 48; 60],[50; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 82 (fst c) _. *) (* BuildDef 3 51  *)

 Definition s83 := Eval vm_compute in (step_checker s82 (List.nth 82 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s83. *) (* s83 = {| [52],[46],[5; 10; 13; 33],[4; 48; 51],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[4; 48; 60],[50; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 83 (fst c) _. *) (* Res 9 {|3,9|} *)

 Definition s84 := Eval vm_compute in (step_checker s83 (List.nth 83 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s84. *) (* s84 = {| [52],[46],[5; 10; 13; 33],[4; 48; 51],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[5],[4; 48; 60],[4; 48; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 84 (fst c) _. *) (* Res 7 {|9,7|} *)

 Definition s85 := Eval vm_compute in (step_checker s84 (List.nth 84 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s85. *) (* s85 = {| [52],[46],[5; 10; 13; 33],[4; 48; 51],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[48; 58; 60],[4; 48; 60],[4; 48; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 85 (fst c) _. *) (* BuildDef 9 47  *)

 Definition s86 := Eval vm_compute in (step_checker s85 (List.nth 85 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s86. *) (* s86 = {| [52],[46],[5; 10; 13; 33],[4; 48; 51],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[48; 58; 60],[4; 48; 60],[5; 10; 47],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 86 (fst c) _. *) (* Res 9 {|9,1|} *)

 Definition s87 := Eval vm_compute in (step_checker s86 (List.nth 86 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s87. *) (* s87 = {| [52],[46],[5; 10; 13; 33],[4; 48; 51],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[48; 58; 60],[4; 48; 60],[5; 10],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 87 (fst c) _. *) (* BuildDef 3 49  *)

 Definition s88 := Eval vm_compute in (step_checker s87 (List.nth 87 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s88. *) (* s88 = {| [52],[46],[5; 10; 13; 33],[3; 4; 49],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[48; 58; 60],[4; 48; 60],[5; 10],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 88 (fst c) _. *) (* Res 3 {|3,7|} *)

 Definition s89 := Eval vm_compute in (step_checker s88 (List.nth 88 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s89. *) (* s89 = {| [52],[46],[5; 10; 13; 33],[3; 4; 58; 60],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[48; 58; 60],[4; 48; 60],[5; 10],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 89 (fst c) _. *) (* Res 3 {|9,3|} *)

 Definition s90 := Eval vm_compute in (step_checker s89 (List.nth 89 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s90. *) (* s90 = {| [52],[46],[5; 10; 13; 33],[3; 10; 58; 60],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[48; 58; 60],[4; 48; 60],[5; 10],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 90 (fst c) _. *) (* BuildDef2 9 28  *)

 Definition s91 := Eval vm_compute in (step_checker s90 (List.nth 90 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s91. *) (* s91 = {| [52],[46],[5; 10; 13; 33],[3; 10; 58; 60],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[48; 58; 60],[4; 48; 60],[2; 10; 28],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 91 (fst c) _. *) (* Res 9 {|3,9|} *)

 Definition s92 := Eval vm_compute in (step_checker s91 (List.nth 91 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s92. *) (* s92 = {| [52],[46],[5; 10; 13; 33],[3; 10; 58; 60],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[48; 58; 60],[4; 48; 60],[10; 28; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 92 (fst c) _. *) (* BuildDef2 3 47  *)

 Definition s93 := Eval vm_compute in (step_checker s92 (List.nth 92 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s93. *) (* s93 = {| [52],[46],[5; 10; 13; 33],[4; 11; 47],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[48; 58; 60],[4; 48; 60],[10; 28; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 93 (fst c) _. *) (* Res 1 {|3,1|} *)

 Definition s94 := Eval vm_compute in (step_checker s93 (List.nth 93 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s94. *) (* s94 = {| [52],[4; 11],[5; 10; 13; 33],[4; 11; 47],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[48; 58; 60],[4; 48; 60],[10; 28; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 94 (fst c) _. *) (* BuildDef2 3 49  *)

 Definition s95 := Eval vm_compute in (step_checker s94 (List.nth 94 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s95. *) (* s95 = {| [52],[4; 11],[5; 10; 13; 33],[2; 5; 49],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[48; 58; 60],[4; 48; 60],[10; 28; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 95 (fst c) _. *) (* Res 7 {|3,7|} *)

 Definition s96 := Eval vm_compute in (step_checker s95 (List.nth 95 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s96. *) (* s96 = {| [52],[4; 11],[5; 10; 13; 33],[2; 5; 49],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[2; 5; 58; 60],[4; 48; 60],[10; 28; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 96 (fst c) _. *) (* Res 7 {|1,7|} *)

 Definition s97 := Eval vm_compute in (step_checker s96 (List.nth 96 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s97. *) (* s97 = {| [52],[4; 11],[5; 10; 13; 33],[2; 5; 49],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[2; 11; 58; 60],[4; 48; 60],[10; 28; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 97 (fst c) _. *) (* BuildDef 1 28  *)

 Definition s98 := Eval vm_compute in (step_checker s97 (List.nth 97 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s98. *) (* s98 = {| [52],[3; 11; 28],[5; 10; 13; 33],[2; 5; 49],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[2; 11; 58; 60],[4; 48; 60],[10; 28; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 98 (fst c) _. *) (* Res 1 {|7,1|} *)

 Definition s99 := Eval vm_compute in (step_checker s98 (List.nth 98 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s99. *) (* s99 = {| [52],[11; 28; 58; 60],[5; 10; 13; 33],[2; 5; 49],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[2; 11; 58; 60],[4; 48; 60],[10; 28; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 99 (fst c) _. *) (* Res 1 {|9,1|} *)

 Definition s100 := Eval vm_compute in (step_checker s99 (List.nth 99 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s100. *) (* s100 = {| [52],[28; 58; 60],[5; 10; 13; 33],[2; 5; 49],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[2; 11; 58; 60],[4; 48; 60],[10; 28; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 100 (fst c) _. *) (* Res 1 {|5,1|} *)

 Definition s101 := Eval vm_compute in (step_checker s100 (List.nth 100 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s101. *) (* s101 = {| [52],[11; 54; 56; 58; 60],[5; 10; 13; 33],[2; 5; 49],[12; 34; 37; 45],[11; 29; 54; 56],[6; 13; 37; 45],[2; 11; 58; 60],[4; 48; 60],[10; 28; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 101 (fst c) _. *) (* BuildProj 5 53 2  *)

 Definition s102 := Eval vm_compute in (step_checker s101 (List.nth 101 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s102. *) (* s102 = {| [52],[11; 54; 56; 58; 60],[5; 10; 13; 33],[2; 5; 49],[12; 34; 37; 45],[10; 53],[6; 13; 37; 45],[2; 11; 58; 60],[4; 48; 60],[10; 28; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 102 (fst c) _. *) (* Res 5 {|0,5|} *)

 Definition s103 := Eval vm_compute in (step_checker s102 (List.nth 102 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s103. *) (* s103 = {| [52],[11; 54; 56; 58; 60],[5; 10; 13; 33],[2; 5; 49],[12; 34; 37; 45],[10],[6; 13; 37; 45],[2; 11; 58; 60],[4; 48; 60],[10; 28; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)

(*  Eval vm_compute in List.nth 103 (fst c) _. *) (* Res 5 {|1,5|} *)

 Definition s104 := Eval vm_compute in (step_checker s103 (List.nth 103 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s104. *) (* s104 = {| [52],[11; 54; 56; 58; 60],[5; 10; 13; 33],[2; 5; 49],[12; 34; 37; 45],[54; 56; 58; 60],[6; 13; 37; 45],[2; 11; 58; 60],[4; 48; 60],[10; 28; 58; 60],[13; 34; 37; 45],[9; 39; 41; 43; 44] |} *)
End thesistest5smt2debug.