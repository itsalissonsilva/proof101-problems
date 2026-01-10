-- PROOF101 Week 3: Functional Programming Programming Assignment
-- Name: _________________
-- Date: _________________

/-
Instructions:
- Replace each `sorry` with your implementation
- Make sure all definitions type-check
- Test your code by uncommenting the #eval statements
- Do not modify the type signatures
- Problems progress from foundational concepts to advanced applications
-/

-- ============================================================================
-- Part 1: Foundational Functions (15 points)
-- ============================================================================

/- Problem 1.1 (5 points)
Implement `twice` - a function that takes a function and returns a new
function that applies it twice.
-/

def twice {α : Type} (f : α → α) : α → α :=
  sorry

-- Test cases
-- #eval (twice (· + 1)) 5          -- Should output: 7
-- #eval (twice (· * 3)) 2          -- Should output: 18


/- Problem 1.2 (5 points)
Implement function composition: (f ∘ g)(x) = f(g(x))
-/

def myCompose {α β γ : Type} (f : β → γ) (g : α → β) : α → γ :=
  sorry

-- Test cases
def square (n : Nat) : Nat := n * n
def increment (n : Nat) : Nat := n + 1

-- #eval (myCompose square increment) 4     -- Should output: 25 ((4+1)^2)
-- #eval (myCompose increment square) 4     -- Should output: 17 (4^2 + 1)


/- Problem 1.3 (5 points)
Implement `const` that returns a function that always returns the same value.
-/

def const {α β : Type} (a : α) : β → α :=
  sorry

-- Test cases
-- #eval (const 42) "hello"         -- Should output: 42
-- #eval (const true) 100           -- Should output: true


-- ============================================================================
-- Part 2: Structures and Product Types (20 points)
-- ============================================================================

/- Problem 2.1 (10 points)
Define a `Point` structure with x and y coordinates (Float).
Implement: origin, addPoints, scalePoint
-/

structure Point where
  x : Float
  y : Float
  deriving Repr

def origin : Point :=
  sorry

def addPoints (p q : Point) : Point :=
  sorry

def scalePoint (k : Float) (p : Point) : Point :=
  sorry

-- Test cases
-- #eval origin                                      -- Should output: {x := 0.0, y := 0.0}
-- #eval addPoints {x := 1.0, y := 2.0} {x := 3.0, y := 4.0}  -- {x := 4.0, y := 6.0}
-- #eval scalePoint 2.0 {x := 3.0, y := 4.0}        -- {x := 6.0, y := 8.0}


/- Problem 2.2 (10 points)
Define a `Color` type with Red, Green, Blue.
Implement `mixColors` with these rules:
  * Red + Blue = Green, Blue + Red = Green
  * Red + Green = Blue, Green + Red = Blue
  * Blue + Green = Red, Green + Blue = Red
  * Same + Same = Same
-/

inductive Color where
  | Red : Color
  | Green : Color
  | Blue : Color
  deriving Repr, BEq

def mixColors : Color → Color → Color :=
  sorry

-- Test cases
-- #eval mixColors Color.Red Color.Blue             -- Should output: Color.Green
-- #eval mixColors Color.Red Color.Red              -- Should output: Color.Red


-- ============================================================================
-- Part 3: Basic List Operations (20 points)
-- ============================================================================

/- Problem 3.1 (5 points)
Implement `zipWith` that combines two lists using a binary function.
-/

def zipWith {α β γ : Type} (f : α → β → γ) : List α → List β → List γ :=
  sorry

-- Test cases
-- #eval zipWith (· + ·) [1, 2, 3] [4, 5, 6]        -- Should output: [5, 7, 9]
-- #eval zipWith (· * ·) [2, 3, 4] [5, 6, 7]        -- Should output: [10, 18, 28]


/- Problem 3.2 (5 points)
Implement `foldl` (left fold) that reduces a list from the left.
-/

def foldl {α β : Type} (f : β → α → β) (init : β) : List α → β :=
  sorry

-- Test cases
-- #eval foldl (· - ·) 10 [1, 2, 3]                 -- Should output: 4 (((10-1)-2)-3)
-- #eval foldl (fun acc x => acc ++ [x]) [] [1, 2, 3]  -- Should output: [1, 2, 3]


/- Problem 3.3 (5 points)
Implement `dropWhile` that removes elements from the front while they
satisfy a predicate.
-/

def dropWhile {α : Type} (p : α → Bool) : List α → List α :=
  sorry

-- Test cases
-- #eval dropWhile (· < 5) [1, 2, 3, 6, 4, 7]      -- Should output: [6, 4, 7]
-- #eval dropWhile (· % 2 == 0) [2, 4, 6, 1, 8]    -- Should output: [1, 8]


