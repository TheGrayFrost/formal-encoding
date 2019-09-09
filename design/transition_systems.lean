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
-/
