-- PROOF101 Week 2: Dependent Type Theory Programming Assignment
-- Name: _________________
-- Date: _________________

/-
Instructions:
- Replace each `sorry` with your implementation
- Make sure all definitions type-check
- Test your code with the provided #eval statements
- Do not modify the type signatures
- Problems progress from lambda calculus to dependent types
-/

-- ============================================================================
-- Part 1: Lambda Calculus Fundamentals (15 points)
-- ============================================================================

/- Problem 1.1 (5 points)
Define the identity function using BOTH explicit lambda syntax and parameter syntax.
-/

-- Style 1: Explicit lambda (fun x => ...)
def id₁ : Nat → Nat :=
  sorry

-- Style 2: Parameter syntax
def id₂ (n : Nat) : Nat :=
  sorry

-- Test cases
-- #eval id₁ 42  -- Should output: 42
-- #eval id₂ 17  -- Should output: 17


/- Problem 1.2 (5 points)
Define a function that applies a function twice (as in lambda calculus).
This demonstrates higher-order functions.
-/

def applyTwice {α : Type} (f : α → α) (x : α) : α :=
  sorry

-- Test cases
-- #eval applyTwice (fun n => n + 1) 5      -- Should output: 7
-- #eval applyTwice (fun n => n * 2) 3      -- Should output: 12


/- Problem 1.3 (5 points)
Implement function composition: compose g f = g ∘ f
Remember: (g ∘ f)(x) = g(f(x))
-/

def compose {α β γ : Type} (g : β → γ) (f : α → β) : α → γ :=
  sorry

-- Test cases
def addOne (n : Nat) : Nat := n + 1
def double (n : Nat) : Nat := n * 2

-- #eval (compose double addOne) 5    -- Should output: 12 (i.e., (5+1)*2)
-- #eval (compose addOne double) 5    -- Should output: 11 (i.e., (5*2)+1)


-- ============================================================================
-- Part 2: Currying and Combinators (20 points)
-- ============================================================================

/- Problem 2.1 (7 points)
Implement `curry` that converts a function taking a pair into a curried function.
This demonstrates the relationship between products and function types.
-/

def curry {α β γ : Type} (f : (α × β) → γ) : α → β → γ :=
  sorry

-- Test cases
def pairAdd (p : Nat × Nat) : Nat := p.1 + p.2
-- #eval pairAdd (3, 4)           -- Should output: 7
-- #eval curry pairAdd 3 4        -- Should output: 7


/- Problem 2.2 (7 points)
Implement `uncurry` that converts a curried function back to one taking a pair.
-/

def uncurry {α β γ : Type} (f : α → β → γ) : (α × β) → γ :=
  sorry

-- Test cases
def add (a b : Nat) : Nat := a + b
-- #eval add 3 4                  -- Should output: 7
-- #eval uncurry add (3, 4)       -- Should output: 7


/- Problem 2.3 (6 points)
Implement the K combinator: returns a function that ignores its second argument.
This is like the Church encoding of "true".
-/

def constFun {α β : Type} (a : α) : β → α :=
  sorry

-- Test cases
-- #eval constFun 42 "hello"         -- Should output: 42
-- #eval constFun true 100           -- Should output: true


-- ============================================================================
-- Part 3: Pattern Matching and Recursion (20 points)
-- ============================================================================

/- Problem 3.1 (5 points)
Define `applyN` that applies a function n times.
Use pattern matching on the natural number.
-/

def applyN {α : Type} (n : Nat) (f : α → α) (x : α) : α :=
  sorry

-- Test cases
-- #eval applyN 0 (fun n => n + 1) 5   -- Should output: 5
-- #eval applyN 3 (fun n => n + 1) 5   -- Should output: 8
-- #eval applyN 4 (fun n => n * 2) 1   -- Should output: 16


/- Problem 3.2 (5 points)
Implement multiplication using only addition and recursion.
Hint: m * n = m + m + ... + m (n times)
-/

def mult (m : Nat) : Nat → Nat :=
  sorry

-- Test cases
-- #eval mult 3 4   -- Should output: 12
-- #eval mult 5 0   -- Should output: 0
-- #eval mult 0 5   -- Should output: 0


/- Problem 3.3 (5 points)
Implement exponentiation using recursion.
Hint: m^n = m * m * ... * m (n times)
-/

def power (m : Nat) : Nat → Nat :=
  sorry

-- Test cases
-- #eval power 2 10  -- Should output: 1024
-- #eval power 3 3   -- Should output: 27
-- #eval power 5 0   -- Should output: 1


/- Problem 3.4 (5 points)
Implement `isEven` using pattern matching (not modulo).
Hint: Use mutual recursion or match on n-2.
-/

def isEven : Nat → Bool :=
  sorry

-- Test cases
-- #eval isEven 4   -- Should output: true
-- #eval isEven 7   -- Should output: false
-- #eval isEven 0   -- Should output: true