/- Problem 3.4 (5 points)
Implement `partition` that splits a list into (matching, non-matching).
-/

def partition {α : Type} (p : α → Bool) : List α → (List α × List α) :=
  sorry

-- Test cases
-- #eval partition (· % 2 == 0) [1, 2, 3, 4, 5, 6]
-- -- Should output: ([2, 4, 6], [1, 3, 5])


-- ============================================================================
-- Part 4: Advanced Function Combinators (15 points)
-- ============================================================================

/- Problem 4.1 (5 points)
Implement `myFlip` that reverses the order of arguments.
Note: Named `myFlip` to avoid conflict with standard library.
-/

def myFlip {α β γ : Type} (f : α → β → γ) : β → α → γ :=
  sorry

-- Test cases
def sub (a b : Nat) : Int := (a : Int) - (b : Int)
-- #eval sub 10 3              -- Should output: 7
-- #eval myFlip sub 10 3       -- Should output: -7


/- Problem 4.2 (5 points)
Implement `curry` that converts a function taking a pair into a curried function.
-/

def curry {α β γ : Type} (f : (α × β) → γ) : α → β → γ :=
  sorry

-- Test cases
def pairAdd (p : Nat × Nat) : Nat := p.1 + p.2
-- #eval pairAdd (3, 4)           -- Should output: 7
-- #eval curry pairAdd 3 4        -- Should output: 7


/- Problem 4.3 (5 points)
Implement `uncurry` that converts a curried function into one taking a pair.
-/

def uncurry {α β γ : Type} (f : α → β → γ) : (α × β) → γ :=
  sorry

-- Test cases
def add (a b : Nat) : Nat := a + b
-- #eval add 3 4                  -- Should output: 7
-- #eval uncurry add (3, 4)       -- Should output: 7


-- ============================================================================
-- Part 5: Binary Trees - Basics (20 points)
-- ============================================================================

/- Problem 5.1 (5 points)
Define BTree and implement `size` that counts total nodes.
-/

inductive BTree (α : Type) : Type where
  | empty : BTree α
  | node : α → BTree α → BTree α → BTree α
  deriving Repr

def size {α : Type} : BTree α → Nat :=
  sorry

-- Test cases
def tree1 : BTree Nat := BTree.node 1 BTree.empty BTree.empty
def tree2 : BTree Nat := BTree.node 2 tree1 tree1
-- #eval size (BTree.empty : BTree Nat)             -- Should output: 0
-- #eval size tree1                                 -- Should output: 1
-- #eval size tree2                                 -- Should output: 3


/- Problem 5.2 (5 points)
Implement `mirror` that swaps left and right subtrees.
-/

def mirror {α : Type} : BTree α → BTree α :=
  sorry

-- Test cases
-- #eval mirror (BTree.empty : BTree Nat)           -- Should output: BTree.empty
-- #eval mirror tree1                               -- Should output: node 1 empty empty


/- Problem 5.3 (5 points)
Implement `height` (longest path from root to leaf).
Hint: Use Nat.max to find the maximum of two natural numbers.
-/

def height {α : Type} : BTree α → Nat :=
  sorry

-- Test cases
-- #eval height (BTree.empty : BTree Nat)           -- Should output: 0
-- #eval height tree1                               -- Should output: 1
-- #eval height tree2                               -- Should output: 2


/- Problem 5.4 (5 points)
Implement `mapTree` that applies a function to every value.
-/

def mapTree {α β : Type} (f : α → β) : BTree α → BTree β :=
  sorry

-- Test cases
-- #eval mapTree (· + 1) tree1                      -- Should output: node 2 empty empty
-- #eval mapTree (· * 2) tree2                      -- Check visually


-- ============================================================================
-- Part 6: Implementing from Pseudocode (15 points)
-- These functions were pseudocoded in the slides - implement them fully!
-- ============================================================================

/- Problem 6.1 (5 points)
Implement `interleave` that merges two lists by alternating elements.
See slides for pseudocode structure.

Hint: Base cases handle empty lists, recursive case takes one from each.
-/

def interleave {α : Type} : List α → List α → List α :=
  sorry

-- Test cases
-- #eval interleave [1,3,5] [2,4,6]        -- Should output: [1,2,3,4,5,6]
-- #eval interleave [1,2] [10,20,30,40]    -- Should output: [1,10,2,20,30,40]


/- Problem 6.2 (5 points)
Implement `splitAt` that splits a list at a given index.
See slides for pseudocode structure.

Hint: Use pattern matching on the index and list, build left part recursively.
-/

def splitAt {α : Type} : Nat → List α → (List α × List α) :=
  sorry

