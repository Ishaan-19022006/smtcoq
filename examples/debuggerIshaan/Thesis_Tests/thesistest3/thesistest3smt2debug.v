Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool. 
Require Import Int31. 
Local Open Scope int31_scope.

Section thesistest3smt2debug.

 Parse_certif_verit t_i t_func t_atom t_form root used_roots trace 
 "Thesis_Tests/thesistest3/thesistest3.smt2" 
 "Thesis_Tests/thesistest3/thesistest3.pf". 

 Definition nclauses := Eval vm_compute in (match trace with Certif a _ _ => a end). (* Size of the state *)
(*  Print nclauses. *) (* 11 *)

  Definition c := Eval vm_compute in (match trace with Certif _ a _ => a end). (* Certificate *)
 Definition conf := Eval vm_compute in (match trace with Certif _ _ a => a end). (* Look here in the state for the empty clause*)
(*  Print conf. *) (* 0 *)

(*  Eval vm_compute in List.length (fst c). (* No. of steps in certificate *) *) (* 57 *)

(*  Eval vm_compute in (Form.check_form t_form && Atom.check_atom t_atom && Atom.wt t_i t_func t_atom). *) (* true *)

 (* States from c *) 

(* Start state *) 

 Definition s0 := Eval vm_compute in (add_roots (S.make nclauses) root used_roots). 
(*   Print s0. *) (* s0 = {| [9],[10],[12] |} *)

