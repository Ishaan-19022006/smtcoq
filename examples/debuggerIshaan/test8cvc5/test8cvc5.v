(**************************************************************************)
(*                                                                        *)
(*     SMTCoq                                                             *)
(*     Copyright (C) 2011 - 2021                                          *)
(*                                                                        *)
(*     See file "AUTHORS" for the list of authors                         *)
(*                                                                        *)
(*   This file is distributed under the terms of the CeCILL-C licence     *)
(*                                                                        *)
(**************************************************************************)

Add Rec LoadPath "../../../src" as SMTCoq.

Require Import SMTCoq.SMTCoq.
Require Import Bool.

Require Import ZArith.
Require Import Int31.

Local Open Scope int31_scope.

Section Test6.
     Verit_Checker "test8cvc5.smt2" "test8cvc5.pf".
End Test6.
(*
Goal forall
    (x y: Z)
    (f: Z -> Z),
    x = y + 1 -> f y = f (x - 1).
Proof.
  verit.
Qed.
*)