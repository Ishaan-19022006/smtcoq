Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
    Verit_Checker "Thesis_Tests/thesistest3/thesistest3.smt2" "Thesis_Tests/thesistest3/thesistest3.pf".
End Benchmark.
