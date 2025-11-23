Add Rec LoadPath "../../src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
    Verit_Checker "Thesis_Tests/thesistest5/thesistest5.smt2" "Thesis_Tests/thesistest5/thesistest5.pf".
End Benchmark.
