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

/-- The function returns `none` exactly when the denominator is zero. -/
theorem safeDiv_none_iff (numerator denominator : Nat) :
    safeDiv numerator denominator = none ↔ denominator = 0 := by
  by_cases h : denominator = 0
  · simp [safeDiv, h]
  · simp [safeDiv, h]

end SafeDivision
