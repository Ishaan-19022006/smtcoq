Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool. 
Require Import Int31. 
Local Open Scope int31_scope.

Section thesistest4smt2debug.

 Parse_certif_verit t_i t_func t_atom t_form root used_roots trace 
 "Thesis_Tests/thesistest4/thesistest4.smt2" 
 "Thesis_Tests/thesistest4/thesistest4.pf". 

 Definition nclauses := Eval vm_compute in (match trace with Certif a _ _ => a end). (* Size of the state *)
(*  Print nclauses. *) (* 11 *)

  Definition c := Eval vm_compute in (match trace with Certif _ a _ => a end). (* Certificate *)
 Definition conf := Eval vm_compute in (match trace with Certif _ _ a => a end). (* Look here in the state for the empty clause*)
(*  Print conf. *) (* 8 *)

(*  Eval vm_compute in List.length (fst c). (* No. of steps in certificate *) *) (* 85 *)

(*  Eval vm_compute in (Form.check_form t_form && Atom.check_atom t_atom && Atom.wt t_i t_func t_atom). *) (* true *)

 (* States from c *) 

(* Start state *) 

 Definition s0 := Eval vm_compute in (add_roots (S.make nclauses) root used_roots). 
(*   Print s0. *) (* s0 = {| [9],[10],[14] |} *)

