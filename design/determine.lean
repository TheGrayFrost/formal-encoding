/-
Design challenge: how to represent problems that require "determining" a set.
------------------------------------------------------------------------------

Consider the following problem:

"""
[IMO 2019, Problem 1]
Let ℤ be the set of integers. Determine all functions f : ℤ → ℤ such that, for all integers a and b,
f(2a) + 2f(b) = f(f(a+b))
"""
-/

-- Consider the following naive formulation:

notation `ℤ` := Int
def Set (X : Type) : Type := X → Prop
def Set.mem {X : Type} (x : X) (s : Set X) : Prop := s x

def determineNaive {X : Type} (s₀ : Set X) : Type :=
{ s : Set X // ∀ x, s.mem x ↔ s₀.mem x }

def IMO_2019_Problem_1_naive : Type :=
determineNaive $ λ (f : ℤ → ℤ) => ∀ (a b : ℤ), f (2 * a) + 2 * f b = f (f (a + b))

-- However, this formulation admits the following degenerate solution:

example : IMO_2019_Problem_1_naive :=
⟨ λ (f : ℤ → ℤ) => ∀ (a b : ℤ), f (2 * a) + 2 * f b = f (f (a + b)), λ _ => Iff.refl _ ⟩

-- Clearly this answer should not be accepted!
-- We could in principle require the witness to be a decidable set:

def DecidableSet (X : Type) : Type := X → Bool
def DecidableSet.mem {X : Type} (x : X) (s : DecidableSet X) : Bool := s x

def determineDecidable {X : Type} (s₀ : Set X) : Type :=
{ s : DecidableSet X // ∀ (x : X), s.mem x ↔ s₀.mem x }

def IMO_2019_Problem_1_decidable_set : Type :=
determineDecidable $ λ (f : ℤ → ℤ) => ∀ (a b : ℤ), f (2 * a) + 2 * f b = f (f (a + b))

-- Unfortunately, this formulation does not work either, since equality of functions is not decidable.

-- A third attempt is to wrap different types of acceptable solutions into an inductive type:

def List.mem {X : Type} (x₀ : X) : List X → Prop
| []    => false
| x::xs => x = x₀ ∨ List.mem xs

inductive SolutionSet (X : Type)
| finite            : List X → SolutionSet
| countablyInfinite : (Nat → X) → SolutionSet

def SolutionSet.mem {X : Type} (x : X) : SolutionSet X → Prop
| finite xs            => List.mem x xs
| countablyInfinite φ  => Exists $ λ (n : Nat) => x = φ n

def determineSolutionSet (X : Type) (s₀ : Set X) : Type :=
{ s : SolutionSet X // ∀ (x : X), s.mem x ↔ s₀.mem x }

-- Unfortunately, it is not obvious how to make this approach workable for uncountable sets.
-- (It seems reasonable for a solution to be e.g. { x : ℝ // x > 0 ∧ x < 1 })

-- Even worse, @fpvandoorn points out that choice could produce a SolutionSet that could
-- be proved correct from only a proof that the desired set is countable.
-- Similar issues could plague the other approaches as well.

/-
Tentative proposal:

We fear it may be very difficult to formalize a "reasonable" solution
adequately, to simultaneously allow all acceptable solutions and to
disallow all degenerate ones, for all future problems. However, we
expect that for a given witness, there will be broad consensus on
whether or not it constitutes an acceptable solution.

Thus, in the absense of a solution to this design challenge, we
propose that witnesses will be inspected by humans and are required to
be deemed 'reasonable'. Note that proofs will not be inspected by
humans.
-/