-- ============================================================================
-- Part 4: List Operations (25 points)
-- ============================================================================

/- Problem 4.1 (6 points)
Implement `listMap` that applies a function to every element.
-/

def listMap {α β : Type} (f : α → β) : List α → List β :=
  sorry

-- Test cases
-- #eval listMap (fun n => n + 1) [1, 2, 3]        -- Should output: [2, 3, 4]
-- #eval listMap (fun n => n * 2) [1, 2, 3]        -- Should output: [2, 4, 6]
-- #eval listMap (fun s => s ++ "!") ["hi", "bye"] -- Should output: ["hi!", "bye!"]


/- Problem 4.2 (6 points)
Implement `listFilter` that keeps only elements satisfying a predicate.
-/

def listFilter {α : Type} (pred : α → Bool) : List α → List α :=
  sorry

-- Test cases
-- #eval listFilter (fun n => n > 2) [1, 2, 3, 4, 5]     -- Should output: [3, 4, 5]
-- #eval listFilter isEven [1, 2, 3, 4, 5, 6]            -- Should output: [2, 4, 6]


/- Problem 4.3 (7 points)
Implement `listFoldl` that reduces a list from the left.
foldl f z [x₁, x₂, ..., xₙ] = f (... (f (f z x₁) x₂) ...) xₙ
-/

def listFoldl {α β : Type} (f : β → α → β) (init : β) : List α → β :=
  sorry

-- Test cases
-- #eval listFoldl (· + ·) 0 [1, 2, 3, 4]       -- Should output: 10
-- #eval listFoldl (· * ·) 1 [1, 2, 3, 4]       -- Should output: 24
-- #eval listFoldl (· - ·) 10 [1, 2, 3]         -- Should output: 4 (((10-1)-2)-3)


/- Problem 4.4 (6 points)
Implement `listReverse` using fold (not direct recursion).
Hint: Use listFoldl to build the reversed list.
-/

def listReverse {α : Type} : List α → List α :=
  sorry

-- Test cases
-- #eval listReverse [1, 2, 3, 4]    -- Should output: [4, 3, 2, 1]
-- #eval listReverse ["a", "b", "c"] -- Should output: ["c", "b", "a"]


-- ============================================================================
-- Part 5: Polymorphic Functions (20 points)
-- ============================================================================

/- Problem 5.1 (7 points)
Implement `replicate` that creates a list with n copies of a value.
-/

def replicate {α : Type} (n : Nat) (x : α) : List α :=
  sorry

-- Test cases
-- #eval replicate 3 5          -- Should output: [5, 5, 5]
-- #eval replicate 2 "hello"    -- Should output: ["hello", "hello"]
-- #eval replicate 0 true       -- Should output: []


/- Problem 5.2 (7 points)
Implement `listTake` that returns the first n elements of a list.
-/

def listTake {α : Type} : Nat → List α → List α :=
  sorry

-- Test cases
-- #eval listTake 3 [1, 2, 3, 4, 5]  -- Should output: [1, 2, 3]
-- #eval listTake 10 [1, 2, 3]       -- Should output: [1, 2, 3]
-- #eval listTake 0 [1, 2, 3]        -- Should output: []


/- Problem 5.3 (6 points)
Implement `listDrop` that skips the first n elements of a list.
-/

def listDrop {α : Type} : Nat → List α → List α :=
  sorry

-- Test cases
-- #eval listDrop 2 [1, 2, 3, 4, 5]  -- Should output: [3, 4, 5]
-- #eval listDrop 10 [1, 2, 3]       -- Should output: []
-- #eval listDrop 0 [1, 2, 3]        -- Should output: [1, 2, 3]


-- ============================================================================
-- Part 6: Option Type and Safe Operations (15 points)
-- ============================================================================

/- Problem 6.1 (5 points)
Implement `safehead` that returns the first element if it exists.
Use the Option type to handle empty lists safely.
-/

def safehead {α : Type} : List α → Option α :=
  sorry

-- Test cases
-- #eval safehead [1, 2, 3]             -- Should output: some 1
-- #eval safehead ([] : List Nat)       -- Should output: none
-- #eval safehead ["a", "b"]            -- Should output: some "a"


/- Problem 6.2 (5 points)
Implement `safeNth` that returns the nth element if it exists.
-/

def safeNth {α : Type} : List α → Nat → Option α :=
  sorry

-- Test cases
-- #eval safeNth [1, 2, 3, 4] 2         -- Should output: some 3
-- #eval safeNth [1, 2, 3] 10           -- Should output: none
-- #eval safeNth ([] : List Nat) 0      -- Should output: none


/- Problem 6.3 (5 points)
Implement `mapOption` that applies a function to the value inside an Option.
-/

def mapOption {α β : Type} (f : α → β) : Option α → Option β :=
  sorry