-- Test cases
-- #eval splitAt 2 [1,2,3,4,5]             -- Should output: ([1,2], [3,4,5])
-- #eval splitAt 0 [1,2,3]                 -- Should output: ([], [1,2,3])
-- #eval splitAt 10 [1,2,3]                -- Should output: ([1,2,3], [])


/- Problem 6.3 (5 points)
Implement `groupConsecutive` that groups consecutive equal elements.
See slides for pseudocode structure.

Hint: When elements are equal, recursively group the rest and add current to first group.
-/

def groupConsecutive {α : Type} [BEq α] : List α → List (List α) :=
  sorry

-- Test cases
-- #eval groupConsecutive [1,1,2,2,2,3,3]
-- -- Should output: [[1,1], [2,2,2], [3,3]]

-- #eval groupConsecutive [1,2,3]
-- -- Should output: [[1], [2], [3]]


-- ============================================================================
-- Part 7: Variations on Slide Concepts (15 points)
-- These are related to functions in slides but with variations!
-- ============================================================================

/- Problem 7.1 (5 points)
Implement `takeWhile` that keeps elements from the front while they
satisfy a predicate (opposite of dropWhile).

Hint: Similar to dropWhile, but collect elements instead of skipping them.
-/

def takeWhile {α : Type} (p : α → Bool) : List α → List α :=
  sorry

-- Test cases
-- #eval takeWhile (· < 5) [1, 2, 3, 6, 4, 7]      -- Should output: [1, 2, 3]
-- #eval takeWhile (· % 2 == 0) [2, 4, 6, 1, 8]    -- Should output: [2, 4, 6]


/- Problem 7.2 (5 points)
Implement `span` that splits a list at the first element where the predicate
becomes false. Returns (elements satisfying predicate, rest of list).

This is like takeWhile and dropWhile combined in one pass!
-/

def span {α : Type} (p : α → Bool) : List α → (List α × List α) :=
  sorry

-- Test cases
-- #eval span (· < 5) [1, 2, 3, 6, 4, 7]
-- -- Should output: ([1, 2, 3], [6, 4, 7])

-- #eval span (· % 2 == 0) [2, 4, 6, 1, 8]
-- -- Should output: ([2, 4, 6], [1, 8])


/- Problem 7.3 (5 points)
Implement `elemIndex` that returns the index of the first occurrence
of a specific element (not a predicate, but equality check).

Hint: Similar to findIndex but checks for equality with a specific value.
You'll need a helper function with an accumulator for the index.
-/

def elemIndex {α : Type} [BEq α] (x : α) : List α → Option Nat :=
  sorry

-- Test cases
-- #eval elemIndex 6 [1, 3, 6, 2, 8]       -- Should output: some 2
-- #eval elemIndex 10 [1, 3, 6, 2, 8]      -- Should output: none
-- #eval elemIndex 2 [1, 2, 3, 2, 5]       -- Should output: some 1 (first occurrence)


-- ============================================================================
-- Part 8: Binary Trees - Advanced (25 points)
-- ============================================================================

/- Problem 8.1 (5 points)
Implement `countLeaves` that counts leaf nodes (nodes with no children).
A leaf is a node where both left and right children are empty.
-/

def countLeaves {α : Type} : BTree α → Nat :=
  sorry

-- Test cases
def leaf : BTree Nat := BTree.node 1 BTree.empty BTree.empty
def branch : BTree Nat := BTree.node 2 leaf leaf
-- #eval countLeaves (BTree.empty : BTree Nat)  -- Should output: 0
-- #eval countLeaves leaf                       -- Should output: 1
-- #eval countLeaves branch                     -- Should output: 2


/- Problem 8.2 (5 points)
Implement `contains` that checks if a value exists in the tree.
-/

def contains {α : Type} [BEq α] (x : α) : BTree α → Bool :=
  sorry

-- Test cases
-- #eval contains 1 leaf                        -- Should output: true
-- #eval contains 5 leaf                        -- Should output: false
-- #eval contains 2 branch                      -- Should output: true


/- Problem 8.3 (5 points)
Implement `sumTree` that adds up all values in a tree of numbers.

Hint: Similar structure to size, but accumulate values instead of counting.
-/

def sumTree : BTree Nat → Nat :=
  sorry

-- Test cases
-- #eval sumTree (BTree.empty : BTree Nat)      -- Should output: 0
-- #eval sumTree leaf                           -- Should output: 1
-- #eval sumTree branch                         -- Should output: 4 (1 + 2 + 1)
-- #eval sumTree tree2                          -- Should output: 4 (1 + 2 + 1)


/- Problem 8.4 (5 points)
Implement `collectIf` that collects all values in the tree that satisfy a predicate.
Return the values as a list (any traversal order is fine).

