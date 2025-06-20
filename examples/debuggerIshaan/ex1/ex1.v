Add Rec LoadPath "/Users/ishaankumar1902/Desktop/smtcoq/examples/debuggerIshaan/ex1" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
  Verit_Checker "ex1.smt2" "ex1.pf".
End Benchmark.