# Formal encoding of IMO problems

To remove ambiguity about the scoring rules for the [IMO Grand Challenge](https://IMO-grand-challenge.github.io/), we propose the formal-to-formal (F2F) variant of the IMO.
The AI receives a *formal* representation of the problem (in the [Lean Theorem Prover](https://leanprover.github.io/)), and is required to emit a *formal* (i.e. machine-checkable) proof.

In this repository, we are working on a proposal for encoding IMO problems in Lean that we hope will acheive broad consensus.
This entails:

- formalizing the background mathematics
- developing constructs for representing synthesis problems that neither introduce hints nor major additional difficulty
- formalizing the statements of many past problems

To get involved, join the [IMO-grand-challenge](https://leanprover.zulipchat.com/#narrow/stream/208328-IMO-grand-challenge) stream on [Lean's Zulip channel](https://leanprover.zulipchat.com/).