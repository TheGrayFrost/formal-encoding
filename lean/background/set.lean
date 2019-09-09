namespace IMOGrandChallenge

def Set (X : Type) : Type := X → Prop
def Set.mem {X : Type} (x : X) (s : Set X) : Prop := s x

end IMOGrandChallenge
