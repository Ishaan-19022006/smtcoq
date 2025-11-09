Add Rec LoadPath "../../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
  Verit_Checker "thesistest6.smt2" "thesistest6.pf".
End Benchmark.