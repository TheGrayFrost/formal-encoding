import .util

def Vec (X : Type) (n : Nat) : Type := { xs : List X // xs.length == n }

namespace Vec

variables {X Y : Type} {n n₁ n₂ : Nat}

def empty : Vec X 0 :=
⟨ [], rfl ⟩

def take (k : Fin n) (xs : Vec X n) : Vec X k.val :=
⟨ xs.val.take k.val, SORRY ⟩

def drop (k : Fin n) (xs : Vec X n) : Vec X (n - k.val) :=
⟨ xs.val.drop k.val, SORRY ⟩

def append (xs₁ : Vec X n₁) (xs₂ : Vec X n₂) : Vec X (n₁ + n₂) :=
⟨ xs₁.val ++ xs₂.val, SORRY ⟩

def range (n : Nat) : Vec (Fin n) n :=
⟨ List.rangeFin n, SORRY ⟩

def map (f : X -> Y) (xs : Vec X n) : Vec Y n :=
⟨ List.map f xs.val, SORRY ⟩

def sum [HasZero X] [HasAdd X] (xs : Vec X n) : X :=
List.sum xs.val

def cycle (k : Fin n) (xs : Vec X n) : Vec X n :=
cast SORRY ((xs.drop k).append (xs.take k))

def cycles (xs : Vec X n) : Vec (Vec X n) n :=
(range n).map (λ (k : Fin n) => cycle k xs)

def cyclicSum [HasZero Y] [HasAdd Y] (xs : Vec X n) (f : Vec X n → Y) : Y :=
(xs.cycles.map f).sum

def subvecs (k : Fin n) (xs : Vec X n) : Vec (Vec X k.val) (n.choose k) :=
cast SORRY (xs.val.sublists k.val)

def replicate (n : Nat) (x : X) : Vec X n :=
⟨ List.replicate n x, SORRY ⟩

end Vec
