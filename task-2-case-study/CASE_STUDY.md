# Case studies: safe division and toy RSA

Task II contains two examples: safe natural-number division and a deliberately
small RSA round trip. The Lean file uses only the Lean standard library and
contains no `sorry` placeholders.

## Scenario 1: safe natural-number division

### Problem and contract

Division needs an explicit policy for a zero denominator. This API accepts
natural numbers and returns `none` when the denominator is zero. For a positive
denominator, it returns the natural-number floor quotient. Using `Option Nat`
makes the zero case visible in the result type.

### Implementations and guarantees

`LeanImpl.lean` defines `safeDiv : Nat → Nat → Option Nat`. Its theorems establish
that zero yields `none`, nonzero denominators yield the Lean quotient, any
`some` result has the stated quotient and a nonzero denominator, and `none`
occurs exactly at zero. These statements cover every natural-number input.

`python_impl.py` implements the same wrapper behavior using Python's `//` and
`None`. Negative inputs are rejected because Python integers include values
outside Lean's `Nat` domain. The tests check boundary cases and quotient bounds
for a finite input range.

The proofs use Lean's built-in natural-number division; they do not verify a
separate division algorithm or prove a quotient/remainder characterization.
They also do not prove the Python translation correct.

## Scenario 2: toy RSA correctness

The RSA key uses `p = 3`, `q = 11`, giving `n = p*q = 33` and
`phi(n) = (p-1)(q-1) = 20`. The public exponent is `e = 3`, and the private
exponent is `d = 7`, so `e*d = 21`, congruent to 1 modulo 20. The supported
messages are residues from 0 through 32. Encryption computes `m^e mod n`;
decryption computes `c^d mod n`.

In the `RSA` namespace, `LeanImpl.lean` defines `IsPrime`, `Coprime`, `phi`,
`encrypt`, and `decrypt` using only the Lean standard library. It proves the
toy key's setup facts and checks the round trip for each of the 33 messages with
kernel-checked computation. This is an exhaustive proof for one finite key,
not a general RSA theorem.

The Python interface is key-oriented: `generate_keys(p, q, e)` returns public
and private key tuples, `encrypt` takes a message and public key, and `decrypt`
takes a ciphertext and private key. Python's three-argument `pow` performs
modular exponentiation. Tests exhaust the same 33-message key, check a second
small key, and cover invalid key inputs and out-of-range messages.

Python's general key-generation routine is additional functionality; Lean does
not verify that routine or the Python implementation. The formal RSA result
covers only encryption and decryption for the fixed toy key. This example is
not secure RSA: its modulus is trivially factorable, it uses no padding, and it
does not address side channels or implementation hardening.

## Verification boundary

Lean proofs establish propositions about Lean definitions. They do not
automatically establish that the separate Python implementation has the same
behavior. Python tests check selected cases but cannot replace proofs. Neither
scenario establishes performance or runtime-system properties.

## Reproduction

From the repository root, run:

```sh
python task-2-case-study/python_impl.py
python -m unittest discover -s task-2-case-study -p "test_*.py"
lean task-2-case-study/LeanImpl.lean
```

Check Task I with `lean task-1-logic-proofs/Logic.lean`.
