# Lean 4 Formal Verification Assignment

This repository contains two exercises in formal reasoning and program
contracts.

## Repository contents

| Path | Purpose |
| --- | --- |
| `task-1-logic-proofs/Logic.lean` | Proofs of the ten assigned propositional logic theorems |
| `task-2-case-study/LeanImpl.lean` | Safe-division proofs and pure Lean RSA definitions with exhaustive toy-key proofs |
| `task-2-case-study/python_impl.py` | Python safe division and RSA key generation, encryption, and decryption |
| `task-2-case-study/test_python_impl.py` | Dynamic tests for both scenarios and Python RSA key handling |
| `task-2-case-study/CASE_STUDY.md` | Use cases, proof guarantees, and limitations |

The files in `prac/` are personal Lean exercises and are not part of the
assignment submission.

## Requirements

- Python 3.10 or later (the implementation uses `int | None`).
- Lean 4 with `lean` available on `PATH`.
- The Lean implementation uses only Lean's standard library; no Mathlib
  dependency is required.

The Lean version is not pinned in this repository. Use the Lean version
specified by your course or mentor when one is provided.

## Run the Python implementation and checks

From the repository root:

```sh
python task-2-case-study/python_impl.py
python -m unittest discover -s task-2-case-study -p "test_*.py"
```

## Check the Lean files

From the repository root:

```sh
lean task-1-logic-proofs/Logic.lean
lean task-2-case-study/LeanImpl.lean
```

Lean proofs establish the stated propositions about the Lean definitions. For
RSA, Lean proves the round trip exhaustively for the fixed toy key; Python also
contains a general key-generation routine that Lean does not verify. Neither
the toy example nor the Python code is secure for real use. Lean does not prove
the separate Python implementation correct or compiled programs' performance
or runtime behavior. See the case study for precise guarantees and limits.
