/-!
# Safe division case study

`safeDiv n d` returns `none` when `d` is zero and otherwise returns the
natural-number quotient. The theorems below state the key behavior.
-/

namespace SafeDivision

/-- Divide two natural numbers, explicitly representing division by zero. -/
def safeDiv (numerator denominator : Nat) : Option Nat :=
  if denominator = 0 then none else some (numerator / denominator)

/-- A zero denominator always produces no quotient. -/
theorem safeDiv_zero_denominator (numerator : Nat) :
    safeDiv numerator 0 = none := by
  simp [safeDiv]

/-- A nonzero denominator always produces a quotient. -/
theorem safeDiv_nonzero_denominator (numerator denominator : Nat)
    (h : denominator ≠ 0) :
    safeDiv numerator denominator = some (numerator / denominator) := by
  simp [safeDiv, h]

/-- A result exists exactly when the denominator is positive, and its value
is Lean's natural-number quotient. -/
theorem safeDiv_some_iff (numerator denominator quotient : Nat) :
    safeDiv numerator denominator = some quotient ↔
      denominator ≠ 0 ∧ quotient = numerator / denominator := by
  constructor
  · intro h
    constructor
    · intro hz
      simp [safeDiv, hz] at h
    · by_cases hd : denominator = 0
      · simp [safeDiv, hd] at h
      · have h' : some (numerator / denominator) = some quotient := by
          simpa [safeDiv, hd] using h
        exact (Option.some.inj h').symm
  · rintro ⟨hd, rfl⟩
    simp [safeDiv, hd]

/-- The function returns `none` exactly when the denominator is zero. -/
theorem safeDiv_none_iff (numerator denominator : Nat) :
    safeDiv numerator denominator = none ↔ denominator = 0 := by
  by_cases h : denominator = 0
  · simp [safeDiv, h]
  · simp [safeDiv, h]

end SafeDivision

/-!
# RSA case study

The executable RSA definitions use only Lean's standard library. The fixed
toy key is checked exhaustively below; this file does not claim a general
number-theoretic RSA theorem.
-/
namespace RSA

/-- A basic prime predicate, stated using divisors. -/
def IsPrime (p : Nat) : Prop :=
  1 < p ∧ ∀ d : Nat, d ∣ p → d = 1 ∨ d = p

/-- Coprimality expressed through the standard-library gcd. -/
def Coprime (a b : Nat) : Prop := Nat.gcd a b = 1

/-- Euler-phi formula for a product of distinct primes. -/
def phi (p q : Nat) : Nat := (p - 1) * (q - 1)

def encrypt (e n m : Nat) : Nat := (m ^ e) % n
def decrypt (d n c : Nat) : Nat := (c ^ d) % n

/-! Toy key: p=3, q=11, n=33, phi=20, e=3, d=7. -/
def toyModulus : Nat := 33
def toyPublicExponent : Nat := 3
def toyPrivateExponent : Nat := 7

/-! Verify the arithmetic assumptions used by the toy key. -/
example : IsPrime 3 := by decide
example : IsPrime 11 := by decide
example : Coprime 3 11 := by decide
example : phi 3 11 = 20 := by decide
example : (toyPublicExponent * toyPrivateExponent) % phi 3 11 = 1 := by decide

/-! Kernel-checked computation covers every residue modulo this toy modulus. -/
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 0) = 0 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 1) = 1 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 2) = 2 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 3) = 3 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 4) = 4 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 5) = 5 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 6) = 6 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 7) = 7 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 8) = 8 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 9) = 9 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 10) = 10 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 11) = 11 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 12) = 12 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 13) = 13 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 14) = 14 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 15) = 15 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 16) = 16 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 17) = 17 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 18) = 18 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 19) = 19 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 20) = 20 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 21) = 21 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 22) = 22 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 23) = 23 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 24) = 24 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 25) = 25 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 26) = 26 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 27) = 27 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 28) = 28 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 29) = 29 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 30) = 30 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 31) = 31 := by decide
example : decrypt toyPrivateExponent toyModulus
    (encrypt toyPublicExponent toyModulus 32) = 32 := by decide

end RSA
