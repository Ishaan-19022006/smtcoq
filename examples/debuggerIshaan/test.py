from coqpyt.coq.proof_file import ProofFile

with ProofFile("test.v") as pf:
    pf.exec(nsteps = 1)
    print("In proof:", pf.in_proof)