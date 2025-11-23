Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
    Verit_Checker "ex2/ex2.smt2" "ex2/ex2.pf".
End Benchmark.
