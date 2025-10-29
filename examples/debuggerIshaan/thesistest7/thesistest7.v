Add Rec LoadPath "../../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
  Verit_Checker "thesistest7.smt2" "thesistest7.pf".
End Benchmark.