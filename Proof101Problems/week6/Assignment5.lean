-- PROOF101 Week 6: Theorem Proving in Lean — Programming Assignment 5
-- Name: _________________
-- Date: _________________

/-
Instructions:
- Replace each `sorry` with a valid proof
- Make sure all theorems type-check
- You may use any tactic covered in Weeks 4–5: rfl, exact, decide, intro,
  rw, symm, apply, refine, obtain, constructor, left, right,
  cases, induction, simp, simp_all, omega, calc, have, etc.
- Do not modify the theorem statements or the provided definitions
- You ARE allowed (and encouraged!) to use previously proven theorems
  from this file in your proofs

Useful tactic reminders:
  rfl              — closes goals of the form `a = a`
  exact e          — closes the goal by providing the exact term `e`
  decide           — evaluates decidable propositions (concrete computations)
  intro h          — introduces a hypothesis `h` from the goal
  rw [h]           — rewrites the goal using equality `h` (left to right)
  rw [← h]         — rewrites right to left
  apply f          — performs backward reasoning with `f`
  constructor      — splits a ∧ goal into two subgoals
  left / right     — selects a side of a ∨ goal
  obtain ⟨a, b⟩    — destructures ∧ or ∃ hypotheses
  cases h with     — splits on constructors (for inductive types, ∨, etc.)
  induction x with — performs structural induction
  simp [f]         — simplifies using the defining equations of `f`
  omega            — solves linear arithmetic over ℕ and ℤ
  calc ...         — structured chain of equalities/inequalities
-/


-- ============================================================================
-- Provided Definitions (DO NOT MODIFY)
-- ============================================================================

/-! ### Custom list operations

We define our own list operations so you can prove properties about them
from first principles, without relying on Lean's built-in library lemmas.
You have implemented similar functions in Assignments 2 and 3, and now you
will *prove* things about them.
-/

def app {α : Type} : List α → List α → List α
  | [], ys => ys
  | x :: xs, ys => x :: app xs ys

def len {α : Type} : List α → Nat
  | [] => 0
  | _ :: xs => 1 + len xs

def naiveRev {α : Type} : List α → List α
  | [] => []
  | x :: xs => app (naiveRev xs) [x]

def myMap {α β : Type} (f : α → β) : List α → List β
  | [] => []
  | x :: xs => f x :: myMap f xs

/-! ### Binary tree type and operations -/

inductive BTree (α : Type) : Type where
  | empty : BTree α
  | node  : α → BTree α → BTree α → BTree α
  deriving Repr

namespace BTree

def size : BTree α → Nat
  | .empty => 0
  | .node _ l r => 1 + l.size + r.size

def mirror : BTree α → BTree α
  | .empty => .empty
  | .node v l r => .node v r.mirror l.mirror

def depth : BTree α → Nat
  | .empty => 0
  | .node _ l r => 1 + max l.depth r.depth

def mapTree (f : α → β) : BTree α → BTree β
  | .empty => .empty
  | .node v l r => .node (f v) (l.mapTree f) (r.mapTree f)

def flatten : BTree α → List α
  | .empty => []
  | .node v l r => app l.flatten (app [v] r.flatten)

end BTree

/-! ### A custom Nat function -/

def double : Nat → Nat
  | 0 => 0
  | n + 1 => double n + 2


-- ============================================================================
-- Part 1: Tactic Warm-Up — Propositional Logic (20 points)
-- ============================================================================

/-
These exercises warm you up with the basic building-block tactics.
Using induction here is overkill, careful use of intro, apply, exact,
constructor, cases, obtain, left, and right is enough.
-/

/- Problem 1.1 (5 points)
Theorem: Transitivity of implication.
-/
theorem imp_trans (P Q R : Prop) : (P → Q) → (Q → R) → P → R := by
  intro hpq hqr hp
  apply hqr
  apply hpq
  exact hp


/- Problem 1.2 (5 points)
Theorem: If P implies both Q and R, then P implies their conjunction.
Hint: After introducing hypotheses, use `constructor` to split the ∧ goal
into two separate subgoals.
-/
theorem imp_and_intro (P Q R : Prop) : (P → Q) → (P → R) → P → Q ∧ R := by
  intro hpq hpr hp
  constructor
  · exact hpq hp 
  · exact hpr hp


