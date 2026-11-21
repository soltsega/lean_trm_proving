/-!
# Basic Lean Practice

This file contains small examples and practice problems.
Replace each `sorry` with a proof. Successful solutions should contain no `sorry`.

Suggested workflow:
1. Read one exercise.
2. State the goal in your own words.
3. Try `rfl`, `intro`, `apply`, `rw`, `exact`, `constructor`, or `cases`.
4. Use `#check`, `#print`, and `by` for experiments.
-/

/- ============================================================
   1. Types and Values
   ============================================================ -/

#check Nat
#check Bool
#check String
#check List
#check 42
#check (42 : Nat)
#check true
#check "hello"

def seven : Nat := 7
def greeting : String := "Hello"
def aList : List Nat := [1, 2, 3]

#eval seven
#eval greeting
#eval aList
#eval aList.length
#eval aList.head?
#eval 3 + 4
#eval 3 * 4
#eval 7 - 10

example : seven = 7 := rfl

example : 2 + 3 = 5 := rfl
example : 2 * 6 = 12 := rfl

/- TODO 1: Write a function that adds 1. -/
def addOne (n : Nat) : Nat :=
  sorry

/- TODO 2: Write a function that doubles a natural number. -/
def double (n : Nat) : Nat :=
  sorry

/- TODO 3: Write a function that subtracts one, except at zero. -/
def predSafe (n : Nat) : Nat :=
  sorry

/- ============================================================
   2. Boolean Logic
   ============================================================ -/

#eval true && false
#eval true || false
#eval not true
#eval 3 < 5
#eval 3 ≤ 3
#eval 3 == 3
#eval 3 != 4

example : not false = true := rfl
example : true && true = true := rfl
example : false || true = true := rfl

def andSelf (b : Bool) : (b && b) = b :=
  match b with
  | true => rfl
  | false => rfl

def orFalse (b : Bool) : (b || false) = b :=
  match b with
  | true => rfl
  | false => rfl

/- TODO 4: Prove that Boolean NOT is involutive. -/
def notNot (b : Bool) : !(!b) = b :=
  sorry

/- TODO 5: Prove OR commutativity by cases. -/
def orComm (a b : Bool) : a || b = b || a :=
  sorry

/- TODO 6: Prove AND commutativity by cases. -/
def andComm (a b : Bool) : a && b = b && a :=
  sorry

/- ============================================================
   3. Equality and Basic Tactics
   ============================================================ -/

example (a b : Nat) (h : a = b) : b = a := by
  exact h.symm

example (a b c : Nat) (hab : a = b) (hbc : b = c) : a = c := by
  exact hab.trans hbc

example (n : Nat) : n + 0 = n := by
  exact Nat.add_zero n

example (n : Nat) : 0 + n = n := by
  exact Nat.zero_add n

example (n : Nat) : n + 1 = Nat.succ n := by
  rfl

/- TODO 7: Use `rw` to prove this. -/
example (a b c : Nat) (h : a = b) : a + c = b + c :=
  sorry

/- TODO 8: Use transitivity. -/
example (a b c d : Nat) (h1 : a = b) (h2 : b = c) (h3 : c = d) : a = d :=
  sorry

/- TODO 9: Use congruence. -/
example (n m : Nat) (h : n = m) : n * n = m * m :=
  sorry

/- ============================================================
   4. Functions
   ============================================================ -/

def compose {α β γ : Type} (f : β → γ) (g : α → β) : α → γ :=
  fun x => f (g x)

def twice (f : Nat → Nat) : Nat → Nat :=
  fun n => f (f n)

example : (compose Nat.succ (fun n => n * 2)) 3 = 7 := rfl

example : twice (fun n => n + 1) 5 = 7 := rfl

/- TODO 10: Apply a function to an argument. -/
example (f : Nat → Nat) (n : Nat) (h : f n = 10) : 2 + f n = 12 :=
  sorry

/- TODO 11: Show function application respects equality. -/
example (f : Nat → Nat) (x y : Nat) (h : x = y) : f x = f y :=
  sorry

/- TODO 12: Simplify this composition. -/
example : (compose (fun n => n + 1) (fun n => n * 2)) 4 = 9 := rfl

/- ============================================================
   5. Propositional Logic
   ============================================================ -/

example (P : Prop) (hp : P) : P := hp

