# Case study: safe natural-number division

## Problem

Integer division by zero is an error in many programming languages. A caller
that receives a denominator from a file, user, or computation must handle that
case. This case study implements a small total API: given natural numbers
`numerator` and `denominator`, return the floor quotient when the denominator is
positive and return no value when it is zero.

## Implementations

`LeanImpl.lean` defines `safeDiv : Nat → Nat → Option Nat`. Its `Option` result
makes the zero-denominator case explicit. The file proves that zero produces
`none`, every nonzero denominator produces the expected quotient, and `none`
occurs exactly for a zero denominator.

`python_impl.py` implements the same behavior with `None` as the missing result
and Python's `//` for floor division. Since Python integers include negatives
but Lean's `Nat` does not, the Python function rejects negative arguments. Run
`python python_impl.py` to execute representative examples and bounded checks
against the quotient contract.

## What formal verification adds

The Python checks exercise selected inputs (including all pairs below 20), but
they cannot establish behavior for every natural number. The Lean theorems are
universally quantified: they prove the zero/nonzero branch behavior for all
numerators and denominators, based on the definition. This does not prove the
Python implementation correct or establish performance; the Python checks are
still useful as an executable cross-check of its translation.

## Reproduction

From this directory, run `python python_impl.py`. With Lean 4 installed, check
the formal file with `lean LeanImpl.lean`.
