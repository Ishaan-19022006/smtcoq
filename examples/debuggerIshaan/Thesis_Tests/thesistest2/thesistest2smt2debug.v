Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool. 
Require Import Int31. 
Local Open Scope int31_scope.

Section thesistest2smt2debug.

 Parse_certif_verit t_i t_func t_atom t_form root used_roots trace 
 "Thesis_Tests/thesistest2/thesistest2.smt2" 
 "Thesis_Tests/thesistest2/thesistest2.pf". 

 Definition nclauses := Eval vm_compute in (match trace with Certif a _ _ => a end). (* Size of the state *)
(*  Print nclauses. *) (* 9 *)

  Definition c := Eval vm_compute in (match trace with Certif _ a _ => a end). (* Certificate *)
 Definition conf := Eval vm_compute in (match trace with Certif _ _ a => a end). (* Look here in the state for the empty clause*)
(*  Print conf. *) (* 7 *)

(*  Eval vm_compute in List.length (fst c). (* No. of steps in certificate *) *) (* 74 *)

(*  Eval vm_compute in (Form.check_form t_form && Atom.check_atom t_atom && Atom.wt t_i t_func t_atom). *) (* true *)

 (* States from c *) 

(* Start state *) 

 Definition s0 := Eval vm_compute in (add_roots (S.make nclauses) root used_roots). 
(*   Print s0. *) (* s0 = {| [5],[6],[8] |} *)

