# Case study: safe natural-number division

## Problem and contract

Division needs an explicit policy for a zero denominator. This API accepts
natural numbers and returns `none` when the denominator is zero. For a positive
denominator, it returns the natural-number floor quotient. Using `Option Nat`
makes the zero case visible in the result type instead of relying on an
exception or an undocumented precondition.

## Implementations

`LeanImpl.lean` defines `safeDiv : Nat → Nat → Option Nat`. Its theorems show
that a zero denominator returns `none`, that a nonzero denominator returns the
Lean quotient, that a `some` result can occur only for a nonzero denominator
and has the specified quotient, and that `none` occurs exactly at zero.
Together these describe the wrapper's behavior for all natural-number inputs.

`python_impl.py` implements the same wrapper behavior using Python's `//` and
`None`. Python integers also include negative values, so the implementation
rejects them to match Lean's `Nat` domain. Run the checks from the repository
root with:

```sh
python -m unittest discover -s task-2-case-study -p "test_*.py"
```

The dynamic tests include zero and negative inputs, examples, and quotient
bounds for a finite range. As with any finite test set, they do not establish
the behavior for every input.

## What is and is not formally verified

Lean checks the proofs against the definitions and its kernel. The results
cover every natural-number input to `safeDiv` and establish which `Option`
branch it returns and what value it contains. The quotient operation itself
comes from Lean's natural-number division; this case study does not implement a
division algorithm or prove a separate quotient/remainder characterization.

The proofs do not verify the Python translation, Python's runtime, or
performance. The Python tests are a useful independent check of the intended
translation, but they cannot inherit Lean's proof guarantees. This distinction
is important: the formal result applies to the Lean definition and the
theorems stated here, not automatically to every implementation of the same
idea.

## Check the Lean file

From the repository root, run `lean task-2-case-study/LeanImpl.lean` with Lean
4 installed. The root README documents commands for both assignment tasks.
