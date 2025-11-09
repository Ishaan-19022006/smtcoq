Add Rec LoadPath "../../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
  Verit_Checker "thesistest4.smt2" "thesistest4.pf".
End Benchmark.