/- Problem 1.3 (5 points)
Theorem: ∧ distributes over ∨ (left to right).
Hint: First `obtain` the two parts of the ∧. Then `cases` on the ∨ part.
-/
theorem and_or_distrib (P Q R : Prop) : P ∧ (Q ∨ R) → (P ∧ Q) ∨ (P ∧ R) := by
  intro h
  obtain ⟨hp, hqr⟩ := h
  cases hqr with
  | inl hq => left; exact ⟨hp, hq⟩
  | inr hr => right; exact ⟨hp, hr⟩


/- Problem 1.4 (5 points)
Provide a concrete existential witness.
Hint: Use `exact ⟨witness, proof⟩`.
-/
theorem exists_witness : ∃ n : Nat, n * n + 3 * n + 2 = 12 := by
  exact ⟨2, rfl⟩


-- ============================================================================
-- Part 2: Induction on Natural Numbers (20 points)
-- ============================================================================

/-
These exercises use induction on Nat to prove properties of the `double`
function defined above. Remember the induction pattern:

  induction n with
  | zero => ...       -- base case: n = 0
  | succ n ih => ...  -- inductive step: assuming `ih` for n, prove for n+1

Tip: After unfolding the definition with `simp [double]`, you can often close
the arithmetic with `omega`.
-/

/- Problem 2.1 (5 points)
Theorem: Our custom `double` agrees with multiplication by 2.
Hint: Induction on n, then `simp [double]` to unfold...
-/
theorem double_eq_two_mul (n : Nat) : double n = 2 * n := by
  induction n with
  | zero => rfl
  | succ n ih => simp [double]; omega


/- Problem 2.2 (5 points)
Theorem: `double` distributes over addition.
Hint: Think carefully about which variable to induct on.
Recall that Lean defines addition by recursion on the second argument.
-/
theorem double_add (m n : Nat) : double (m + n) = double m + double n := by
  sorry


/- Problem 2.3 (5 points)
A concrete arithmetic fact using omega.
Hint: You should not necessarily use induction.
-/
theorem nat_squeeze (n : Nat) (h₁ : n > 5) (h₂ : n < 10) :
  2 * n + 1 ≥ 13 := by
  omega


/- Problem 2.4 (5 points)
Theorem: If n is positive then double n is positive.
Hint: Induction on n. In the zero case, the hypothesis `h : 0 > 0` is
contradictory — `omega` will close it.
-/
theorem double_pos (n : Nat) (h : n > 0) : double n > 0 := by
  induction n with
  | zero => omega
  | succ n ih => simp [double]


-- ============================================================================
-- Part 3: Induction on Lists (35 points)
-- ============================================================================

/-
Now we move to structural induction on lists. The pattern is:

  induction xs with
  | nil => ...           -- base case: xs = []
  | cons x xs ih => ...  -- inductive step: assuming `ih` for xs

The key technique is: unfold the custom function with `simp [f]`, then
use the inductive hypothesis `ih`, then (if needed) close with `omega`
for arithmetic or `rfl` for reflexivity.

IMPORTANT: You may (and should!) use theorems you proved earlier in later
proofs. For example, after proving `app_nil`, you can write `rw [app_nil]`
in subsequent proofs.
-/

/- Problem 3.1 (5 points)
Theorem: Appending the empty list on the right is the identity.
-/
theorem app_nil {α : Type} (xs : List α) : app xs [] = xs := by
  sorry


/- Problem 3.2 (8 points)
Theorem: Append is associative.
-/
theorem app_assoc {α : Type} (xs ys zs : List α) :
    app (app xs ys) zs = app xs (app ys zs) := by
  sorry


/- Problem 3.3 (7 points)
Theorem: Length distributes over append.
Hint: After `simp [...]`, you may need `omega`
to handle the resulting arithmetic (i.e. associativity of +).
-/
theorem len_app {α : Type} (xs ys : List α) :
    len (app xs ys) = len xs + len ys := by
  sorry


/- Problem 3.4 (7 points)
Theorem: Map distributes over append.
-/
theorem myMap_app {α β : Type} (f : α → β) (xs ys : List α) :
    myMap f (app xs ys) = app (myMap f xs) (myMap f ys) := by
  sorry


/- Problem 3.5 (8 points)
Theorem: Reversing a list preserves its length.

This might be the hardest problem in Part 3: you must combine induction with a
previously proven theorem.
-/
theorem len_naiveRev {α : Type} (xs : List α) :
    len (naiveRev xs) = len xs := by
  sorry