(*  Eval vm_compute in List.nth 0 (fst c) _. *) (* BuildDef2 3 18  *)

 Definition s1 := Eval vm_compute in (step_checker s0 (List.nth 0 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s1. *) (* s1 = {| [9],[10],[14],[16; 18] |} *)

(*  Eval vm_compute in List.nth 1 (fst c) _. *) (* Weaken 3 3 [18;16] *)

 Definition s2 := Eval vm_compute in (step_checker s1 (List.nth 1 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s2. *) (* s2 = {| [9],[10],[14],[16; 18] |} *)

(*  Eval vm_compute in List.nth 2 (fst c) _. *) (* BuildDef 4 18  *)

 Definition s3 := Eval vm_compute in (step_checker s2 (List.nth 2 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s3. *) (* s3 = {| [9],[10],[14],[16; 18],[17; 18] |} *)

(*  Eval vm_compute in List.nth 3 (fst c) _. *) (* Weaken 4 4 [18;17] *)

 Definition s4 := Eval vm_compute in (step_checker s3 (List.nth 3 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s4. *) (* s4 = {| [9],[10],[14],[16; 18],[17; 18] |} *)

(*  Eval vm_compute in List.nth 4 (fst c) _. *) (* Res 4 {|3,4|} *)

 Definition s5 := Eval vm_compute in (step_checker s4 (List.nth 4 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s5. *) (* s5 = {| [9],[10],[14],[16; 18],[18] |} *)

(*  Eval vm_compute in List.nth 5 (fst c) _. *) (* BuildDef 3 26  *)

 Definition s6 := Eval vm_compute in (step_checker s5 (List.nth 5 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s6. *) (* s6 = {| [9],[10],[14],[6; 11; 26],[18] |} *)

(*  Eval vm_compute in List.nth 6 (fst c) _. *) (* BuildProj 5 28 0  *)

 Definition s7 := Eval vm_compute in (step_checker s6 (List.nth 6 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s7. *) (* s7 = {| [9],[10],[14],[6; 11; 26],[18],[26; 28] |} *)

(*  Eval vm_compute in List.nth 7 (fst c) _. *) (* BuildDef 6 58  *)

 Definition s8 := Eval vm_compute in (step_checker s7 (List.nth 7 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s8. *) (* s8 = {| [9],[10],[14],[6; 11; 26],[18],[26; 28],[6; 11; 13; 58] |} *)

(*  Eval vm_compute in List.nth 8 (fst c) _. *) (* BuildProj 7 27 0  *)

 Definition s9 := Eval vm_compute in (step_checker s8 (List.nth 8 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s9. *) (* s9 = {| [9],[10],[14],[6; 11; 26],[18],[26; 28],[6; 11; 13; 58],[10; 27] |} *)

(*  Eval vm_compute in List.nth 9 (fst c) _. *) (* BuildProj 8 27 1  *)

 Definition s10 := Eval vm_compute in (step_checker s9 (List.nth 9 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s10. *) (* s10 = {| [9],[10],[14],[6; 11; 26],[18],[26; 28],[6; 11; 13; 58],[10; 27],[7; 27] |} *)

(*  Eval vm_compute in List.nth 10 (fst c) _. *) (* Res 8 {|6,7,8|} *)

 Definition s11 := Eval vm_compute in (step_checker s10 (List.nth 10 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s11. *) (* s11 = {| [9],[10],[14],[6; 11; 26],[18],[26; 28],[6; 11; 13; 58],[10; 27],[13; 27; 58] |} *)

(*  Eval vm_compute in List.nth 11 (fst c) _. *) (* Res 8 {|5,8|} *)

 Definition s12 := Eval vm_compute in (step_checker s11 (List.nth 11 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s12. *) (* s12 = {| [9],[10],[14],[6; 11; 26],[18],[26; 28],[6; 11; 13; 58],[10; 27],[13; 28; 58] |} *)

(*  Eval vm_compute in List.nth 12 (fst c) _. *) (* BuildProj 5 28 1  *)

 Definition s13 := Eval vm_compute in (step_checker s12 (List.nth 12 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s13. *) (* s13 = {| [9],[10],[14],[6; 11; 26],[18],[12; 28],[6; 11; 13; 58],[10; 27],[13; 28; 58] |} *)

(*  Eval vm_compute in List.nth 13 (fst c) _. *) (* Res 5 {|8,5|} *)

 Definition s14 := Eval vm_compute in (step_checker s13 (List.nth 13 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s14. *) (* s14 = {| [9],[10],[14],[6; 11; 26],[18],[28; 58],[6; 11; 13; 58],[10; 27],[13; 28; 58] |} *)

(*  Eval vm_compute in List.nth 14 (fst c) _. *) (* BuildDef 8 29  *)

 Definition s15 := Eval vm_compute in (step_checker s14 (List.nth 14 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s15. *) (* s15 = {| [9],[10],[14],[6; 11; 26],[18],[28; 58],[6; 11; 13; 58],[10; 27],[13; 27; 29] |} *)

(*  Eval vm_compute in List.nth 15 (fst c) _. *) (* Res 5 {|8,5|} *)

 Definition s16 := Eval vm_compute in (step_checker s15 (List.nth 15 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s16. *) (* s16 = {| [9],[10],[14],[6; 11; 26],[18],[13; 27; 58],[6; 11; 13; 58],[10; 27],[13; 27; 29] |} *)

(*  Eval vm_compute in List.nth 16 (fst c) _. *) (* Res 5 {|3,5|} *)

 Definition s17 := Eval vm_compute in (step_checker s16 (List.nth 16 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s17. *) (* s17 = {| [9],[10],[14],[6; 11; 26],[18],[6; 11; 13; 58],[6; 11; 13; 58],[10; 27],[13; 27; 29] |} *)

(*  Eval vm_compute in List.nth 17 (fst c) _. *) (* BuildProj 3 16 0  *)

 Definition s18 := Eval vm_compute in (step_checker s17 (List.nth 17 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s18. *) (* s18 = {| [9],[10],[14],[10; 16],[18],[6; 11; 13; 58],[6; 11; 13; 58],[10; 27],[13; 27; 29] |} *)

(*  Eval vm_compute in List.nth 18 (fst c) _. *) (* BuildProj 8 16 1  *)

 Definition s19 := Eval vm_compute in (step_checker s18 (List.nth 18 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s19. *) (* s19 = {| [9],[10],[14],[10; 16],[18],[6; 11; 13; 58],[6; 11; 13; 58],[10; 27],[7; 16] |} *)

(*  Eval vm_compute in List.nth 19 (fst c) _. *) (* BuildProj 7 16 2  *)

 Definition s20 := Eval vm_compute in (step_checker s19 (List.nth 19 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s20. *) (* s20 = {| [9],[10],[14],[10; 16],[18],[6; 11; 13; 58],[6; 11; 13; 58],[12; 16],[7; 16] |} *)

(*  Eval vm_compute in List.nth 20 (fst c) _. *) (* Res 7 {|5,3,8,7|} *)

 Definition s21 := Eval vm_compute in (step_checker s20 (List.nth 20 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s21. *) (* s21 = {| [9],[10],[14],[10; 16],[18],[6; 11; 13; 58],[6; 11; 13; 58],[16; 58],[7; 16] |} *)

(*  Eval vm_compute in List.nth 21 (fst c) _. *) (* Weaken 7 7 [19;58;16] *)

 Definition s22 := Eval vm_compute in (step_checker s21 (List.nth 21 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s22. *) (* s22 = {| [9],[10],[14],[10; 16],[18],[6; 11; 13; 58],[6; 11; 13; 58],[16; 19; 58],[7; 16] |} *)

(*  Eval vm_compute in List.nth 22 (fst c) _. *) (* Res 4 {|7,4|} *)

 Definition s23 := Eval vm_compute in (step_checker s22 (List.nth 22 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s23. *) (* s23 = {| [9],[10],[14],[10; 16],[16; 58],[6; 11; 13; 58],[6; 11; 13; 58],[16; 19; 58],[7; 16] |} *)

(*  Eval vm_compute in List.nth 23 (fst c) _. *) (* BuildDef 7 17  *)

 Definition s24 := Eval vm_compute in (step_checker s23 (List.nth 23 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s24. *) (* s24 = {| [9],[10],[14],[10; 16],[16; 58],[6; 11; 13; 58],[6; 11; 13; 58],[6; 11; 13; 17],[7; 16] |} *)

(*  Eval vm_compute in List.nth 24 (fst c) _. *) (* Res 4 {|7,4|} *)

 Definition s25 := Eval vm_compute in (step_checker s24 (List.nth 24 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s25. *) (* s25 = {| [9],[10],[14],[10; 16],[6; 11; 13; 58],[6; 11; 13; 58],[6; 11; 13; 58],[6; 11; 13; 17],[7; 16] |} *)

(*  Eval vm_compute in List.nth 25 (fst c) _. *) (* ImmBuildDef2 7 2  *)

 Definition s26 := Eval vm_compute in (step_checker s25 (List.nth 25 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s26. *) (* s26 = {| [9],[10],[14],[10; 16],[6; 11; 13; 58],[6; 11; 13; 58],[6; 11; 13; 58],[4; 13],[7; 16] |} *)

(*  Eval vm_compute in List.nth 26 (fst c) _. *) (* ImmBuildDef2 8 0  *)

 Definition s27 := Eval vm_compute in (step_checker s26 (List.nth 26 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s27. *) (* s27 = {| [9],[10],[14],[10; 16],[6; 11; 13; 58],[6; 11; 13; 58],[6; 11; 13; 58],[4; 13],[4; 6] |} *)

(*  Eval vm_compute in List.nth 27 (fst c) _. *) (* BuildDef 3 46  *)

 Definition s28 := Eval vm_compute in (step_checker s27 (List.nth 27 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s28. *) (* s28 = {| [9],[10],[14],[7; 11; 46],[6; 11; 13; 58],[6; 11; 13; 58],[6; 11; 13; 58],[4; 13],[4; 6] |} *)

(*  Eval vm_compute in List.nth 28 (fst c) _. *) (* BuildProj 5 48 0  *)

 Definition s29 := Eval vm_compute in (step_checker s28 (List.nth 28 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s29. *) (* s29 = {| [9],[10],[14],[7; 11; 46],[6; 11; 13; 58],[46; 48],[6; 11; 13; 58],[4; 13],[4; 6] |} *)

(*  Eval vm_compute in List.nth 29 (fst c) _. *) (* BuildDef 6 60  *)

 Definition s30 := Eval vm_compute in (step_checker s29 (List.nth 29 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s30. *) (* s30 = {| [9],[10],[14],[7; 11; 46],[6; 11; 13; 58],[46; 48],[7; 11; 12; 60],[4; 13],[4; 6] |} *)

(*  Eval vm_compute in List.nth 30 (fst c) _. *) (* BuildProj 9 47 0  *)

 Definition s31 := Eval vm_compute in (step_checker s30 (List.nth 30 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s31. *) (* s31 = {| [9],[10],[14],[7; 11; 46],[6; 11; 13; 58],[46; 48],[7; 11; 12; 60],[4; 13],[4; 6],[6; 47] |} *)

(*  Eval vm_compute in List.nth 31 (fst c) _. *) (* BuildProj 10 47 1  *)

 Definition s32 := Eval vm_compute in (step_checker s31 (List.nth 31 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s32. *) (* s32 = {| [9],[10],[14],[7; 11; 46],[6; 11; 13; 58],[46; 48],[7; 11; 12; 60],[4; 13],[4; 6],[6; 47],[10; 47] |} *)

(*  Eval vm_compute in List.nth 32 (fst c) _. *) (* Res 10 {|6,9,10|} *)

 Definition s33 := Eval vm_compute in (step_checker s32 (List.nth 32 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s33. *) (* s33 = {| [9],[10],[14],[7; 11; 46],[6; 11; 13; 58],[46; 48],[7; 11; 12; 60],[4; 13],[4; 6],[6; 47],[12; 47; 60] |} *)

(*  Eval vm_compute in List.nth 33 (fst c) _. *) (* Res 10 {|5,10|} *)

 Definition s34 := Eval vm_compute in (step_checker s33 (List.nth 33 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s34. *) (* s34 = {| [9],[10],[14],[7; 11; 46],[6; 11; 13; 58],[46; 48],[7; 11; 12; 60],[4; 13],[4; 6],[6; 47],[12; 48; 60] |} *)

(*  Eval vm_compute in List.nth 34 (fst c) _. *) (* BuildProj 5 48 1  *)

 Definition s35 := Eval vm_compute in (step_checker s34 (List.nth 34 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s35. *) (* s35 = {| [9],[10],[14],[7; 11; 46],[6; 11; 13; 58],[13; 48],[7; 11; 12; 60],[4; 13],[4; 6],[6; 47],[12; 48; 60] |} *)

(*  Eval vm_compute in List.nth 35 (fst c) _. *) (* Res 5 {|10,5|} *)

 Definition s36 := Eval vm_compute in (step_checker s35 (List.nth 35 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s36. *) (* s36 = {| [9],[10],[14],[7; 11; 46],[6; 11; 13; 58],[48; 60],[7; 11; 12; 60],[4; 13],[4; 6],[6; 47],[12; 48; 60] |} *)

(*  Eval vm_compute in List.nth 36 (fst c) _. *) (* BuildDef 10 49  *)

 Definition s37 := Eval vm_compute in (step_checker s36 (List.nth 36 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s37. *) (* s37 = {| [9],[10],[14],[7; 11; 46],[6; 11; 13; 58],[48; 60],[7; 11; 12; 60],[4; 13],[4; 6],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 37 (fst c) _. *) (* Res 5 {|10,5|} *)

 Definition s38 := Eval vm_compute in (step_checker s37 (List.nth 37 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s38. *) (* s38 = {| [9],[10],[14],[7; 11; 46],[6; 11; 13; 58],[12; 47; 60],[7; 11; 12; 60],[4; 13],[4; 6],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 38 (fst c) _. *) (* Res 5 {|3,5|} *)

 Definition s39 := Eval vm_compute in (step_checker s38 (List.nth 38 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s39. *) (* s39 = {| [9],[10],[14],[7; 11; 46],[6; 11; 13; 58],[7; 11; 12; 60],[7; 11; 12; 60],[4; 13],[4; 6],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 39 (fst c) _. *) (* ImmBuildDef 2 2  *)

 Definition s40 := Eval vm_compute in (step_checker s39 (List.nth 39 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s40. *) (* s40 = {| [9],[10],[5; 12],[7; 11; 46],[6; 11; 13; 58],[7; 11; 12; 60],[7; 11; 12; 60],[4; 13],[4; 6],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 40 (fst c) _. *) (* ImmBuildDef 0 0  *)

 Definition s41 := Eval vm_compute in (step_checker s40 (List.nth 40 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s41. *) (* s41 = {| [5; 7],[10],[5; 12],[7; 11; 46],[6; 11; 13; 58],[7; 11; 12; 60],[7; 11; 12; 60],[4; 13],[4; 6],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 41 (fst c) _. *) (* Res 0 {|5,1,2,0|} *)

 Definition s42 := Eval vm_compute in (step_checker s41 (List.nth 41 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s42. *) (* s42 = {| [5; 7; 0],[10],[5; 12],[7; 11; 46],[6; 11; 13; 58],[7; 11; 12; 60],[7; 11; 12; 60],[4; 13],[4; 6],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 42 (fst c) _. *) (* Res 8 {|8,0|} *)

 Definition s43 := Eval vm_compute in (step_checker s42 (List.nth 42 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s43. *) (* s43 = {| [5; 7; 0],[10],[5; 12],[7; 11; 46],[6; 11; 13; 58],[7; 11; 12; 60],[7; 11; 12; 60],[4; 13],[6; 7; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 43 (fst c) _. *) (* Res 8 {|7,8|} *)

 Definition s44 := Eval vm_compute in (step_checker s43 (List.nth 43 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s44. *) (* s44 = {| [5; 7; 0],[10],[5; 12],[7; 11; 46],[6; 11; 13; 58],[7; 11; 12; 60],[7; 11; 12; 60],[4; 13],[4; 6; 7; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 44 (fst c) _. *) (* Res 1 {|4,8,0,1|} *)

 Definition s45 := Eval vm_compute in (step_checker s44 (List.nth 44 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s45. *) (* s45 = {| [5; 7; 0],[6; 7; 0; 0; 0; 0],[5; 12],[7; 11; 46],[6; 11; 13; 58],[7; 11; 12; 60],[7; 11; 12; 60],[4; 13],[4; 6; 7; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 45 (fst c) _. *) (* BuildProj 0 61 1  *)

 Definition s46 := Eval vm_compute in (step_checker s45 (List.nth 45 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s46. *) (* s46 = {| [10; 61],[6; 7; 0; 0; 0; 0],[5; 12],[7; 11; 46],[6; 11; 13; 58],[7; 11; 12; 60],[7; 11; 12; 60],[4; 13],[4; 6; 7; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 46 (fst c) _. *) (* Res 0 {|1,0|} *)

 Definition s47 := Eval vm_compute in (step_checker s46 (List.nth 46 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s47. *) (* s47 = {| [6; 7; 0; 0; 0; 0; 0],[6; 7; 0; 0; 0; 0],[5; 12],[7; 11; 46],[6; 11; 13; 58],[7; 11; 12; 60],[7; 11; 12; 60],[4; 13],[4; 6; 7; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 47 (fst c) _. *) (* BuildProj 8 61 0  *)

 Definition s48 := Eval vm_compute in (step_checker s47 (List.nth 47 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s48. *) (* s48 = {| [6; 7; 0; 0; 0; 0; 0],[6; 7; 0; 0; 0; 0],[5; 12],[7; 11; 46],[6; 11; 13; 58],[7; 11; 12; 60],[7; 11; 12; 60],[4; 13],[6; 61],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 48 (fst c) _. *) (* Res 8 {|1,8|} *)

 Definition s49 := Eval vm_compute in (step_checker s48 (List.nth 48 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s49. *) (* s49 = {| [6; 7; 0; 0; 0; 0; 0],[6; 7; 0; 0; 0; 0],[5; 12],[7; 11; 46],[6; 11; 13; 58],[7; 11; 12; 60],[7; 11; 12; 60],[4; 13],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 49 (fst c) _. *) (* BuildProj 4 48 0  *)

 Definition s50 := Eval vm_compute in (step_checker s49 (List.nth 49 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s50. *) (* s50 = {| [6; 7; 0; 0; 0; 0; 0],[6; 7; 0; 0; 0; 0],[5; 12],[7; 11; 46],[46; 48],[7; 11; 12; 60],[7; 11; 12; 60],[4; 13],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 50 (fst c) _. *) (* BuildDef 7 60  *)

 Definition s51 := Eval vm_compute in (step_checker s50 (List.nth 50 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s51. *) (* s51 = {| [6; 7; 0; 0; 0; 0; 0],[6; 7; 0; 0; 0; 0],[5; 12],[7; 11; 46],[46; 48],[7; 11; 12; 60],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 51 (fst c) _. *) (* BuildProj 2 47 0  *)

 Definition s52 := Eval vm_compute in (step_checker s51 (List.nth 51 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s52. *) (* s52 = {| [6; 7; 0; 0; 0; 0; 0],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[46; 48],[7; 11; 12; 60],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 52 (fst c) _. *) (* BuildProj 5 47 1  *)

 Definition s53 := Eval vm_compute in (step_checker s52 (List.nth 52 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s53. *) (* s53 = {| [6; 7; 0; 0; 0; 0; 0],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[46; 48],[10; 47],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 53 (fst c) _. *) (* Res 5 {|7,2,5|} *)

 Definition s54 := Eval vm_compute in (step_checker s53 (List.nth 53 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s54. *) (* s54 = {| [6; 7; 0; 0; 0; 0; 0],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[46; 48],[12; 47; 60],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 54 (fst c) _. *) (* Res 5 {|4,5|} *)

 Definition s55 := Eval vm_compute in (step_checker s54 (List.nth 54 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s55. *) (* s55 = {| [6; 7; 0; 0; 0; 0; 0],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[46; 48],[12; 48; 60],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 55 (fst c) _. *) (* BuildProj 4 48 1  *)

 Definition s56 := Eval vm_compute in (step_checker s55 (List.nth 55 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s56. *) (* s56 = {| [6; 7; 0; 0; 0; 0; 0],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[13; 48],[12; 48; 60],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 56 (fst c) _. *) (* Res 4 {|5,4|} *)

 Definition s57 := Eval vm_compute in (step_checker s56 (List.nth 56 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s57. *) (* s57 = {| [6; 7; 0; 0; 0; 0; 0],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[48; 60],[12; 48; 60],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 57 (fst c) _. *) (* BuildDef 5 49  *)

 Definition s58 := Eval vm_compute in (step_checker s57 (List.nth 57 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s58. *) (* s58 = {| [6; 7; 0; 0; 0; 0; 0],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[48; 60],[12; 47; 49],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 58 (fst c) _. *) (* Res 4 {|5,4|} *)

 Definition s59 := Eval vm_compute in (step_checker s58 (List.nth 58 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s59. *) (* s59 = {| [6; 7; 0; 0; 0; 0; 0],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[12; 47; 60],[12; 47; 49],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 59 (fst c) _. *) (* BuildDef 5 46  *)

 Definition s60 := Eval vm_compute in (step_checker s59 (List.nth 59 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s60. *) (* s60 = {| [6; 7; 0; 0; 0; 0; 0],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[12; 47; 60],[7; 11; 46],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 60 (fst c) _. *) (* Res 0 {|5,8,0|} *)

 Definition s61 := Eval vm_compute in (step_checker s60 (List.nth 60 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s61. *) (* s61 = {| [0; 0; 0; 0; 0; 7; 0; 0; 0; 0; 0; 11; 46],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[12; 47; 60],[7; 11; 46],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 61 (fst c) _. *) (* Res 0 {|4,0|} *)

 Definition s62 := Eval vm_compute in (step_checker s61 (List.nth 61 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s62. *) (* s62 = {| [0; 0; 0; 0; 0; 7; 0; 0; 0; 0; 0; 11; 
                                               12; 60],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[12; 47; 60],[7; 11; 46],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 62 (fst c) _. *) (* BuildProj 4 61 2  *)

 Definition s63 := Eval vm_compute in (step_checker s62 (List.nth 62 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s63. *) (* s63 = {| [0; 0; 0; 0; 0; 7; 0; 0; 0; 0; 0; 11; 
                                               12; 60],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[13; 61],[7; 11; 46],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 63 (fst c) _. *) (* Res 4 {|1,4|} *)

 Definition s64 := Eval vm_compute in (step_checker s63 (List.nth 63 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s64. *) (* s64 = {| [0; 0; 0; 0; 0; 7; 0; 0; 0; 0; 0; 11; 
                                               12; 60],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[6; 7; 0; 0; 0; 0; 0],[7; 11; 46],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 64 (fst c) _. *) (* Res 4 {|0,4|} *)

 Definition s65 := Eval vm_compute in (step_checker s64 (List.nth 64 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s65. *) (* s65 = {| [0; 0; 0; 0; 0; 7; 0; 0; 0; 0; 0; 11; 
                                               12; 60],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[7; 11; 46],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 65 (fst c) _. *) (* BuildProj 0 59 1  *)

 Definition s66 := Eval vm_compute in (step_checker s65 (List.nth 65 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s66. *) (* s66 = {| [7; 59],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[7; 11; 46],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 66 (fst c) _. *) (* Res 0 {|4,0|} *)

 Definition s67 := Eval vm_compute in (step_checker s66 (List.nth 66 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s67. *) (* s67 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[6; 7; 0; 0; 0; 0],[6; 47],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[7; 11; 46],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 67 (fst c) _. *) (* BuildProj 1 59 0  *)

 Definition s68 := Eval vm_compute in (step_checker s67 (List.nth 67 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s68. *) (* s68 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[10; 59],[6; 47],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[7; 11; 46],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 68 (fst c) _. *) (* Res 1 {|4,1|} *)

 Definition s69 := Eval vm_compute in (step_checker s68 (List.nth 68 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s69. *) (* s69 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               12; 
                                               59; 60],[6; 47],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[7; 11; 46],[7; 11; 12; 60],[7; 11; 12; 60],[6; 7; 0; 0; 0; 0; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 69 (fst c) _. *) (* BuildProj 8 32 0  *)

 Definition s70 := Eval vm_compute in (step_checker s69 (List.nth 69 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s70. *) (* s70 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               12; 
                                               59; 60],[6; 47],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[7; 11; 46],[7; 11; 12; 60],[7; 11; 12; 60],[30; 32],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 70 (fst c) _. *) (* BuildDef 5 62  *)

 Definition s71 := Eval vm_compute in (step_checker s70 (List.nth 70 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s71. *) (* s71 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               12; 
                                               59; 60],[6; 47],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[6; 11; 13; 62],[7; 11; 12; 60],[7; 11; 12; 60],[30; 32],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 71 (fst c) _. *) (* BuildProj 2 31 0  *)

 Definition s72 := Eval vm_compute in (step_checker s71 (List.nth 71 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s72. *) (* s72 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               12; 
                                               59; 60],[7; 31],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[6; 11; 13; 62],[7; 11; 12; 60],[7; 11; 12; 60],[30; 32],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 72 (fst c) _. *) (* BuildProj 7 31 1  *)

 Definition s73 := Eval vm_compute in (step_checker s72 (List.nth 72 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s73. *) (* s73 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               12; 
                                               59; 60],[7; 31],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[6; 11; 13; 62],[7; 11; 12; 60],[10; 31],[30; 32],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 73 (fst c) _. *) (* Res 7 {|5,2,7|} *)

 Definition s74 := Eval vm_compute in (step_checker s73 (List.nth 73 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s74. *) (* s74 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               12; 
                                               59; 60],[7; 31],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[6; 11; 13; 62],[7; 11; 12; 60],[13; 31; 62],[30; 32],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 74 (fst c) _. *) (* Res 7 {|8,7|} *)

 Definition s75 := Eval vm_compute in (step_checker s74 (List.nth 74 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s75. *) (* s75 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               12; 
                                               59; 60],[7; 31],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[6; 11; 13; 62],[7; 11; 12; 60],[13; 32; 62],[30; 32],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 75 (fst c) _. *) (* BuildProj 8 32 1  *)

 Definition s76 := Eval vm_compute in (step_checker s75 (List.nth 75 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s76. *) (* s76 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               12; 
                                               59; 60],[7; 31],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[6; 11; 13; 62],[7; 11; 12; 60],[13; 32; 62],[12; 32],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 76 (fst c) _. *) (* Res 8 {|7,8|} *)

 Definition s77 := Eval vm_compute in (step_checker s76 (List.nth 76 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s77. *) (* s77 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               12; 
                                               59; 60],[7; 31],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[6; 11; 13; 62],[7; 11; 12; 60],[13; 32; 62],[32; 62],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 77 (fst c) _. *) (* BuildDef 7 33  *)

 Definition s78 := Eval vm_compute in (step_checker s77 (List.nth 77 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s78. *) (* s78 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               12; 
                                               59; 60],[7; 31],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[6; 11; 13; 62],[7; 11; 12; 60],[13; 31; 33],[32; 62],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 78 (fst c) _. *) (* Res 8 {|7,8|} *)

 Definition s79 := Eval vm_compute in (step_checker s78 (List.nth 78 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s79. *) (* s79 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               12; 
                                               59; 60],[7; 31],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[6; 11; 13; 62],[7; 11; 12; 60],[13; 31; 33],[13; 31; 62],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 79 (fst c) _. *) (* BuildDef 7 30  *)

 Definition s80 := Eval vm_compute in (step_checker s79 (List.nth 79 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s80. *) (* s80 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               12; 
                                               59; 60],[7; 31],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[6; 11; 13; 62],[7; 11; 12; 60],[6; 11; 30],[13; 31; 62],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 80 (fst c) _. *) (* Res 1 {|7,0,1|} *)

 Definition s81 := Eval vm_compute in (step_checker s80 (List.nth 80 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s81. *) (* s81 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 
                                               0; 
                                               7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               30; 
                                               59; 
                                               0; 0],[7; 31],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[6; 11; 13; 62],[7; 11; 12; 60],[6; 11; 30],[13; 31; 62],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 81 (fst c) _. *) (* Res 1 {|8,1|} *)

 Definition s82 := Eval vm_compute in (step_checker s81 (List.nth 81 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s82. *) (* s82 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 
                                               0; 
                                               7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               30; 
                                               31; 
                                               59; 
                                               0; 
                                               0; 62],[7; 31],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[6; 11; 13; 62],[7; 11; 12; 60],[6; 11; 30],[13; 31; 62],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 82 (fst c) _. *) (* BuildProj 8 59 2  *)

 Definition s83 := Eval vm_compute in (step_checker s82 (List.nth 82 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s83. *) (* s83 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 
                                               0; 
                                               7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               30; 
                                               31; 
                                               59; 
                                               0; 
                                               0; 62],[7; 31],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[6; 11; 13; 62],[7; 11; 12; 60],[6; 11; 30],[12; 59],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 83 (fst c) _. *) (* Res 8 {|4,8|} *)

 Definition s84 := Eval vm_compute in (step_checker s83 (List.nth 83 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s84. *) (* s84 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 
                                               0; 
                                               7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               30; 
                                               31; 
                                               59; 
                                               0; 
                                               0; 62],[7; 31],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[6; 11; 13; 62],[7; 11; 12; 60],[6; 11; 30],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[6; 47],[12; 47; 49] |} *)

(*  Eval vm_compute in List.nth 84 (fst c) _. *) (* Res 8 {|1,8|} *)

 Definition s85 := Eval vm_compute in (step_checker s84 (List.nth 84 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s85. *) (* s85 = {| [0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               59; 0],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 
                                               0; 
                                               7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               30; 
                                               31; 
                                               59; 
                                               0; 
                                               0; 62],[7; 31],[7; 11; 46],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 60],[6; 11; 13; 62],[7; 11; 12; 60],[6; 11; 30],[0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 
                                               0; 
                                               0; 
                                               0; 
                                               7; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               0; 
                                               11; 
                                               12; 
                                               30; 
                                               31; 
                                               59; 
                                               0; 0],[6; 47],[12; 47; 49] |} *)
End thesistest4smt2debug.