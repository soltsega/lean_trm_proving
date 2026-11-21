-- #check Nat
-- #check Nat.add

-- #print Nat
-- #print Nat.add


#print Nat.zero
#print Nat.succ
-- ∀

-- ↔

-- →

-- ∧

-- ∨

-- α

-- β

-- γ

-- δ

-- ¬

-- →

-- ⋗

-- ≤
-- ≥

-- ∃


#eval 3 + 4
#eval "hello world"
#print Nat.add


namespace Exercises

variable (P Q R : Prop)

theorem T51 (h1 : P) (h2 : P → Q) : P ∧ Q := by
  constructor
  · exact h1
  · exact h2 h1

theorem T52(h1 : P ∧ Q → R) (h2 : Q → P) (h3 : Q) : R := by
  apply h1
  constructor
  · exact h2 h3
  · exact h3
