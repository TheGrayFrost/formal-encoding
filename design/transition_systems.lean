/-
Design challenge: how to represent problems about transition systems.
---------------------------------------------------------------------

[IMO 2019, Problem 3] involves a discrete-time transition system that
is non-deterministic, and the question asks whether there exists a
sequence of transitions with a particular property.

[IMO 2019, Problem 5] involves a discrete-time transition system that is
deterministic, and the question asks whether it terminates for all
possible initial states. A follow-up question asks for the expected
number of steps over the uniform distribution on initial states.

There have been many similar questions in the past.

One approach to modeling these is to start with what we see as the
most general version possible, perhaps a Markov Decision Process (MDP).

Is this the right abstraction?  Is it sufficiently general?  What are
the types of S and A?  For some concepts it doesn't matter much, but
for e.g. modeling stochasticity, some types (e.g. uncountable ones)
significantly complicate the representation.

Should we use MDPs but restrict to finite (or countable) types?  Do we
know what kind of uncountable math can appear?  Does trying to encode
problems uniformly with this abstraction introduce other
complications?

TODO (help requested): try to pseudo-formalize several of the most
sophisticated transition-system problems from the past in a unified
way, and uncover the issues with the approach.

TODO (help requested): determine, by examining historical problems and
by speaking with people "in the know", what kinds of reasoning about
uncountable sets might be in scope.

----

There are several conceivable ways of organizing the discrete transition system (DTS) library.

At a high level, we could:

1. Implement the most generic, and "up"-compile simpler systems into it.
2. Implement the most specific, and "down"-compile more complicated systems into it.
3. Implement many separate ones with different functionality.
4. Implement a hierarchy where each extends or contains some below it.

This file sketches what (2) and (3) might look like.
-/

structure DTS (State Action : Type) : Type :=
(step : State -> Action -> State)

namespace DTS

variables {State Action : Type}

def simulate (dts : DTS State Action) (controller : State -> Action) (s₀ : State) : Nat -> State
| 0   => s₀
| n+1 => let s₁ := simulate n;
         dts.step s₁ (controller s₁)

end DTS

-- "LT" stands for "Legal, Terminal"
structure DTSLT (State Action : Type) [HasBeq Action] : Type :=
(legalActions : State -> List Action)
(step         : ∀ (s : State) (a : Action), (legalActions s).elem a -> State)

namespace DTSLT

inductive Result (State : Type)
| ongoing          : State -> Result
| terminal         : State -> Result
| controllerFailed : State -> Result

variables {State Action : Type} [HasBeq Action]

-- `simulate` represents approach (3): re-implement the functions for each variant
def simulate (dtslt : DTSLT State Action) (controller : State -> Action) (s₀ : State) : Nat -> Result State
| 0   => Result.ongoing s₀
| n+1 =>
  match simulate n with
  | Result.ongoing s =>
    let as := (dtslt.legalActions s);
    if as.isEmpty then Result.terminal s else
    let a := controller s;
    if H : as.elem a
    then Result.ongoing $ dtslt.step s a H
    else Result.controllerFailed s

  | result => result

inductive DTSAction (Action : Type) : Type
| ok            : Action -> DTSAction
| noActions     : DTSAction

-- `toDTS` represents approach (2): compile more complicated systems into simpler systems
def toDTS (dtslt : DTSLT State Action) : DTS (Result State) Action := {
  step := λ ds a =>
    match ds with
    | Result.ongoing s =>
      let as := (dtslt.legalActions s);
      if as.isEmpty then Result.terminal s else
      if H : as.elem a
      then Result.ongoing $ dtslt.step s a H
      else Result.controllerFailed s
    | r => r
}

end DTSLT
