# Lean 4 Formal Verification Assignment

This repository contains two exercises in formal reasoning and program
contracts.

## Repository contents

| Path | Purpose |
| --- | --- |
| `task-1-logic-proofs/Logic.lean` | Proofs of the ten assigned propositional logic theorems |
| `task-2-case-study/LeanImpl.lean` | A total safe-division API and Lean theorems about its result |
| `task-2-case-study/python_impl.py` | Python counterpart to the safe-division API |
| `task-2-case-study/test_python_impl.py` | Dynamic tests for examples, input boundaries, and quotient bounds |
| `task-2-case-study/CASE_STUDY.md` | Scope, proof guarantees, and limitations of the case study |

The files in `prac/` are personal Lean exercises and are not part of the
assignment submission.

## Requirements

- Python 3.10 or later (the implementation uses `int | None`).
- Lean 4 with `lean` available on `PATH`.

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

Lean proofs establish the stated propositions about the Lean definitions.
They do not prove that the separate Python implementation is correct or that
compiled programs meet performance or runtime-system requirements. See the
case study for the precise guarantee and its boundaries.