Hint: Recursively traverse the tree, checking the predicate at each node and
collecting matching values from left and right subtrees.
-/

def collectIf {α : Type} (p : α → Bool) : BTree α → List α :=
  sorry

-- Test cases
def tree3 : BTree Nat :=
  BTree.node 5
    (BTree.node 3 (BTree.node 1 BTree.empty BTree.empty)
                  (BTree.node 4 BTree.empty BTree.empty))
    (BTree.node 8 (BTree.node 6 BTree.empty BTree.empty)
                  (BTree.node 9 BTree.empty BTree.empty))

-- #eval collectIf (· > 5) tree3               -- Should output: [8, 6, 9] (or similar)
-- #eval collectIf (· % 2 == 0) tree3          -- Should output: [4, 8, 6] (or similar)
-- #eval collectIf (· > 10) tree3              -- Should output: []


/- Problem 8.5 (5 points)
Implement `depthOf` that finds the depth of the first occurrence of a value.
The depth of the root is 0, its children are at depth 1, etc.
Return `none` if the value is not found.

Hint: Use a helper function that tracks the current depth as you traverse.
-/

def depthOf {α : Type} [BEq α] (x : α) : BTree α → Option Nat :=
  sorry

-- Test cases
-- #eval depthOf 5 tree3                        -- Should output: some 0 (root)
-- #eval depthOf 3 tree3                        -- Should output: some 1
-- #eval depthOf 1 tree3                        -- Should output: some 2
-- #eval depthOf 10 tree3                       -- Should output: none
-- #eval depthOf 5 (BTree.empty : BTree Nat)    -- Should output: none


-- ============================================================================
-- BONUS CHALLENGE (45 extra points)
-- ============================================================================

/- BONUS Problem 1 (10 points)
Implement `preorder` traversal of a binary tree (root, left, right).

This is different from inorder which we showed in slides (left, root, right).
-/

def preorder {α : Type} : BTree α → List α :=
  sorry

-- Test cases
-- #eval preorder (BTree.empty : BTree Nat)         -- Should output: []
-- #eval preorder tree1                             -- Should output: [1]
-- #eval preorder tree2                             -- Should output: [2, 1, 1]


/- BONUS Problem 2 (10 points)
Implement `postorder` traversal of a binary tree (left, right, root).

This is the third major traversal order (we've seen inorder and preorder).
-/

def postorder {α : Type} : BTree α → List α :=
  sorry

-- Test cases
-- #eval postorder (BTree.empty : BTree Nat)        -- Should output: []
-- #eval postorder tree1                            -- Should output: [1]
-- #eval postorder tree2                            -- Should output: [1, 1, 2]


/- BONUS Problem 3 (15 points)
Implement `pathsToLeaves` that returns all paths from root to leaves.
Each path is a list of values from root to a leaf.

Example:
      2
     / \
    1   1
Returns: [[2, 1], [2, 1]]

Hint: Accumulate the current path as you traverse, and when you hit a leaf,
return the complete path.
-/

def pathsToLeaves {α : Type} : BTree α → List (List α) :=
  sorry

-- Test cases
-- #eval pathsToLeaves (BTree.empty : BTree Nat)    -- Should output: []
-- #eval pathsToLeaves leaf                         -- Should output: [[1]]
-- #eval pathsToLeaves branch                       -- Should output: [[2, 1], [2, 1]]


/- BONUS Problem 4 (10 points)
Implement `runLengthEncode` that compresses consecutive equal elements
into (element, count) pairs.

Example: [1,1,2,2,2,3] becomes [(1,2), (2,3), (3,1)]

This is similar to groupConsecutive but produces counts instead of sublists.
-/

def runLengthEncode {α : Type} [BEq α] : List α → List (α × Nat) :=
  sorry

-- Test cases
-- #eval runLengthEncode [1,1,2,2,2,3,3]
-- -- Should output: [(1, 2), (2, 3), (3, 2)]

-- #eval runLengthEncode [1,2,3]
-- -- Should output: [(1, 1), (2, 1), (3, 1)]

-- #eval runLengthEncode ([] : List Nat)
-- -- Should output: []


-- ============================================================================
-- END OF ASSIGNMENT
-- ============================================================================

/-
Grading Rubric:
- Part 1 (15 points): Foundational functions
- Part 2 (20 points): Structures and product types
- Part 3 (20 points): Basic list operations
- Part 4 (15 points): Advanced function combinators
- Part 5 (20 points): Binary trees - basics
- Part 6 (15 points): Implementing from pseudocode (slides)
- Part 7 (15 points): Variations on slide concepts
- Part 8 (25 points): Binary trees - advanced
- Bonus (45 points): Extra challenge problems

Total: 145 points (190 with bonus)
-/
