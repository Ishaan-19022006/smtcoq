Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
    Verit_Checker "Thesis_Tests/thesistest6/thesistest6.smt2" "Thesis_Tests/thesistest6/thesistest6.pf".
End Benchmark.
