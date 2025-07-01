from coqpyt.coq.proof_file import ProofFile

with ProofFile("test.v") as pf:
    print(pf.context)