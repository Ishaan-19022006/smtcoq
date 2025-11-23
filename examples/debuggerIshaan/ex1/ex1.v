Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
  Verit_Checker "ex1/ex1.smt2" "ex1/ex1.pf".
End Benchmark.