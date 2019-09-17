import background

namespace IMOGrandChallenge
namespace Problems
namespace NumberTheory

def IMO_2018_SL_N1 : Type :=
-- note: assuming divisors returns a multiset (list would do as well)
determine $ λ (nk : ℕgt0 × ℕgt0) =>
            match nk with
            | n, k => n ≠ k ∧ ∃ (s : ℕgt0), |divisors (s * n)| = |divisors (s * k)|

def IMO_2018_SL_N2 : Prop :=
-- note: want `≅ (mod n)`, not `% n == 1`
-- note: cumbersome formulation but no conceptual barriers
∀ (n : ℕ), n > 1 →
∀ (table : Fin n → Fin n → ℤ),
∀ i j, table i j % n = 1 →
∀ i, sum (λ j => table i j) % n^2 = n →
∀ j, sum (λ i => table i j) % n^2 = n →
let R := λ i => prod (λ j => table i j);
let C := λ j => prod (λ i => table i j);
sum R % n^4 = sum C % n^4

def IMO_2018_SL_N3 : Prop :=
-- note: currently using that ℕ-division takes floor implicitly
--       (this is unacceptable)
let a : ℕ → ℕ := λ n => 2^n + 2^(n/2);
let s₁ : Set ℕ := λ n => ∃ i j, a n = a i + a j;
infinite s₁ ∧ infinite s₁.complement

def IMO_2018_SL_N4 : Prop :=
-- note: the `toRat` is hideous
∀ (a : ℕgt0 → ℕgt0),
(∃ (k : ℕgt0), ∀ (n : ℕgt0), n ≥ k → (sum (map (λ i => (a i).toRat / a (i + 1)) (List.range n))).isInt) →
∃ (m : ℕgt0), ∀ n, n ≥ m → a n = a (n+1)

def IMO_2018_SL_N5 : Prop :=
-- note: design freedom on this one
--       (was phrased as "suppose ... is it possible that ...")
-- note: the set of 4-tuples is hideous, as is the match
decide (empty $ λ (xyzt : ℕgt0 × ℕgt0 × ℕgt0 × ℕgt0) =>
  match xyzt with
  | (x, y, z, t) => x * y - z * t = x + y ∧ x + y = z + t
                    ∧ perfectSquare (x * y) ∧ perfectSquare (z * t))

def IMO_2018_SL_N6 : Prop :=
-- note: nicer for `f` to return subtype
∀ (f : ℕgt0 → ℕ), (∀ n => f n > 1) →
∀ m n, f (m + n) | f m + f n →
∃ (c : ℕgt0), ∀ n, divides c (f n)

def IMO_2018_SL_N7 : Prop :=
∀ (n : ℕ), n ≥ 2018 →
∀ (a b : Vec ℕ n), pairwiseDistinct a b → a.all (λ x => x ≤ 5 * n) → b.all (λ x => x ≤ 5 * n) →
let seq := (mkVec $ λ i => (b i).toRat / a i);
arithmeticProgress seq → allSame seq


end NumberTheory
end Problems
end IMOGrandChallenge
