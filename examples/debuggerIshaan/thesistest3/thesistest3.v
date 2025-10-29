Add Rec LoadPath "../../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
  Verit_Checker "thesistest3.smt2" "thesistest3.pf".
End Benchmark.