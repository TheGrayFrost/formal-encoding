import background

namespace IMOGrandChallenge
namespace Problems
namespace Combinatorics

def IMO_2018_SL_C1 : Prop :=
-- note: current formulation builds in the symmetry that WLOG `S₁.card = m`
--       better to follow the question's wording more closely?
∀ (n : ℕ), n ≥ 3 →
  ∃ (S : FiniteSet ℕgt0), S.card = 2 * n ∧
    ∀ (m : ℕ), m ≥ 2 → m ≤ n →
      ∃ (S₁ S₂ : FiniteSet ℕgt0), partitions S [S₁, S₂] ∧ S₁.sum = S₂.sum ∧ S₁.card = m


def IMO_2018_SL_C2 : Type :=
-- original problem: two-player discrete-time finite-state game.
--                   goal is to find maximal `K` s.t. `P(K)` no matter how P2 plays
-- design: this is a new kind of discrete transition system, that is now multi-agent
-- will reassess design after seeing a few more combinatorics problems
SKIP

def IMO_2018_SL_C3 : Prop :=
-- original problem: one-player discrete-time finite-state game that depends on `n`.
--                   goal is to prove P1 cannot win in less than P(n) moves
-- design: this is a standard discrete transition system
SKIP

def IMO_2018_SL_C4 : Prop :=
-- note: put triangle in standard library
-- note: generalization of 'distinct' must be in standard library
-- note: decide must be constructive, i.e. not use excluded middle
-- note: this is technically a SAT problem
let Triangle : ℕ → Type := ∀ (n : ℕgt0) (k : Fin n), Fin k → ℤ;
let antiPascal : ∀ (n : ℕ), Set (Triangle n) :=
  λ (n : ℕ) (tri : Triangle) => ∀ (k : Fin n), k < n-1 → ∀ (i : Fin k), tri k i = abs (tri (k+1) i - tri (k+1) (i+1)),
let distinctEntries : ∀ (n : ℕ), Set (Triangle n) :=
  λ (tri : Triangle) => distinct (λ (z : ℤ) => ∃ (k : Fin n) (i : Fin k), z = tri k i);
∀ (n : ℕgt0),
  decide (empty (antiPascal n ∩ distinctEntries n))

def IMO_2018_SL_C5 :
-- note: the `(k choose 2)` is not stated in the original problem
--       (seems like acceptable hint, especially since it is basically the definition of `choose`)
-- note: `legal` is not explicit in the question
-- note: this one doesn't seem to require a transition system (nor did the last one)
∀ (k : ℕgt0),
let nPlayers : ℕgt0 := 2 * k;
let nGames : ℕgt0 := k.choose 2;
let Schedule : Type :=
  Fin nGames → Fin nPlayers × Fin nPlayers;
let legal : Schedule → Prop := λ (s : Schedule) =>
  ∀ i, (s i).fst ≠ (s i).snd;
let gamesPlayed : Schedule → Fin nPlayers → List (Fin nGames) := λ s p =>
  (List.rangeFin nGames).filterMap (λ game => (s game).fst == p || (s game).snd == p);
let cost : Schedule → ℕ := λ s =>
  ((List.rangeFin nPlayers).map (λ p => gamesPlayed.head - gamesPlayed.last)).sum;
∀ (s : Schedule),
compute $ min legal cost

def IMO_2018_SL_C6 :
-- note: would be nice to define recursive functions with `let`
-- note: might want to use generic DTS formulation for this
-- note: times₂ builds in that legalMove₁ & legalMove₂ are exclusive
∀ (a b : ℕgt0), a ≠ b →
let State : Type := List ℕ;
let s₀ : State := [];
let legalMove₁ : State → State → Prop := λ (s₁ s₂ : State) =>
  ∃ (i j : Fin Sk.length), i ≠ j ∧ s₁.get i = s₁.get j ∧ s₂ = (s₁.updateAt i (λ x => x + a)).updateAt j (λ x => x + b);
let legalMove₂ : State → State → Prop := λ (s₁ s₂ : State) =>
  (¬ ∃ (i j : Fin Sk.length), i ≠ j ∧ s₁.get i = s₁.get j) ∧ s₂ = 0::0::s₁;
let legalMove : State → State → Prop := λ (s₁ s₂ : State) => legalMove₁ s₁ s₂ ∨ legalMove₂ s₁ s₂;

let Trajectory : Type := ℕ → State;
let possible : Trajectory → Prop := λ t => t 0 = s₀ ∧ ∀ i, legalMove (t i) (t (i+1));
let times₂ : Trajectory → Set ℕ := λ t n => legalMove₂ (t n) (t $ n+1);
∀ (t : Trajectory), possible t → finite (times₂ t)


def IMO_2018_SL_C7 : Prop :=
-- TODO: this one involves basic Geo, return to it later
SORRY


end Combinatorics
end Problems
end IMOGrandChallenge