example (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := by
  constructor
  · exact hp
  · exact hq

example (P Q : Prop) (h : P ∧ Q) : P := h.left

example (P Q : Prop) (h : P ∧ Q) : Q := h.right

example (P Q : Prop) (h : P ∧ Q) : Q ∧ P := by
  constructor
  · exact h.right
  · exact h.left

example (P : Prop) : P → P := by
  intro hp
  exact hp

example (P Q R : Prop) : (P → Q) → (Q → R) → P → R := by
  intro hpq hqr hp
  exact hqr (hpq hp)

example (P Q : Prop) : P → Q → P := by
  intro hp hq
  exact hp

example (P Q : Prop) : P → P ∨ Q := by
  intro hp
  left
  exact hp

example (P Q : Prop) : Q → P ∨ Q := by
  intro hq
  right
  exact hq

example (P Q : Prop) (h : P ∨ Q) : Q ∨ P := by
  cases h with
  | inl hp => right; exact hp
  | inr hq => left; exact hq

example (P Q R : Prop) (h : P → Q) (k : Q → R) : P → R := by
  intro hp
  exact k (h hp)

/- TODO 13: Curry an implication. -/
example (P Q R : Prop) : (P ∧ Q → R) → P → Q → R :=
  sorry

/- TODO 14: Extract both conjunction components. -/
example (P Q R : Prop) (h : P ∧ Q ∧ R) : P ∧ R :=
  sorry

/- TODO 15: Introduce and eliminate conjunction. -/
example (P Q : Prop) : P → Q → P ∧ Q :=
  sorry

/- TODO 16: Prove disjunction commutativity. -/
example (P Q : Prop) : P ∨ Q → Q ∨ P :=
  sorry

/- TODO 17: Eliminate an implication. -/
example (P Q : Prop) (hpq : P → Q) (hp : P) : Q :=
  sorry

/- TODO 18: Prove a contrapositive in a simple form. -/
example (P Q : Prop) : (P → Q) → (¬Q → ¬P) :=
  sorry

/- TODO 19: Prove a useful distributive implication. -/
example (P Q R : Prop) : (P → Q) → (P → R) → P → Q ∧ R :=
  sorry

/- TODO 20: Destruct an implication and prove the result. -/
example (P Q R : Prop) : (P → Q → R) → P ∧ Q → R :=
  sorry

/- ============================================================
   6. Existentials and Universal Quantifiers
   ============================================================ -/

example : ∃ n : Nat, n = 5 := by
  exists 5

example : ∃ n : Nat, n > 3 := by
  exists 4

example : ∀ n : Nat, n = n := by
  intro n
  rfl

example : ∀ n : Nat, n + 0 = n := by
  intro n
  exact Nat.add_zero n

example (P : Nat → Prop) (h : ∃ n, P n) : ∃ n, P n := h

/- TODO 21: Supply a witness. -/
example : ∃ n : Nat, n * n = 16 :=
  sorry

/- TODO 22: Prove a universal statement. -/
example : ∀ n : Nat, n + 1 = Nat.succ n :=
  sorry

/- TODO 23: Eliminate and reintroduce an existential. -/
example (P Q : Nat → Prop) (h : ∃ n, P n ∧ Q n) : ∃ n, P n :=
  sorry

/- TODO 24: Map a predicate over an existential witness. -/
example (P Q : Nat → Prop) (h : ∀ n, P n → Q n) (e : ∃ n, P n) :
    ∃ n, Q n :=
  sorry

/- TODO 25: Swap nested quantifier instantiation. -/
example (P : Nat → Nat → Prop) (h : ∀ x y, P x y) : ∀ y x, P x y :=
  sorry

/- ============================================================
   7. Proof by Cases
   ============================================================ -/

def Nat.isZero (n : Nat) : Bool :=
  match n with
  | 0 => true
  | _ => false

example (n : Nat) : n = 0 ∨ n ≠ 0 := by
  cases n with
  | zero => left; rfl
  | succ n => right; intro h; cases h

example (n : Nat) : n = 0 → n + 1 = 1 := by
  intro h
  rw [h]

example (n : Nat) : n ≠ 0 → n + 1 ≠ 1 := by
  intro h hn
  have hsucc : n = 0 := by
    exact Nat.succ.inj (hn)
  exact h hsucc

/- TODO 26: Prove a theorem by natural-number cases. -/
example (n : Nat) : n = 0 ∨ n ≥ 1 :=
  sorry

/- TODO 27: Handle the Boolean cases explicitly. -/
example (b : Bool) : b = true ∨ b = false :=
  sorry

/- TODO 28: Prove this with `by_cases`. -/
example (P : Prop) : P ∨ ¬P :=
  sorry

/- ============================================================
   8. Natural Number Induction
   ============================================================ -/

def add (n m : Nat) : Nat :=
  match n with
  | 0 => m
  | Nat.succ n => Nat.succ (add n m)

example : add 0 7 = 7 := rfl
example : add 3 4 = 7 := rfl

theorem add_zero_right (n : Nat) : add n 0 = n := by
  induction n with
  | zero => rfl
  | succ n ih =>
      rw [add]
      rw [ih]

/- TODO 29: Prove 0 is an identity on the right for natural-number addition. -/
theorem natAddZeroRight (n : Nat) : n + 0 = n :=
  sorry

/- TODO 30: Prove associativity of custom `add`. -/
theorem add_assoc (a b c : Nat) : add (add a b) c = add a (add b c) := by
  sorry

/- TODO 31: Prove commutativity of custom `add`. -/
theorem add_comm (a b : Nat) : add a b = add b a := by
  sorry

/- TODO 32: Prove the successor lemma for custom `add`. -/
theorem add_succ (a b : Nat) : add (Nat.succ a) b = Nat.succ (add a b) := by
  sorry

/- TODO 33: Prove that doubling distributes over successor. -/
theorem double_succ (n : Nat) : double (Nat.succ n) = Nat.succ (Nat.succ (double n)) :=
  sorry

/- TODO 34: Prove all natural numbers have this property. -/
theorem zero_le (n : Nat) : 0 ≤ n := by
  sorry

/- ============================================================
   9. Lists
   ============================================================ -/

def map {α β : Type} (f : α → β) : List α → List β
  | [] => []
  | x :: xs => f x :: map f xs

def filter {α : Type} (p : α → Bool) : List α → List α
  | [] => []
  | x :: xs =>
      if p x then x :: filter p xs else filter p xs

def reverse {α : Type} : List α → List α
  | [] => []
  | x :: xs => reverse xs ++ [x]

def append {α : Type} : List α → List α → List α
  | [], ys => ys
  | x :: xs, ys => x :: append xs ys

#eval map (fun n => n * n) [1, 2, 3, 4]
#eval filter (fun n => n % 2 == 0) [1, 2, 3, 4, 5]
#eval reverse [1, 2, 3]
#eval append [1, 2] [3, 4]

example : map (fun n => n + 1) [1, 2, 3] = [2, 3, 4] := rfl
example : reverse [1, 2, 3] = [3, 2, 1] := rfl
example : append [1, 2] [3, 4] = [1, 2, 3, 4] := rfl

/- TODO 35: Map the identity function. -/
theorem mapId {α : Type} (xs : List α) : map (fun x => x) xs = xs :=
  sorry

/- TODO 36: Map twice is composition. -/
theorem mapMap {α β γ : Type}
    (f : α → β) (g : β → γ) (xs : List α) :
    map g (map f xs) = map (fun x => g (f x)) xs :=
  sorry

/- TODO 37: Appending to the empty list. -/
theorem append_nil {α : Type} (xs : List α) : append xs [] = xs :=
  sorry

/- TODO 38: Associativity of custom list append. -/
theorem append_assoc {α : Type}
    (xs ys zs : List α) :
    append (append xs ys) zs = append xs (append ys zs) :=
  sorry

/- TODO 39: Reverse a singleton list. -/
theorem reverse_singleton {α : Type} (x : α) : reverse [x] = [x] :=
  sorry

/- TODO 40: Reverse reverses append. -/
theorem reverse_append {α : Type}
    (xs ys : List α) :
    reverse (append xs ys) = append (reverse ys) (reverse xs) :=
  sorry

/- TODO 41: Reverse is involutive. -/
theorem reverse_reverse {α : Type} (xs : List α) : reverse (reverse xs) = xs :=
  sorry

/- TODO 42: Length of a mapped list. -/
theorem length_map {α β : Type} (f : α → β) (xs : List α) :
    (map f xs).length = xs.length :=
  sorry

/- TODO 43: Length of custom append. -/
theorem length_append {α : Type} (xs ys : List α) :
    (append xs ys).length = xs.length + ys.length :=
  sorry

/- ============================================================
   10. Sum and Option Types
   ============================================================ -/

def safeHead {α : Type} : List α → Option α
  | [] => none
  | x :: _ => some x

def fromOption (default : Nat) : Option Nat → Nat
  | none => default
  | some n => n

#eval safeHead [7, 8]
#eval safeHead ([] : List Nat)
#eval fromOption 0 (some 9)
#eval fromOption 0 none

example : safeHead ([] : List Nat) = none := rfl
example : safeHead [4, 5] = some 4 := rfl
example : fromOption 12 (some 3) = 3 := rfl
example : fromOption 12 none = 12 := rfl

/- TODO 44: Map an Option value. -/
def optionMap {α β : Type} (f : α → β) : Option α → Option β
  | none => sorry
  | some x => sorry

/- TODO 45: Prove that Option map preserves none. -/
theorem optionMap_none {α β : Type} (f : α → β) :
    optionMap f none = none :=
  sorry

/- TODO 46: Prove that Option map preserves some. -/
theorem optionMap_some {α β : Type} (f : α → β) (x : α) :
    optionMap f (some x) = some (f x) :=
  sorry

/- TODO 47: Sum elimination. -/
def sumElim {α β γ : Type} (f : α → γ) (g : β → γ) : α ⊕ β → γ
  | Sum.inl x => f x
  | Sum.inr y => g y

/- TODO 48: Prove sum elimination on the left. -/
theorem sumElim_inl {α β γ : Type}
    (f : α → γ) (g : β → γ) (x : α) :
    sumElim f g (Sum.inl x) = f x :=
  sorry

/- ============================================================
   11. Structures and Subtypes
   ============================================================ -/

structure Point where
  x : Nat
  y : Nat
deriving Repr

def origin : Point := ⟨0, 0⟩
def moveRight (p : Point) : Point := ⟨p.x + 1, p.y⟩

example : (moveRight origin).x = 1 := rfl

structure RGB where
  red : Nat
  green : Nat
  blue : Nat
  hRed : red < 256
  hGreen : green < 256
  hBlue : blue < 256

/- TODO 49: Add two points. -/
def addPoint (p q : Point) : Point :=
  sorry

/- TODO 50: Double a point. -/
def doublePoint (p : Point) : Point :=
  sorry

/- TODO 51: Translate a point. -/
def translate (p : Point) (dx dy : Nat) : Point :=
  sorry

/- TODO 52: Prove addition of two points is commutative componentwise. -/
theorem addPoint_comm (p q : Point) : addPoint p q = addPoint q p :=
  sorry

/- ============================================================
   12. Inductive Types
   ============================================================ -/

inductive Weekday where
  | monday
  | tuesday
  | wednesday
  | thursday
  | friday
  | saturday
  | sunday

def next : Weekday → Weekday
  | .monday => .tuesday
  | .tuesday => .wednesday
  | .wednesday => .thursday
  | .thursday => .friday
  | .friday => .saturday
  | .saturday => .sunday
  | .sunday => .monday

def isWeekend : Weekday → Bool
  | .saturday => true
  | .sunday => true
  | _ => false

example : next Weekday.friday = Weekday.saturday := rfl
example : isWeekend Weekday.sunday = true := rfl

/- TODO 53: Go forward five weekdays. -/
def fiveDaysLater (d : Weekday) : Weekday :=
  sorry

/- TODO 54: Show Friday is not a weekend. -/
theorem friday_not_weekend : isWeekend Weekday.friday = false :=
  sorry

inductive NatTree where
  | leaf : Nat → NatTree
  | node : NatTree → NatTree → NatTree

def treeSize : NatTree → Nat
  | .leaf _ => 1
  | .node l r => 1 + treeSize l + treeSize r

def treeSum : NatTree → Nat
  | .leaf n => n
  | .node l r => treeSum l + treeSum r

/- TODO 55: Count all leaf nodes. -/
def leafCount : NatTree → Nat :=
  sorry

/- TODO 56: Find the maximum in a tree. -/
def treeMax : NatTree → Nat :=
  sorry

/- ============================================================
   13. Decidable Computation and Equality
   ============================================================ -/

example : decide (2 + 2 = 4) = true := rfl
example : decide (2 + 2 = 5) = false := rfl

def NatEqDecidable (a b : Nat) : Bool := decide (a = b)

example : NatEqDecidable 3 3 = true := rfl
example : NatEqDecidable 3 4 = false := rfl

/- TODO 57: Use decide for this fact. -/
example : decide (7 < 10) = true := rfl

/- TODO 58: Write a Boolean equality test for Nat. -/
def natEq (a b : Nat) : Bool :=
  sorry

/- ============================================================
   14. Mixed Review Exercises
   ============================================================ -/

/- TODO 59: Function composition is associative. -/
theorem compose_assoc {α β γ δ : Type}
    (f : α → β) (g : β → γ) (h : γ → δ) :
    compose h (compose g f) = compose (compose h g) f :=
  sorry

/- TODO 60: Prove a triangle equality. -/
theorem triple_trans
    (a b c d : Nat) (hab : a = b) (hbc : b = c) (hcd : c = d) :
    a = d :=
  sorry

/- TODO 61: Prove conjunction commutativity. -/
theorem prop_and_comm (P Q : Prop) : P ∧ Q ↔ Q ∧ P :=
  sorry

/- TODO 62: Prove implication composition. -/
theorem implication_chain
    (P Q R : Prop) (hpq : P → Q) (hqr : Q → R) : P → R :=
  sorry

/- TODO 63: Prove OR elimination. -/
theorem or_elim (P Q R : Prop) :
    P ∨ Q → (P → R) → (Q → R) → R :=
  sorry

/- TODO 64: Characterize a one-element list. -/
theorem singleton_length {α : Type} (x : α) : ([x] : List α).length = 1 :=
  sorry

/- TODO 65: Characterize the length of a two-element list. -/
theorem pair_length {α : Type} (x y : α) : ([x, y] : List α).length = 2 :=
  sorry

/- TODO 66: Prove a list predicate constructively. -/
theorem head_some {α : Type} (x : α) (xs : List α) :
    safeHead (x :: xs) = some x :=
  sorry

/- TODO 67: Prove a list predicate constructively. -/
theorem head_none {α : Type} :
    safeHead ([] : List α) = none :=
  sorry

/- TODO 68: Prove a Boolean negation in a theorem. -/
theorem neg_neg (b : Bool) : !!b = b :=
  sorry

/- TODO 69: Prove De Morgan for booleans. -/
theorem deMorgan_and (a b : Bool) :
    !(a && b) = (!a) || (!b) :=
  sorry

/- TODO 70: Prove De Morgan for booleans. -/
theorem deMorgan_or (a b : Bool) :
    !(a || b) = (!a) && (!b) :=
  sorry

/- TODO 71: Prove an arithmetic implication. -/
theorem add_one_pos (n : Nat) : 0 < n + 1 :=
  sorry

/- TODO 72: Prove addition of zero. -/
theorem custom_add_zero_left (n : Nat) : add 0 n = n :=
  sorry

/- TODO 73: Prove multiplication by zero. -/
theorem mul_zero (n : Nat) : n * 0 = 0 :=
  sorry

/- TODO 74: Prove multiplication by one on the right. -/
theorem mul_one_right (n : Nat) : n * 1 = n :=
  sorry

/- TODO 75: Prove that even and odd successor alternate. -/
def even : Nat → Bool
  | 0 => true
  | Nat.succ n => !even n

example : even 0 = true := rfl
example : even 1 = false := rfl
example : even 2 = true := rfl
example : even 3 = false := rfl

/- TODO 76: Prove a parity relation. -/
theorem even_succ (n : Nat) : even (Nat.succ n) = !even n :=
  sorry

/- TODO 77: Prove the successor isn't zero. -/
theorem succ_ne_zero (n : Nat) : Nat.succ n ≠ 0 := by
  sorry

/- TODO 78: Prove natural equality injectivity. -/
theorem succ_inj (n m : Nat) (h : Nat.succ n = Nat.succ m) : n = m :=
  sorry

/- TODO 79: Prove an existential is nonempty. -/
theorem exists_three : ∃ n : Nat, n + 3 = 7 :=
  sorry

/- TODO 80: Prove the point origin is at zero. -/
theorem origin_zero : origin.x = 0 ∧ origin.y = 0 :=
  sorry

/- ============================================================
   Final Challenges
   ============================================================ -/

/- Challenge 1: Prove de Morgan for propositions constructively.
   Conjunction of negations implies negation of disjunction. -/
theorem prop_deMorgan (P Q : Prop) : ¬P ∧ ¬Q → ¬(P ∨ Q) :=
  sorry

/- Challenge 2: Prove one direction of this iff. -/
theorem nat_le_zero (n : Nat) : n ≤ 0 → n = 0 :=
  sorry

/- Challenge 3: Express and prove that if a list is empty,
   its reverse is empty. -/
theorem reverse_empty {α : Type} :
    reverse ([] : List α) = ([] : List α) :=
  sorry