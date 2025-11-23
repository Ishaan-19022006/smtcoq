Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
    Verit_Checker "Thesis_Tests/thesistest2/thesistest2.smt2" "Thesis_Tests/thesistest2/thesistest2.pf".
End Benchmark.
