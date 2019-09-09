import background

namespace IMOGrandChallenge
namespace Problems
namespace Algebra

def IMO_2018_SL_A1 : Type :=
  -- note: subtype for `Q_{>0}`; want better notation, e.g. `ℚgt0`
  -- note: doesn't typecheck, need support for operations on subtypes, e.g. `(x : ℚgt0) * (y : ℚgt0)`
  determine $ λ (f : ℚgt0 → ℚgt0) => ∀ (x y : ℚgt0), f (x^2 * (f y)^2) = (f x)^2 * (f y)

def IMO_2018_SL_A2 : Type :=
  -- note: using `Vec _ n` for a sequence `a₁, ..., aₙ`
  -- note: switched to 0-indexing, which arguably adds confusion
  -- note: assuming `⊕` is defined for cyclic addition on `Fin n`
  -- note: (still missing ∃ syntax support)
  -- note: type-class inference may struggle with `HasOne (Fin n)`, since it needs to track `n ≥ 3`
  determine $ λ (n : ℕ) => n ≥ 3 ∧ ∃ (a : Vec ℝ n),
                ∀ (i : Fin n), a[i] * a[i ⊕ 1] + 1 = a[i ⊕ 2]

def IMO_2018_SL_A3 : Prop :=
  -- note: made `FiniteSet` a type instead of a condition
  -- note: assuming elaborator can handle `<FiniteSet T> ⊆ <Set T>`
  -- note: using `F ≠ G` for distinct from, which wouldn't work if they were `Set`s
  -- note: still missing `⊆` support
  -- note: let-binding the conditions
  ∀ (S : Set ℤgt0),
    let C1 : Prop :=
      ∃ (F G : FiniteSet ℤgt0), F ⊆ S ∧ G ⊆ S ∧ F ≠ G ∧ F.sum (λ x => 1/x) = G.sum (λ x => 1/x);
    let C2 : Prop :=
      ∃ (r : ℚgt0), r < 1 ∧ ∀ (F : FiniteSet ℤgt0), F ⊆ S ∧ F.sum (λ x => 1/x) ≠ r;
    C1 ∨ C2

def IMO_2018_SL_A4 : Type :=
  -- note: let-binded the predicate
  -- note: `range1 k` means `[1, ... , k]`
  -- note: the quantifier structure is subtle; we never introduce a sequence `a`
  -- note: `max : ∀ {X Y : Type} [TotalOrder Y], Set X → (X → Y) → Y`
  -- note: `compute {X : Type} (target : X) : Type := { x : X // x = target }`
  --       is just the 1-element version of `determine`.
  --       (Recall that under the current proposal, the witness must be human-checked)
  let goodSequence : Set (ℕ → ℝ) :=
    λ (a : ℕ → ℝ),
      a 0 = 1 ∧ a 1 = 1
      ∧ ∀ (n : ℕ), n ≥ 2 → ∃ (k : ℕ), 1 ≤ k ∧ k ≤ n ∧ a n = avg (map (λ i => a (n - i)) (range1 k));
    compute $ max goodSequence (λ a => a 2018 - a 2017)

def IMO_2018_SL_A5 : Type :=
  -- note: straightforward, though curry-syntax is a real downer
  determine $ λ (f : ℝgt0 → ℝ) => ∀ (x y : ℝgt0), (x + 1/x) * f y = f (x * y) + f (y / x)

def IMO_2018_SL_A6 : Prop :=
  -- note: question says `m` and `n` are `ℤ` and `≥ 2`
  -- note: assumes a formulation of multivariate polynomials, that take `Vec`s
  -- note: `x ∈ range m` is problematic, and would require tricky coercions.
  ∀ (m n : ℕ), m ≥ 2 → n ≥ 2 →
    ∀ (f : Poly ℝ n),
      ∀ (xs : Vec ℝ n), xs.all (λ x => x ∈ range m) →
        totalDegree f ≥ n

def IMO_2018_SL_A7 : Prop :=
  -- note: `ℝ≥` likely problematic
  -- note: awkward to bind cyclicSum with the same name
  compute $ max (λ (cs : Vec ℝ≥ 4) => cs.sum = 100)
                (λ (cs : Vec ℝ≥ 4) => cs.cyclicSum (λ cs => ((cs.get 0) / ((cs.get 1) + 7)) ^ (1/3)))

end Algebra
end Problems
end IMOGrandChallenge