(*  Eval vm_compute in List.nth 0 (fst c) _. *) (* BuildDef2 3 12  *)

 Definition s1 := Eval vm_compute in (step_checker s0 (List.nth 0 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s1. *) (* s1 = {| [5],[6],[8],[10; 12] |} *)

(*  Eval vm_compute in List.nth 1 (fst c) _. *) (* Weaken 3 3 [12;10] *)

 Definition s2 := Eval vm_compute in (step_checker s1 (List.nth 1 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s2. *) (* s2 = {| [5],[6],[8],[10; 12] |} *)

(*  Eval vm_compute in List.nth 2 (fst c) _. *) (* BuildDef 4 12  *)

 Definition s3 := Eval vm_compute in (step_checker s2 (List.nth 2 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s3. *) (* s3 = {| [5],[6],[8],[10; 12],[11; 12] |} *)

(*  Eval vm_compute in List.nth 3 (fst c) _. *) (* Weaken 4 4 [12;11] *)

 Definition s4 := Eval vm_compute in (step_checker s3 (List.nth 3 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s4. *) (* s4 = {| [5],[6],[8],[10; 12],[11; 12] |} *)

(*  Eval vm_compute in List.nth 4 (fst c) _. *) (* Res 4 {|3,4|} *)

 Definition s5 := Eval vm_compute in (step_checker s4 (List.nth 4 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s5. *) (* s5 = {| [5],[6],[8],[10; 12],[12] |} *)

(*  Eval vm_compute in List.nth 5 (fst c) _. *) (* BuildDef 3 20  *)

 Definition s6 := Eval vm_compute in (step_checker s5 (List.nth 5 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s6. *) (* s6 = {| [5],[6],[8],[4; 7; 20],[12] |} *)

(*  Eval vm_compute in List.nth 6 (fst c) _. *) (* BuildProj 5 22 0  *)

 Definition s7 := Eval vm_compute in (step_checker s6 (List.nth 6 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s7. *) (* s7 = {| [5],[6],[8],[4; 7; 20],[12],[20; 22] |} *)

(*  Eval vm_compute in List.nth 7 (fst c) _. *) (* BuildDef 6 36  *)

 Definition s8 := Eval vm_compute in (step_checker s7 (List.nth 7 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s8. *) (* s8 = {| [5],[6],[8],[4; 7; 20],[12],[20; 22],[4; 7; 9; 36] |} *)

(*  Eval vm_compute in List.nth 8 (fst c) _. *) (* BuildProj 7 21 0  *)

 Definition s9 := Eval vm_compute in (step_checker s8 (List.nth 8 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s9. *) (* s9 = {| [5],[6],[8],[4; 7; 20],[12],[20; 22],[4; 7; 9; 36],[5; 21] |} *)

(*  Eval vm_compute in List.nth 9 (fst c) _. *) (* BuildProj 8 21 1  *)

 Definition s10 := Eval vm_compute in (step_checker s9 (List.nth 9 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s10. *) (* s10 = {| [5],[6],[8],[4; 7; 20],[12],[20; 22],[4; 7; 9; 36],[5; 21],[6; 21] |} *)

(*  Eval vm_compute in List.nth 10 (fst c) _. *) (* Res 8 {|6,7,8|} *)

 Definition s11 := Eval vm_compute in (step_checker s10 (List.nth 10 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s11. *) (* s11 = {| [5],[6],[8],[4; 7; 20],[12],[20; 22],[4; 7; 9; 36],[5; 21],[9; 21; 36] |} *)

(*  Eval vm_compute in List.nth 11 (fst c) _. *) (* Res 8 {|5,8|} *)

 Definition s12 := Eval vm_compute in (step_checker s11 (List.nth 11 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s12. *) (* s12 = {| [5],[6],[8],[4; 7; 20],[12],[20; 22],[4; 7; 9; 36],[5; 21],[9; 22; 36] |} *)

(*  Eval vm_compute in List.nth 12 (fst c) _. *) (* BuildProj 5 22 1  *)

 Definition s13 := Eval vm_compute in (step_checker s12 (List.nth 12 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s13. *) (* s13 = {| [5],[6],[8],[4; 7; 20],[12],[8; 22],[4; 7; 9; 36],[5; 21],[9; 22; 36] |} *)

(*  Eval vm_compute in List.nth 13 (fst c) _. *) (* Res 5 {|8,5|} *)

 Definition s14 := Eval vm_compute in (step_checker s13 (List.nth 13 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s14. *) (* s14 = {| [5],[6],[8],[4; 7; 20],[12],[22; 36],[4; 7; 9; 36],[5; 21],[9; 22; 36] |} *)

(*  Eval vm_compute in List.nth 14 (fst c) _. *) (* BuildDef 8 23  *)

 Definition s15 := Eval vm_compute in (step_checker s14 (List.nth 14 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s15. *) (* s15 = {| [5],[6],[8],[4; 7; 20],[12],[22; 36],[4; 7; 9; 36],[5; 21],[9; 21; 23] |} *)

(*  Eval vm_compute in List.nth 15 (fst c) _. *) (* Res 5 {|8,5|} *)

 Definition s16 := Eval vm_compute in (step_checker s15 (List.nth 15 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s16. *) (* s16 = {| [5],[6],[8],[4; 7; 20],[12],[9; 21; 36],[4; 7; 9; 36],[5; 21],[9; 21; 23] |} *)

(*  Eval vm_compute in List.nth 16 (fst c) _. *) (* Res 5 {|3,5|} *)

 Definition s17 := Eval vm_compute in (step_checker s16 (List.nth 16 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s17. *) (* s17 = {| [5],[6],[8],[4; 7; 20],[12],[4; 7; 9; 36],[4; 7; 9; 36],[5; 21],[9; 21; 23] |} *)

(*  Eval vm_compute in List.nth 17 (fst c) _. *) (* BuildProj 3 10 0  *)

 Definition s18 := Eval vm_compute in (step_checker s17 (List.nth 17 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s18. *) (* s18 = {| [5],[6],[8],[5; 10],[12],[4; 7; 9; 36],[4; 7; 9; 36],[5; 21],[9; 21; 23] |} *)

(*  Eval vm_compute in List.nth 18 (fst c) _. *) (* BuildProj 8 10 1  *)

 Definition s19 := Eval vm_compute in (step_checker s18 (List.nth 18 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s19. *) (* s19 = {| [5],[6],[8],[5; 10],[12],[4; 7; 9; 36],[4; 7; 9; 36],[5; 21],[6; 10] |} *)

(*  Eval vm_compute in List.nth 19 (fst c) _. *) (* BuildProj 7 10 2  *)

 Definition s20 := Eval vm_compute in (step_checker s19 (List.nth 19 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s20. *) (* s20 = {| [5],[6],[8],[5; 10],[12],[4; 7; 9; 36],[4; 7; 9; 36],[8; 10],[6; 10] |} *)

(*  Eval vm_compute in List.nth 20 (fst c) _. *) (* Res 7 {|5,3,8,7|} *)

 Definition s21 := Eval vm_compute in (step_checker s20 (List.nth 20 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s21. *) (* s21 = {| [5],[6],[8],[5; 10],[12],[4; 7; 9; 36],[4; 7; 9; 36],[10; 36],[6; 10] |} *)

(*  Eval vm_compute in List.nth 21 (fst c) _. *) (* Weaken 7 7 [13;36;10] *)

 Definition s22 := Eval vm_compute in (step_checker s21 (List.nth 21 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s22. *) (* s22 = {| [5],[6],[8],[5; 10],[12],[4; 7; 9; 36],[4; 7; 9; 36],[10; 13; 36],[6; 10] |} *)

(*  Eval vm_compute in List.nth 22 (fst c) _. *) (* Res 4 {|7,4|} *)

 Definition s23 := Eval vm_compute in (step_checker s22 (List.nth 22 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s23. *) (* s23 = {| [5],[6],[8],[5; 10],[10; 36],[4; 7; 9; 36],[4; 7; 9; 36],[10; 13; 36],[6; 10] |} *)

(*  Eval vm_compute in List.nth 23 (fst c) _. *) (* BuildDef 7 11  *)

 Definition s24 := Eval vm_compute in (step_checker s23 (List.nth 23 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s24. *) (* s24 = {| [5],[6],[8],[5; 10],[10; 36],[4; 7; 9; 36],[4; 7; 9; 36],[4; 7; 9; 11],[6; 10] |} *)

(*  Eval vm_compute in List.nth 24 (fst c) _. *) (* Res 4 {|7,4|} *)

 Definition s25 := Eval vm_compute in (step_checker s24 (List.nth 24 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s25. *) (* s25 = {| [5],[6],[8],[5; 10],[4; 7; 9; 36],[4; 7; 9; 36],[4; 7; 9; 36],[4; 7; 9; 11],[6; 10] |} *)

(*  Eval vm_compute in List.nth 25 (fst c) _. *) (* Res 0 {|4,2,1,0|} *)

 Definition s26 := Eval vm_compute in (step_checker s25 (List.nth 25 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s26. *) (* s26 = {| [36],[6],[8],[5; 10],[4; 7; 9; 36],[4; 7; 9; 36],[4; 7; 9; 36],[4; 7; 9; 11],[6; 10] |} *)

(*  Eval vm_compute in List.nth 26 (fst c) _. *) (* BuildProj 2 37 0  *)

 Definition s27 := Eval vm_compute in (step_checker s26 (List.nth 26 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s27. *) (* s27 = {| [36],[6],[5; 37],[5; 10],[4; 7; 9; 36],[4; 7; 9; 36],[4; 7; 9; 36],[4; 7; 9; 11],[6; 10] |} *)

(*  Eval vm_compute in List.nth 27 (fst c) _. *) (* Res 2 {|0,2|} *)

 Definition s28 := Eval vm_compute in (step_checker s27 (List.nth 27 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s28. *) (* s28 = {| [36],[6],[5],[5; 10],[4; 7; 9; 36],[4; 7; 9; 36],[4; 7; 9; 36],[4; 7; 9; 11],[6; 10] |} *)

(*  Eval vm_compute in List.nth 28 (fst c) _. *) (* BuildDef 4 26  *)

 Definition s29 := Eval vm_compute in (step_checker s28 (List.nth 28 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s29. *) (* s29 = {| [36],[6],[5],[5; 10],[8; 25; 26],[4; 7; 9; 36],[4; 7; 9; 36],[4; 7; 9; 11],[6; 10] |} *)

(*  Eval vm_compute in List.nth 29 (fst c) _. *) (* BuildDef 7 38  *)

 Definition s30 := Eval vm_compute in (step_checker s29 (List.nth 29 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s30. *) (* s30 = {| [36],[6],[5],[5; 10],[8; 25; 26],[4; 7; 9; 36],[4; 7; 9; 36],[9; 25; 38],[6; 10] |} *)

(*  Eval vm_compute in List.nth 30 (fst c) _. *) (* Res 4 {|7,4|} *)

 Definition s31 := Eval vm_compute in (step_checker s30 (List.nth 30 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s31. *) (* s31 = {| [36],[6],[5],[5; 10],[25; 26; 38],[4; 7; 9; 36],[4; 7; 9; 36],[9; 25; 38],[6; 10] |} *)

(*  Eval vm_compute in List.nth 31 (fst c) _. *) (* BuildDef2 7 26  *)

 Definition s32 := Eval vm_compute in (step_checker s31 (List.nth 31 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s32. *) (* s32 = {| [36],[6],[5],[5; 10],[25; 26; 38],[4; 7; 9; 36],[4; 7; 9; 36],[9; 24; 26],[6; 10] |} *)

(*  Eval vm_compute in List.nth 32 (fst c) _. *) (* BuildDef 8 40  *)

 Definition s33 := Eval vm_compute in (step_checker s32 (List.nth 32 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s33. *) (* s33 = {| [36],[6],[5],[5; 10],[25; 26; 38],[4; 7; 9; 36],[4; 7; 9; 36],[9; 24; 26],[8; 24; 40] |} *)

(*  Eval vm_compute in List.nth 33 (fst c) _. *) (* Res 7 {|8,7|} *)

 Definition s34 := Eval vm_compute in (step_checker s33 (List.nth 33 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s34. *) (* s34 = {| [36],[6],[5],[5; 10],[25; 26; 38],[4; 7; 9; 36],[4; 7; 9; 36],[24; 26; 40],[8; 24; 40] |} *)

(*  Eval vm_compute in List.nth 34 (fst c) _. *) (* Res 7 {|4,7|} *)

 Definition s35 := Eval vm_compute in (step_checker s34 (List.nth 34 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s35. *) (* s35 = {| [36],[6],[5],[5; 10],[25; 26; 38],[4; 7; 9; 36],[4; 7; 9; 36],[26; 38; 40],[8; 24; 40] |} *)

(*  Eval vm_compute in List.nth 35 (fst c) _. *) (* BuildDef2 4 27  *)

 Definition s36 := Eval vm_compute in (step_checker s35 (List.nth 35 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s36. *) (* s36 = {| [36],[6],[5],[5; 10],[9; 25; 27],[4; 7; 9; 36],[4; 7; 9; 36],[26; 38; 40],[8; 24; 40] |} *)

(*  Eval vm_compute in List.nth 36 (fst c) _. *) (* Res 7 {|4,7|} *)

 Definition s37 := Eval vm_compute in (step_checker s36 (List.nth 36 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s37. *) (* s37 = {| [36],[6],[5],[5; 10],[9; 25; 27],[4; 7; 9; 36],[4; 7; 9; 36],[9; 25; 38; 40],[8; 24; 40] |} *)

(*  Eval vm_compute in List.nth 37 (fst c) _. *) (* EqTr 4 28 [] *)

 Definition s38 := Eval vm_compute in (step_checker s37 (List.nth 37 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s38. *) (* s38 = {| [36],[6],[5],[5; 10],[28],[4; 7; 9; 36],[4; 7; 9; 36],[9; 25; 38; 40],[8; 24; 40] |} *)

(*  Eval vm_compute in List.nth 38 (fst c) _. *) (* EqTr 8 4 [7;9;29] *)

 Definition s39 := Eval vm_compute in (step_checker s38 (List.nth 38 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s39. *) (* s39 = {| [36],[6],[5],[5; 10],[28],[4; 7; 9; 36],[4; 7; 9; 36],[9; 25; 38; 40],[4; 7; 9; 29] |} *)

(*  Eval vm_compute in List.nth 39 (fst c) _. *) (* BuildDef2 3 30  *)

 Definition s40 := Eval vm_compute in (step_checker s39 (List.nth 39 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s40. *) (* s40 = {| [36],[6],[5],[4; 8; 30],[28],[4; 7; 9; 36],[4; 7; 9; 36],[9; 25; 38; 40],[4; 7; 9; 29] |} *)

(*  Eval vm_compute in List.nth 40 (fst c) _. *) (* Res 3 {|8,3|} *)

 Definition s41 := Eval vm_compute in (step_checker s40 (List.nth 40 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s41. *) (* s41 = {| [36],[6],[5],[4; 7; 29; 30],[28],[4; 7; 9; 36],[4; 7; 9; 36],[9; 25; 38; 40],[4; 7; 9; 29] |} *)

(*  Eval vm_compute in List.nth 41 (fst c) _. *) (* EqTr 8 8 [7;5;29] *)

 Definition s42 := Eval vm_compute in (step_checker s41 (List.nth 41 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s42. *) (* s42 = {| [36],[6],[5],[4; 7; 29; 30],[28],[4; 7; 9; 36],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 42 (fst c) _. *) (* BuildDef 5 30  *)

 Definition s43 := Eval vm_compute in (step_checker s42 (List.nth 42 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s43. *) (* s43 = {| [36],[6],[5],[4; 7; 29; 30],[28],[5; 9; 30],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 43 (fst c) _. *) (* Res 5 {|8,5|} *)

 Definition s44 := Eval vm_compute in (step_checker s43 (List.nth 43 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s44. *) (* s44 = {| [36],[6],[5],[4; 7; 29; 30],[28],[5; 7; 29; 30],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 44 (fst c) _. *) (* Res 1 {|3,5,4,1|} *)

 Definition s45 := Eval vm_compute in (step_checker s44 (List.nth 44 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s45. *) (* s45 = {| [36],[30],[5],[4; 7; 29; 30],[28],[5; 7; 29; 30],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 45 (fst c) _. *) (* BuildDef 4 34  *)

 Definition s46 := Eval vm_compute in (step_checker s45 (List.nth 45 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s46. *) (* s46 = {| [36],[30],[5],[4; 7; 29; 30],[4; 33; 34],[5; 7; 29; 30],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 46 (fst c) _. *) (* BuildDef 5 42  *)

 Definition s47 := Eval vm_compute in (step_checker s46 (List.nth 46 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s47. *) (* s47 = {| [36],[30],[5],[4; 7; 29; 30],[4; 33; 34],[5; 33; 42],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 47 (fst c) _. *) (* Res 4 {|5,4|} *)

 Definition s48 := Eval vm_compute in (step_checker s47 (List.nth 47 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s48. *) (* s48 = {| [36],[30],[5],[4; 7; 29; 30],[33; 34; 42],[5; 33; 42],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 48 (fst c) _. *) (* BuildDef2 5 34  *)

 Definition s49 := Eval vm_compute in (step_checker s48 (List.nth 48 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s49. *) (* s49 = {| [36],[30],[5],[4; 7; 29; 30],[33; 34; 42],[5; 32; 34],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 49 (fst c) _. *) (* BuildDef 3 44  *)

 Definition s50 := Eval vm_compute in (step_checker s49 (List.nth 49 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s50. *) (* s50 = {| [36],[30],[5],[4; 32; 44],[33; 34; 42],[5; 32; 34],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 50 (fst c) _. *) (* Res 5 {|3,5|} *)

 Definition s51 := Eval vm_compute in (step_checker s50 (List.nth 50 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s51. *) (* s51 = {| [36],[30],[5],[4; 32; 44],[33; 34; 42],[32; 34; 44],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 51 (fst c) _. *) (* Res 5 {|4,5|} *)

 Definition s52 := Eval vm_compute in (step_checker s51 (List.nth 51 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s52. *) (* s52 = {| [36],[30],[5],[4; 32; 44],[33; 34; 42],[34; 42; 44],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 52 (fst c) _. *) (* BuildDef 4 35  *)

 Definition s53 := Eval vm_compute in (step_checker s52 (List.nth 52 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s53. *) (* s53 = {| [36],[30],[5],[4; 32; 44],[4; 32; 35],[34; 42; 44],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 53 (fst c) _. *) (* Res 5 {|4,5|} *)

 Definition s54 := Eval vm_compute in (step_checker s53 (List.nth 53 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s54. *) (* s54 = {| [36],[30],[5],[4; 32; 44],[4; 32; 35],[4; 32; 42; 44],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 54 (fst c) _. *) (* Res 2 {|5,2|} *)

 Definition s55 := Eval vm_compute in (step_checker s54 (List.nth 54 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s55. *) (* s55 = {| [36],[30],[32; 42; 44],[4; 32; 44],[4; 32; 35],[4; 32; 42; 44],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 55 (fst c) _. *) (* BuildDef 5 31  *)

 Definition s56 := Eval vm_compute in (step_checker s55 (List.nth 55 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s56. *) (* s56 = {| [36],[30],[32; 42; 44],[4; 32; 44],[4; 32; 35],[5; 8; 31],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 56 (fst c) _. *) (* Res 5 {|5,1|} *)

 Definition s57 := Eval vm_compute in (step_checker s56 (List.nth 56 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s57. *) (* s57 = {| [36],[30],[32; 42; 44],[4; 32; 44],[4; 32; 35],[5; 8],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 57 (fst c) _. *) (* BuildDef 4 33  *)

 Definition s58 := Eval vm_compute in (step_checker s57 (List.nth 57 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s58. *) (* s58 = {| [36],[30],[32; 42; 44],[4; 32; 44],[3; 4; 33],[5; 8],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 58 (fst c) _. *) (* Res 4 {|4,2|} *)

 Definition s59 := Eval vm_compute in (step_checker s58 (List.nth 58 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s59. *) (* s59 = {| [36],[30],[32; 42; 44],[4; 32; 44],[3; 4; 42; 44],[5; 8],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 59 (fst c) _. *) (* Res 4 {|5,4|} *)

 Definition s60 := Eval vm_compute in (step_checker s59 (List.nth 59 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s60. *) (* s60 = {| [36],[30],[32; 42; 44],[4; 32; 44],[3; 8; 42; 44],[5; 8],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 60 (fst c) _. *) (* BuildDef2 5 24  *)

 Definition s61 := Eval vm_compute in (step_checker s60 (List.nth 60 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s61. *) (* s61 = {| [36],[30],[32; 42; 44],[4; 32; 44],[3; 8; 42; 44],[2; 8; 24],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 61 (fst c) _. *) (* Res 5 {|4,5|} *)

 Definition s62 := Eval vm_compute in (step_checker s61 (List.nth 61 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s62. *) (* s62 = {| [36],[30],[32; 42; 44],[4; 32; 44],[3; 8; 42; 44],[8; 24; 42; 44],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 62 (fst c) _. *) (* BuildDef2 4 31  *)

 Definition s63 := Eval vm_compute in (step_checker s62 (List.nth 62 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s63. *) (* s63 = {| [36],[30],[32; 42; 44],[4; 32; 44],[4; 9; 31],[8; 24; 42; 44],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 63 (fst c) _. *) (* Res 1 {|4,1|} *)

 Definition s64 := Eval vm_compute in (step_checker s63 (List.nth 63 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s64. *) (* s64 = {| [36],[4; 9],[32; 42; 44],[4; 32; 44],[4; 9; 31],[8; 24; 42; 44],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 64 (fst c) _. *) (* BuildDef2 4 33  *)

 Definition s65 := Eval vm_compute in (step_checker s64 (List.nth 64 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s65. *) (* s65 = {| [36],[4; 9],[32; 42; 44],[4; 32; 44],[2; 5; 33],[8; 24; 42; 44],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 65 (fst c) _. *) (* Res 2 {|4,2|} *)

 Definition s66 := Eval vm_compute in (step_checker s65 (List.nth 65 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s66. *) (* s66 = {| [36],[4; 9],[2; 5; 42; 44],[4; 32; 44],[2; 5; 33],[8; 24; 42; 44],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 66 (fst c) _. *) (* Res 2 {|1,2|} *)

 Definition s67 := Eval vm_compute in (step_checker s66 (List.nth 66 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s67. *) (* s67 = {| [36],[4; 9],[2; 9; 42; 44],[4; 32; 44],[2; 5; 33],[8; 24; 42; 44],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 67 (fst c) _. *) (* BuildDef 1 24  *)

 Definition s68 := Eval vm_compute in (step_checker s67 (List.nth 67 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s68. *) (* s68 = {| [36],[3; 9; 24],[2; 9; 42; 44],[4; 32; 44],[2; 5; 33],[8; 24; 42; 44],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 68 (fst c) _. *) (* Res 1 {|2,1|} *)

 Definition s69 := Eval vm_compute in (step_checker s68 (List.nth 68 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s69. *) (* s69 = {| [36],[9; 24; 42; 44],[2; 9; 42; 44],[4; 32; 44],[2; 5; 33],[8; 24; 42; 44],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 69 (fst c) _. *) (* Res 1 {|5,1|} *)

 Definition s70 := Eval vm_compute in (step_checker s69 (List.nth 69 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s70. *) (* s70 = {| [36],[24; 42; 44],[2; 9; 42; 44],[4; 32; 44],[2; 5; 33],[8; 24; 42; 44],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 70 (fst c) _. *) (* Res 1 {|7,1|} *)

 Definition s71 := Eval vm_compute in (step_checker s70 (List.nth 70 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s71. *) (* s71 = {| [36],[9; 38; 40; 42; 44],[2; 9; 42; 44],[4; 32; 44],[2; 5; 33],[8; 24; 42; 44],[4; 7; 9; 36],[9; 25; 38; 40],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 71 (fst c) _. *) (* BuildProj 7 37 2  *)

 Definition s72 := Eval vm_compute in (step_checker s71 (List.nth 71 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s72. *) (* s72 = {| [36],[9; 38; 40; 42; 44],[2; 9; 42; 44],[4; 32; 44],[2; 5; 33],[8; 24; 42; 44],[4; 7; 9; 36],[8; 37],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 72 (fst c) _. *) (* Res 7 {|0,7|} *)

 Definition s73 := Eval vm_compute in (step_checker s72 (List.nth 72 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s73. *) (* s73 = {| [36],[9; 38; 40; 42; 44],[2; 9; 42; 44],[4; 32; 44],[2; 5; 33],[8; 24; 42; 44],[4; 7; 9; 36],[8],[5; 7; 8; 29] |} *)

(*  Eval vm_compute in List.nth 73 (fst c) _. *) (* Res 7 {|1,7|} *)

 Definition s74 := Eval vm_compute in (step_checker s73 (List.nth 73 (fst c) (CTrue t_func t_atom t_form 0))). 
(*  Print s74. *) (* s74 = {| [36],[9; 38; 40; 42; 44],[2; 9; 42; 44],[4; 32; 44],[2; 5; 33],[8; 24; 42; 44],[4; 7; 9; 36],[38; 40; 42; 44],[5; 7; 8; 29] |} *)
End thesistest2smt2debug.