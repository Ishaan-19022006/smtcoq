Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
    Verit_Checker "Thesis_Tests/thesistest4/thesistest4.smt2" "Thesis_Tests/thesistest4/thesistest4.pf".
End Benchmark.
