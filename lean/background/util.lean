axiom SKIP {X : Type} : X
axiom SORRY {P : Prop} : P

namespace Nat

def fact : Nat -> Nat
| 0 => 1
| 1 => 1
| n+1 => (n+1) * fact n

def choose (n : Nat) (k : Fin n) : Nat :=
n.fact / (k.val.fact * (n-k.val).fact)

end Nat

namespace Fin

def cadd {n : Nat} {k₁ k₂ : Fin n} : Fin n :=
⟨(k₁.val + k₂.val) % n, SORRY⟩

notation `⊕` := cadd

end Fin

namespace List

def rangeFinAux (n : Nat) : ∀ (k : Nat), k ≤ n → List (Fin n) → List (Fin n)
| 0,   H, ns => ns
| k+1, H, ns => let H₁ : k < n := H;
                let H₂ : k ≤ n := SORRY;
                rangeFinAux k H₂ (⟨k, H₁⟩ :: ns)

def rangeFin (n : Nat) : List (Fin n) :=
rangeFinAux n n (Nat.leRefl n) []

def range1 (n : Nat) : List Nat := List.tail (List.range $ n+1)

def sublists {X : Type} : Nat -> List X -> List (List X)
| 0,   xs      => [[]]
| k+1, []      => []
| k+1, (x::xs) => (sublists k xs).map (λ ys => x :: ys) ++ sublists (k+1) xs

def sum {X : Type} [HasZero X] [HasAdd X] (xs : List X) : X := xs.foldl HasAdd.add 0
def prod {X : Type} [HasOne X] [HasMul X] (xs : List X) : X := xs.foldl HasMul.mul 1
def max {X : Type} (lt : X -> X -> Bool) (x₀ : X) (xs : List X) := xs.foldl (λ xₘ x => if lt xₘ x then x else xₘ) x₀

end List