-- ============================================================================
-- Part 4: Induction on Binary Trees (30 points)
-- ============================================================================

/-
Structural induction on binary trees follows the same idea, but now the
inductive type has *two* recursive children:

  induction t with
  | empty => ...                    -- base case: the empty tree
  | node v l r ihl ihr => ...      -- inductive step: two IHs!

As with lists, `simp [f, ihl, ihr]` is your main workhorse.
-/

/- Problem 4.1 (8 points)
Theorem: Mirroring a tree twice gives back the original tree (mirror is an involution).
-/
theorem mirror_mirror {α : Type} (t : BTree α) :
    t.mirror.mirror = t := by
  sorry


/- Problem 4.2 (8 points)
Theorem: Mirroring preserves the number of nodes.
Hint: After `simp [...]`, you may need `omega` to handle the commutativity of addition
(since mirror swaps left and right, the addition order changes).
-/
theorem size_mirror {α : Type} (t : BTree α) :
    t.mirror.size = t.size := by
  sorry


/- Problem 4.3 (7 points)
Theorem: Mapping the identity function over a tree changes nothing (functor identity law).
-/
theorem mapTree_id {α : Type} (t : BTree α) :
    BTree.mapTree id t = t := by
  sorry


/- Problem 4.4 (7 points)
Theorem: Mapping f after g is the same as mapping (f ∘ g) (functor composition law).
Hint: On top of the expected tactics you'll use, you may also use `simp [Function.comp]`
-/
theorem mapTree_comp {α β γ : Type} (f : β → γ) (g : α → β) (t : BTree α) :
    BTree.mapTree f (BTree.mapTree g t) = BTree.mapTree (f ∘ g) t := by
  sorry


-- ============================================================================
-- Part 5: Calc Mode (15 points)
-- ============================================================================

/-
Calc mode lets you write proofs as readable chains of equalities (or
inequalities). Each step needs a justification after `:= by`.

  calc LHS
      = step₁ := by ...
    _ = step₂ := by ...
    _ = RHS   := by ...
-/

/- Problem 5.1 (7 points)
Chain hypotheses together using calc.
-/
theorem calc_chain (a b c d : Nat)
    (h₁ : a = b + 3) (h₂ : b = c * 2) (h₃ : c = d + 1) :
    a = 2 * d + 5 := by
  sorry


/- Problem 5.2 (8 points)
Use calc mode together with previously proven list theorems.
Hint: Use `rw [len_app]` for each step that distributes len over app.
-/
theorem len_app_three {α : Type} (xs ys zs : List α) :
    len (app (app xs ys) zs) = len xs + len ys + len zs := by
  sorry


-- ============================================================================
-- BONUS CHALLENGE (25 extra points)
-- ============================================================================

/-!
These problems are designed to be harder than the main assignment. They
require you to chain multiple lemmas together and think carefully about
what intermediate facts you need.

Both bonus problems concern `naiveRev` (our naive list reversal function).
Bonus 1 is a key lemma, and Bonus 2 *depends* on it — if you solve Bonus 1,
you may use it in Bonus 2.
-/

/- BONUS Problem 1 (15 points)
Theorem: Reversing distributes over append — but in *reverse order*.

Hint:
  - Base case: Use `app_nil` (from Problem 3.1).
  - Inductive case: Unfold `naiveRev` and `app` to get a goal about nested `app` calls.
-/
theorem naiveRev_app {α : Type} (xs ys : List α) :
    naiveRev (app xs ys) = app (naiveRev ys) (naiveRev xs) := by
  sorry


/- BONUS Problem 2 (10 points)
Theorem: Reversing a list twice gives back the original list.

Hint: In the inductive step, unfold `naiveRev` and apply `naiveRev_app` (Bonus 1!).
-/
theorem naiveRev_naiveRev {α : Type} (xs : List α) :
    naiveRev (naiveRev xs) = xs := by
  sorry


-- ============================================================================
-- END OF ASSIGNMENT
-- ============================================================================

/-
Grading Rubric:
- Part 1 (20 points): Propositional logic warm-up
- Part 2 (20 points): Natural number induction
- Part 3 (35 points): List induction
- Part 4 (30 points): Binary tree induction
- Part 5 (15 points): Calc mode
- Bonus  (25 points): Reverse involution

Total: 120 points (145 with bonus)
-/
