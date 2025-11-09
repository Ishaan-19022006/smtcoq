Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
    Verit_Checker "Thesis_Tests/thesistest7/thesistest7.smt2" "Thesis_Tests/thesistest7/thesistest7.pf".
End Benchmark.
