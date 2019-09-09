import .set

namespace IMOGrandChallenge

def determine {X : Type} (s₀ : Set X) : Type :=
{ s : Set X // ∀ x, s.mem x ↔ s₀.mem x }

def compute {X : Type} (target : X) : Type :=
{ x : X // x = target }

end IMOGrandChallenge