-- Test cases
-- #eval mapOption (· + 1) (some 5)         -- Should output: some 6
-- #eval mapOption (· + 1) (none : Option Nat)  -- Should output: none


-- ============================================================================
-- Part 7: Advanced Applications (25 points)
-- ============================================================================

/- Problem 7.1 (8 points)
Implement `makeList` that takes n and a function f : Nat → α,
and creates [f 0, f 1, ..., f (n-1)].
This demonstrates dependent types where the function determines the list content.
-/

def makeList {α : Type} (n : Nat) (f : Nat → α) : List α :=
  sorry

-- Test cases
-- #eval makeList 5 (fun i => i)         -- Should output: [0, 1, 2, 3, 4]
-- #eval makeList 4 (fun i => i * i)     -- Should output: [0, 1, 4, 9]
-- #eval makeList 3 (fun i => i * 2 + 1) -- Should output: [1, 3, 5]


/- Problem 7.2 (8 points)
Implement `listZipWith` that combines two lists element-wise using a function.
-/

def listZipWith {α β γ : Type} (f : α → β → γ) : List α → List β → List γ :=
  sorry

-- Test cases
-- #eval listZipWith (· + ·) [1, 2, 3] [4, 5, 6]        -- Should output: [5, 7, 9]
-- #eval listZipWith (· * ·) [1, 2, 3] [4, 5, 6, 7]     -- Should output: [4, 10, 18]


/- Problem 7.3 (9 points)
Implement `fibonacci` that computes the nth Fibonacci number.
Use pattern matching for the base cases.
-/

def fibonacci : Nat → Nat :=
  sorry

-- Test cases
-- #eval fibonacci 0    -- Should output: 0
-- #eval fibonacci 1    -- Should output: 1
-- #eval fibonacci 6    -- Should output: 8
-- #eval fibonacci 10   -- Should output: 55


-- ============================================================================
-- BONUS CHALLENGE (30 extra points)
-- ============================================================================

/- BONUS Problem 1 (10 points)
Implement the Y combinator (fixed point combinator) for natural numbers.
This allows defining recursive functions without explicit recursion.
Note: In Lean, we need to use a workaround since true Y combinator doesn't terminate.
You'll need to use a fuel-based approach with a local recursive helper function.
-/

def fixNat (f : (Nat → Nat) → (Nat → Nat)) : Nat → Nat :=
  sorry

-- Test: Define factorial using fixNat
def fact : Nat → Nat :=
  fixNat (fun fac n => if n == 0 then 1 else n * fac (n-1))

-- #eval fact 5  -- Should output: 120
-- #eval fact 0  -- Should output: 1
-- #eval fact 7  -- Should output: 5040


/- BONUS Problem 2 (10 points)
Implement `listSpan` that splits a list at the first element that doesn't
satisfy a predicate. Return a tuple (prefix, suffix).
Hint: Use tuple accessors .1 and .2 instead of pattern matching to avoid syntax issues.
-/

def listSpan {α : Type} (pred : α → Bool) : List α → (List α × List α) :=
  sorry

-- Test cases
-- #eval listSpan (· < 5) [1, 2, 3, 6, 4, 7]  -- Should output: ([1, 2, 3], [6, 4, 7])
-- #eval listSpan (· % 2 == 0) [2, 4, 6, 1, 8]  -- Should output: ([2, 4, 6], [1, 8])


/- BONUS Problem 3 (10 points)
Implement type-level natural number addition at the type level.
This demonstrates dependent types where computation happens in types.
-/

-- Define a type-level natural number
inductive TNat : Type where
  | zero : TNat
  | succ : TNat → TNat
  deriving Repr

-- Implement addition at the type level
def tnatAdd : TNat → TNat → TNat :=
  sorry

-- Test (these are compile-time computations!)
-- #eval tnatAdd TNat.zero TNat.zero                    -- Should output: TNat.zero
-- #eval tnatAdd (TNat.succ TNat.zero) (TNat.succ TNat.zero)  -- Should output: TNat.succ (TNat.succ TNat.zero)
-- #eval tnatAdd (TNat.succ (TNat.succ TNat.zero)) (TNat.succ TNat.zero)  -- TNat.succ (TNat.succ (TNat.succ TNat.zero))


-- ============================================================================
-- END OF ASSIGNMENT
-- ============================================================================

/-
Grading Rubric:
- Part 1 (15 points): Lambda calculus fundamentals
- Part 2 (20 points): Currying and combinators
- Part 3 (20 points): Pattern matching and recursion
- Part 4 (25 points): List operations
- Part 5 (20 points): Polymorphic functions
- Part 6 (15 points): Option type and safe operations
- Part 7 (25 points): Advanced applications
- Bonus (30 points): Extra challenge problems

Total: 140 points (170 with bonus)
-/
