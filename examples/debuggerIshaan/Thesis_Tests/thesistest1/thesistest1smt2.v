Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
    Verit_Checker "Thesis_Tests/thesistest1/thesistest1.smt2" "Thesis_Tests/thesistest1/thesistest1.pf".
End Benchmark.
