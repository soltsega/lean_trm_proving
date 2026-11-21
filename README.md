# Lean 4 Formal Verification Assignment

This repository contains two tasks:

- `task-1-logic-proofs/`: propositional logic proofs in Lean 4
- `task-2-case-study/`: a verified safe-division implementation and Python comparison

## Task 1

The ten propositional logic exercises are proved in
`task-1-logic-proofs/Logic.lean`.

## Task 2

The safe natural-number division implementation, its Lean correctness theorems,
the Python reference implementation, and the case-study write-up are stored in
`task-2-case-study/`. Run `python task-2-case-study/python_impl.py` to execute
the Python examples and bounded checks. With Lean 4 installed, check the Lean
files using `lean task-1-logic-proofs/Logic.lean` and
`lean task-2-case-study/LeanImpl.lean`.
