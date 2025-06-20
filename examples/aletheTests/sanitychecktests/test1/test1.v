Add Rec LoadPath "/Users/ishaankumar1902/Desktop/smtcoq/src" as SMTCoq.
Require Import SMTCoq.SMTCoq.
Require Import Bool.
Section Benchmark.
  Verit_Checker "/Users/ishaankumar1902/Desktop/smtcoq/examples/aletheTests/sanitychecktests/test1/test1.smt2" "/Users/ishaankumar1902/Desktop/smtcoq/examples/aletheTests/sanitychecktests/test1/test1.pf".
End Benchmark.