(*  Eval vm_compute in List.nth 0 (fst c) _. *) (* BuildProj 3 14 0  *)

 Definition s1 := Eval vm_compute in (step_checker s0 (List.nth 0 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s1. *) (* s1 = {| [9],[10],[12],[4; 14] |} *)

(*  Eval vm_compute in List.nth 1 (fst c) _. *) (* BuildDef 4 26  *)

 Definition s2 := Eval vm_compute in (step_checker s1 (List.nth 1 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s2. *) (* s2 = {| [9],[10],[12],[4; 14],[5; 6; 26] |} *)

(*  Eval vm_compute in List.nth 2 (fst c) _. *) (* Res 4 {|3,4|} *)

 Definition s3 := Eval vm_compute in (step_checker s2 (List.nth 2 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s3. *) (* s3 = {| [9],[10],[12],[4; 14],[6; 14; 26] |} *)

(*  Eval vm_compute in List.nth 3 (fst c) _. *) (* BuildProj 3 14 1  *)

 Definition s4 := Eval vm_compute in (step_checker s3 (List.nth 3 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s4. *) (* s4 = {| [9],[10],[12],[7; 14],[6; 14; 26] |} *)

(*  Eval vm_compute in List.nth 4 (fst c) _. *) (* Res 3 {|4,3|} *)

 Definition s5 := Eval vm_compute in (step_checker s4 (List.nth 4 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s5. *) (* s5 = {| [9],[10],[12],[14; 26],[6; 14; 26] |} *)

(*  Eval vm_compute in List.nth 5 (fst c) _. *) (* BuildDef 4 15  *)

 Definition s6 := Eval vm_compute in (step_checker s5 (List.nth 5 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s6. *) (* s6 = {| [9],[10],[12],[14; 26],[5; 6; 15] |} *)

(*  Eval vm_compute in List.nth 6 (fst c) _. *) (* Res 3 {|4,3|} *)

 Definition s7 := Eval vm_compute in (step_checker s6 (List.nth 6 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s7. *) (* s7 = {| [9],[10],[12],[5; 6; 26],[5; 6; 15] |} *)

(*  Eval vm_compute in List.nth 7 (fst c) _. *) (* ImmBuildDef2 4 0  *)

 Definition s8 := Eval vm_compute in (step_checker s7 (List.nth 7 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s8. *) (* s8 = {| [9],[10],[12],[5; 6; 26],[4; 6] |} *)

(*  Eval vm_compute in List.nth 8 (fst c) _. *) (* BuildDef 5 16  *)

 Definition s9 := Eval vm_compute in (step_checker s8 (List.nth 8 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s9. *) (* s9 = {| [9],[10],[12],[5; 6; 26],[4; 6],[7; 11; 13; 16] |} *)

(*  Eval vm_compute in List.nth 9 (fst c) _. *) (* BuildProj 6 18 0  *)

 Definition s10 := Eval vm_compute in (step_checker s9 (List.nth 9 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s10. *) (* s10 = {| [9],[10],[12],[5; 6; 26],[4; 6],[7; 11; 13; 16],[16; 18] |} *)

(*  Eval vm_compute in List.nth 10 (fst c) _. *) (* BuildDef 7 28  *)

 Definition s11 := Eval vm_compute in (step_checker s10 (List.nth 10 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s11. *) (* s11 = {| [9],[10],[12],[5; 6; 26],[4; 6],[7; 11; 13; 16],[16; 18],[4; 7; 11; 13; 28] |} *)

(*  Eval vm_compute in List.nth 11 (fst c) _. *) (* BuildProj 8 17 0  *)

 Definition s12 := Eval vm_compute in (step_checker s11 (List.nth 11 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s12. *) (* s12 = {| [9],[10],[12],[5; 6; 26],[4; 6],[7; 11; 13; 16],[16; 18],[4; 7; 11; 13; 28],[6; 17] |} *)

(*  Eval vm_compute in List.nth 12 (fst c) _. *) (* BuildProj 9 17 1  *)

 Definition s13 := Eval vm_compute in (step_checker s12 (List.nth 12 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s13. *) (* s13 = {| [9],[10],[12],[5; 6; 26],[4; 6],[7; 11; 13; 16],[16; 18],[4; 7; 11; 13; 28],[6; 17],[10; 17] |} *)

(*  Eval vm_compute in List.nth 13 (fst c) _. *) (* BuildProj 10 17 2  *)

 Definition s14 := Eval vm_compute in (step_checker s13 (List.nth 13 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s14. *) (* s14 = {| [9],[10],[12],[5; 6; 26],[4; 6],[7; 11; 13; 16],[16; 18],[4; 7; 11; 13; 28],[6; 17],[10; 17],[12; 17] |} *)

(*  Eval vm_compute in List.nth 14 (fst c) _. *) (* Res 10 {|7,8,9,10|} *)

 Definition s15 := Eval vm_compute in (step_checker s14 (List.nth 14 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s15. *) (* s15 = {| [9],[10],[12],[5; 6; 26],[4; 6],[7; 11; 13; 16],[16; 18],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 17; 28] |} *)

(*  Eval vm_compute in List.nth 15 (fst c) _. *) (* Res 10 {|6,10|} *)

 Definition s16 := Eval vm_compute in (step_checker s15 (List.nth 15 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s16. *) (* s16 = {| [9],[10],[12],[5; 6; 26],[4; 6],[7; 11; 13; 16],[16; 18],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 18; 28] |} *)

(*  Eval vm_compute in List.nth 16 (fst c) _. *) (* BuildProj 6 18 1  *)

 Definition s17 := Eval vm_compute in (step_checker s16 (List.nth 16 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s17. *) (* s17 = {| [9],[10],[12],[5; 6; 26],[4; 6],[7; 11; 13; 16],[5; 18],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 18; 28] |} *)

(*  Eval vm_compute in List.nth 17 (fst c) _. *) (* Res 6 {|10,6|} *)

 Definition s18 := Eval vm_compute in (step_checker s17 (List.nth 17 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s18. *) (* s18 = {| [9],[10],[12],[5; 6; 26],[4; 6],[7; 11; 13; 16],[18; 28],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 18; 28] |} *)

(*  Eval vm_compute in List.nth 18 (fst c) _. *) (* BuildDef 10 19  *)

 Definition s19 := Eval vm_compute in (step_checker s18 (List.nth 18 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s19. *) (* s19 = {| [9],[10],[12],[5; 6; 26],[4; 6],[7; 11; 13; 16],[18; 28],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 17; 19] |} *)

(*  Eval vm_compute in List.nth 19 (fst c) _. *) (* Res 6 {|10,6|} *)

 Definition s20 := Eval vm_compute in (step_checker s19 (List.nth 19 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s20. *) (* s20 = {| [9],[10],[12],[5; 6; 26],[4; 6],[7; 11; 13; 16],[4; 17; 28],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 17; 19] |} *)

(*  Eval vm_compute in List.nth 20 (fst c) _. *) (* Res 6 {|5,6|} *)

 Definition s21 := Eval vm_compute in (step_checker s20 (List.nth 20 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s21. *) (* s21 = {| [9],[10],[12],[5; 6; 26],[4; 6],[7; 11; 13; 16],[4; 7; 11; 13; 28],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 17; 19] |} *)

(*  Eval vm_compute in List.nth 21 (fst c) _. *) (* ImmBuildDef 0 0  *)

 Definition s22 := Eval vm_compute in (step_checker s21 (List.nth 21 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s22. *) (* s22 = {| [5; 7],[10],[12],[5; 6; 26],[4; 6],[7; 11; 13; 16],[4; 7; 11; 13; 28],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 17; 19] |} *)

(*  Eval vm_compute in List.nth 22 (fst c) _. *) (* Res 0 {|6,2,1,0|} *)

 Definition s23 := Eval vm_compute in (step_checker s22 (List.nth 22 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s23. *) (* s23 = {| [7; 28],[10],[12],[5; 6; 26],[4; 6],[7; 11; 13; 16],[4; 7; 11; 13; 28],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 17; 19] |} *)

(*  Eval vm_compute in List.nth 23 (fst c) _. *) (* Res 4 {|4,0|} *)

 Definition s24 := Eval vm_compute in (step_checker s23 (List.nth 23 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s24. *) (* s24 = {| [7; 28],[10],[12],[5; 6; 26],[4; 28],[7; 11; 13; 16],[4; 7; 11; 13; 28],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 17; 19] |} *)

(*  Eval vm_compute in List.nth 24 (fst c) _. *) (* Res 0 {|3,4,0|} *)

 Definition s25 := Eval vm_compute in (step_checker s24 (List.nth 24 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s25. *) (* s25 = {| [26; 28],[10],[12],[5; 6; 26],[4; 28],[7; 11; 13; 16],[4; 7; 11; 13; 28],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 17; 19] |} *)

(*  Eval vm_compute in List.nth 25 (fst c) _. *) (* BuildProj 4 29 0  *)

 Definition s26 := Eval vm_compute in (step_checker s25 (List.nth 25 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s26. *) (* s26 = {| [26; 28],[10],[12],[5; 6; 26],[6; 29],[7; 11; 13; 16],[4; 7; 11; 13; 28],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 17; 19] |} *)

(*  Eval vm_compute in List.nth 26 (fst c) _. *) (* Res 4 {|0,4|} *)

 Definition s27 := Eval vm_compute in (step_checker s26 (List.nth 26 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s27. *) (* s27 = {| [26; 28],[10],[12],[5; 6; 26],[6; 26],[7; 11; 13; 16],[4; 7; 11; 13; 28],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 17; 19] |} *)

(*  Eval vm_compute in List.nth 27 (fst c) _. *) (* BuildProj 3 22 0  *)

 Definition s28 := Eval vm_compute in (step_checker s27 (List.nth 27 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s28. *) (* s28 = {| [26; 28],[10],[12],[20; 22],[6; 26],[7; 11; 13; 16],[4; 7; 11; 13; 28],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 17; 19] |} *)

(*  Eval vm_compute in List.nth 28 (fst c) _. *) (* BuildDef 6 30  *)

 Definition s29 := Eval vm_compute in (step_checker s28 (List.nth 28 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s29. *) (* s29 = {| [26; 28],[10],[12],[20; 22],[6; 26],[7; 11; 13; 16],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 17; 19] |} *)

(*  Eval vm_compute in List.nth 29 (fst c) _. *) (* BuildProj 5 21 0  *)

 Definition s30 := Eval vm_compute in (step_checker s29 (List.nth 29 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s30. *) (* s30 = {| [26; 28],[10],[12],[20; 22],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[10; 17],[4; 17; 19] |} *)

(*  Eval vm_compute in List.nth 30 (fst c) _. *) (* BuildProj 10 21 1  *)

 Definition s31 := Eval vm_compute in (step_checker s30 (List.nth 30 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s31. *) (* s31 = {| [26; 28],[10],[12],[20; 22],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[10; 17],[6; 21] |} *)

(*  Eval vm_compute in List.nth 31 (fst c) _. *) (* BuildProj 9 21 2  *)

 Definition s32 := Eval vm_compute in (step_checker s31 (List.nth 31 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s32. *) (* s32 = {| [26; 28],[10],[12],[20; 22],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[10; 21],[6; 21] |} *)

(*  Eval vm_compute in List.nth 32 (fst c) _. *) (* Res 9 {|6,5,10,9|} *)

 Definition s33 := Eval vm_compute in (step_checker s32 (List.nth 32 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s33. *) (* s33 = {| [26; 28],[10],[12],[20; 22],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[4; 21; 30],[6; 21] |} *)

(*  Eval vm_compute in List.nth 33 (fst c) _. *) (* Res 9 {|3,9|} *)

 Definition s34 := Eval vm_compute in (step_checker s33 (List.nth 33 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s34. *) (* s34 = {| [26; 28],[10],[12],[20; 22],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[4; 22; 30],[6; 21] |} *)

(*  Eval vm_compute in List.nth 34 (fst c) _. *) (* BuildProj 3 22 1  *)

 Definition s35 := Eval vm_compute in (step_checker s34 (List.nth 34 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s35. *) (* s35 = {| [26; 28],[10],[12],[5; 22],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[4; 22; 30],[6; 21] |} *)

(*  Eval vm_compute in List.nth 35 (fst c) _. *) (* Res 3 {|9,3|} *)

 Definition s36 := Eval vm_compute in (step_checker s35 (List.nth 35 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s36. *) (* s36 = {| [26; 28],[10],[12],[22; 30],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[4; 22; 30],[6; 21] |} *)

(*  Eval vm_compute in List.nth 36 (fst c) _. *) (* BuildDef 9 23  *)

 Definition s37 := Eval vm_compute in (step_checker s36 (List.nth 36 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s37. *) (* s37 = {| [26; 28],[10],[12],[22; 30],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[4; 21; 23],[6; 21] |} *)

(*  Eval vm_compute in List.nth 37 (fst c) _. *) (* Res 3 {|9,3|} *)

 Definition s38 := Eval vm_compute in (step_checker s37 (List.nth 37 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s38. *) (* s38 = {| [26; 28],[10],[12],[4; 21; 30],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[4; 21; 23],[6; 21] |} *)

(*  Eval vm_compute in List.nth 38 (fst c) _. *) (* BuildDef 9 20  *)

 Definition s39 := Eval vm_compute in (step_checker s38 (List.nth 38 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s39. *) (* s39 = {| [26; 28],[10],[12],[4; 21; 30],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 39 (fst c) _. *) (* Res 1 {|9,2,4,1|} *)

 Definition s40 := Eval vm_compute in (step_checker s39 (List.nth 39 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s40. *) (* s40 = {| [26; 28],[20; 26],[12],[4; 21; 30],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 40 (fst c) _. *) (* Res 1 {|3,1|} *)

 Definition s41 := Eval vm_compute in (step_checker s40 (List.nth 40 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s41. *) (* s41 = {| [26; 28],[4; 26; 30],[12],[4; 21; 30],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 41 (fst c) _. *) (* BuildProj 3 29 3  *)

 Definition s42 := Eval vm_compute in (step_checker s41 (List.nth 41 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s42. *) (* s42 = {| [26; 28],[4; 26; 30],[12],[5; 29],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 42 (fst c) _. *) (* Res 3 {|0,3|} *)

 Definition s43 := Eval vm_compute in (step_checker s42 (List.nth 42 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s43. *) (* s43 = {| [26; 28],[4; 26; 30],[12],[5; 26],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 43 (fst c) _. *) (* Res 3 {|1,3|} *)

 Definition s44 := Eval vm_compute in (step_checker s43 (List.nth 43 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s44. *) (* s44 = {| [26; 28],[4; 26; 30],[12],[26; 30],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 44 (fst c) _. *) (* BuildProj 1 27 0  *)

 Definition s45 := Eval vm_compute in (step_checker s44 (List.nth 44 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s45. *) (* s45 = {| [26; 28],[4; 27],[12],[26; 30],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 45 (fst c) _. *) (* Res 1 {|3,1|} *)

 Definition s46 := Eval vm_compute in (step_checker s45 (List.nth 45 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s46. *) (* s46 = {| [26; 28],[4; 30],[12],[26; 30],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 46 (fst c) _. *) (* BuildProj 0 14 0  *)

 Definition s47 := Eval vm_compute in (step_checker s46 (List.nth 46 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s47. *) (* s47 = {| [4; 14],[4; 30],[12],[26; 30],[6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 47 (fst c) _. *) (* BuildDef 4 26  *)

 Definition s48 := Eval vm_compute in (step_checker s47 (List.nth 47 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s48. *) (* s48 = {| [4; 14],[4; 30],[12],[26; 30],[5; 6; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 48 (fst c) _. *) (* Res 4 {|0,4|} *)

 Definition s49 := Eval vm_compute in (step_checker s48 (List.nth 48 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s49. *) (* s49 = {| [4; 14],[4; 30],[12],[26; 30],[6; 14; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 49 (fst c) _. *) (* BuildProj 0 14 1  *)

 Definition s50 := Eval vm_compute in (step_checker s49 (List.nth 49 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s50. *) (* s50 = {| [7; 14],[4; 30],[12],[26; 30],[6; 14; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 50 (fst c) _. *) (* Res 0 {|4,0|} *)

 Definition s51 := Eval vm_compute in (step_checker s50 (List.nth 50 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s51. *) (* s51 = {| [14; 26],[4; 30],[12],[26; 30],[6; 14; 26],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 51 (fst c) _. *) (* BuildDef 4 15  *)

 Definition s52 := Eval vm_compute in (step_checker s51 (List.nth 51 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s52. *) (* s52 = {| [14; 26],[4; 30],[12],[26; 30],[5; 6; 15],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 52 (fst c) _. *) (* Res 0 {|4,0|} *)

 Definition s53 := Eval vm_compute in (step_checker s52 (List.nth 52 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s53. *) (* s53 = {| [5; 6; 26],[4; 30],[12],[26; 30],[5; 6; 15],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 53 (fst c) _. *) (* Res 1 {|0,1|} *)

 Definition s54 := Eval vm_compute in (step_checker s53 (List.nth 53 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s54. *) (* s54 = {| [5; 6; 26],[6; 26; 30],[12],[26; 30],[5; 6; 15],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 54 (fst c) _. *) (* BuildProj 0 27 1  *)

 Definition s55 := Eval vm_compute in (step_checker s54 (List.nth 54 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s55. *) (* s55 = {| [7; 27],[6; 26; 30],[12],[26; 30],[5; 6; 15],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 55 (fst c) _. *) (* Res 0 {|3,0|} *)

 Definition s56 := Eval vm_compute in (step_checker s55 (List.nth 55 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s56. *) (* s56 = {| [7; 30],[6; 26; 30],[12],[26; 30],[5; 6; 15],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)

(*  Eval vm_compute in List.nth 56 (fst c) _. *) (* Res 0 {|1,0|} *)

 Definition s57 := Eval vm_compute in (step_checker s56 (List.nth 56 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s57. *) (* s57 = {| [26; 30],[6; 26; 30],[12],[26; 30],[5; 6; 15],[12; 21],[4; 7; 11; 13; 30],[4; 7; 11; 13; 28],[6; 17],[7; 11; 13; 20],[6; 21] |} *)
End thesistest3smt2debug.