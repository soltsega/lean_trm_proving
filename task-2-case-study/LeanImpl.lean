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
