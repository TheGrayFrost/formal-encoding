import .util

namespace IMOGrandChallenge

notation `ℕ` := Nat
notation `ℕgt0` := { n : ℕ // n > 0 }

notation `ℤ` := Int
notation `ℤgt0` := { z : ℤ // z > 0 }
notation `ℤge0` := { z : ℤ // z ≥ 0 }

axiom Rat : Type

notation `ℚ` := Rat

namespace Rat

noncomputable instance : HasZero ℚ := ⟨SKIP⟩
noncomputable instance : HasOne ℚ := ⟨SKIP⟩
noncomputable instance : HasAdd ℚ := ⟨SKIP⟩
noncomputable instance : HasMul ℚ := ⟨SKIP⟩
noncomputable instance : HasNeg ℚ := ⟨SKIP⟩
noncomputable instance : HasSub ℚ := ⟨SKIP⟩
noncomputable instance : HasDiv ℚ := ⟨SKIP⟩
noncomputable instance : HasPow ℚ ℚ := ⟨SKIP⟩
noncomputable instance : HasLess ℚ := ⟨SKIP⟩

notation `ℚgt0` := { r : ℚ // r > 0 }
notation `ℚge0` := { r : ℚ // r ≥ 0 }

end Rat

axiom Real : Type
notation `ℝ` := Real

namespace Real

noncomputable instance : HasZero ℝ := ⟨SKIP⟩
noncomputable instance : HasOne ℝ := ⟨SKIP⟩
noncomputable instance : HasAdd ℝ := ⟨SKIP⟩
noncomputable instance : HasMul ℝ := ⟨SKIP⟩
noncomputable instance : HasNeg ℝ := ⟨SKIP⟩
noncomputable instance : HasSub ℝ := ⟨SKIP⟩
noncomputable instance : HasDiv ℝ := ⟨SKIP⟩
noncomputable instance HasPowℝℕ : HasPow ℝ ℕ := ⟨SKIP⟩
noncomputable instance HasPowℝℝ : HasPow ℝ ℝ := ⟨SKIP⟩
noncomputable instance : HasLess ℝ := ⟨SKIP⟩

notation `ℝgt0` := { x : ℝ // x > 0 }
notation `ℝge0` := { x : ℝ // x ≥ 0 }

axiom e  : ℝ
axiom pi : ℝ

noncomputable def sqrt (x : Real) : Real := pow x (1/2)

end Real

end IMOGrandChallenge
