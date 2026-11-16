# Brawl & Chain — proposed roadmap to 0.1.0

Updated 2026-11-16 (Australia/Melbourne).

## Status and purpose

This roadmap was created at the owner's request. It proposes an order for reaching the already-defined 0.1.0 public slice; it does not add or remove game requirements. Slice requirements remain in [GDD §17](GDD.md#17-required-public-vertical-slice--010). The order, intermediate prototypes, and acceptance details are **PROPOSED** and should be re-scoped after each playtest. No dates or delivery estimates are set.

Keep each private 0.0.x build focused on one primary question. Finish and learn from a build before expanding it. Use the local Godot build for feature iteration and owner review; once locally approved, export and verify the browser version before treating that work as complete. Test risky browser-specific features early, especially adaptive audio during slowdown. If the game feel is weak, iterate instead of advancing the roadmap.

## Roadmap at a glance

| Order | Milestone | Main proof |
| --- | --- | --- |
| 0 | Finish current 0.0.1 combat-feel test | The chosen strike range covers intended positions and misses remain understandable. |
| 1 | Establish the basic combat loop | Movement, attacks, hit outcomes, and enemy reactions feel readable and responsive. |
| 2 | Prove the four-hero party | All four starter heroes have distinct, usable roles; switching and companion AI work in solo play. |
| 3 | Prove the two squad wheels | Personal ability selection and contextual teammate requests are understandable and reliable. |
| 4 | Prove enemy variety and the Goblin King chain | Six pre-boss enemy archetypes support readable encounters; the four-step boss interaction is understood and works. |
| 5 | Assemble the short mission | The solo-plus-AI experience forms a coherent, learnable 5–15 minute run with side rooms. |
| 6 | Deliver the MONEY SHOT payoff | The boss finish combines camera, slowdown, gore, and an adaptive musical crescendo. |
| 7 | Prepare the 0.1.0 public slice | The whole browser-playable slice meets agreed release checks and is ready to share. |

These are roadmap stages, not approved 0.0.x version numbers. Assign version numbers when the next individual prototype is scoped.

## Stages

### 0. Finish 0.0.1 — complete

**Question:** Does the current movement and single strike hit where the player expects?

- Play the current 95 px strike range at the positions that previously missed, using F2 to read FRONT, RANGE, and LANE.
- Adjust only from observed results; preserve the approved animation speed and visual framing unless playtesting gives a reason to revisit them.
- Record the result and any remaining feel issue in [Progress](Progress.md) and [Visual Preview](Visual-Preview.md).

**Result (2026-11-16):** The owner confirmed satisfaction with the current hit positions/range and requested no further tuning. The 0.0.1 feel check is complete for this private preview; it does not lock production combat balance.

### 1. Establish the basic combat loop

**Question:** Can the player read and control a small exchange with an enemy?

- Build from the approved movement and hit feel; explore attack strings, commitment, defensive options, and hit reactions only as needed to prove the exchange.
- Compare the intended weight/cadence difference between Barbarian and Thief when their actions are specified.
- Define a small enemy response and test which enemy sizes/types should react to ordinary hits.
- Resolve attack, status, and collision rules only when the prototype needs them; these details are still open in [Open Questions](Open-Questions.md).

**Exit:** A short exchange is responsive, readable, and satisfying in owner playtests. Scope the next test from what the exchange reveals.

### 2. Prove the four-hero party

**Question:** Does controlling one hero while the other three act as companions make the four-class roster work?

- Specify starter-set actions for Barbarian, Thief, Cleric, and Wizard before implementing the full roster. Preserve the Cleric's support and shield/aggro possibilities; exact kits are open.
- Prototype switching control between heroes, with the former controlled hero returning to AI as established in the GDD.
- Develop only the companion behaviors required to test the encounter; record unresolved priority and feasibility rules rather than assuming them.
- Keep hero identity fixed and role variation within complete gear sets; the slice needs starter sets only.

**Exit:** All four heroes can take part in a solo-plus-AI encounter, switching is understandable, and each starter role contributes. The detailed AI rules remain separately testable.

### 3. Prove the two squad wheels

**Question:** Can players choose their own abilities and ask companions for contextual actions without losing combat flow?

- Prototype Reacharound for the active hero's own ability and target selection.
- Prototype Circle Jerk for contextual squad requests, target selection, and clear acceptance, queue, or rejection feedback.
- Test slowdown, anti-spam, live action validity, and companion feasibility as separate playtest questions. Do not turn one proposed interaction flow into a locked rule without owner review.
- Run an early browser test of audio and slowdown synchronization before depending on those effects for the final showcase.

**Exit:** Both systems are represented, their purposes are distinct, and solo play remains understandable. Simplified implementations are allowed by the slice scope.

### 4. Prove enemy variety and the Goblin King chain

**Question:** Do enemy behaviors create readable tactical opportunities, including the required team sequence?

- Choose the six pre-boss enemy archetype identities and kits with the owner; this is an open content decision.
- Implement and tune enemy armor, guard, resistance, stun, and hit reactions only to the level supported by the chosen encounters.
- Build the required Goblin King interaction in order: Thief backstab breaks guard → Cleric prayer lowers resistance → Wizard spell stuns → Barbarian Executioner Axe finishes.
- Test whether players can understand the opportunities and recover from an interrupted or failed sequence. Exact gates and recovery are open.

**Exit:** All six archetypes have a gameplay purpose in encounters, and the boss sequence is both executable and legible in playtests.

### 5. Assemble the short mission

**Question:** Does the set of combat and squad systems sustain a coherent short run?

- Build a mostly linear mission with a couple of side rooms. A hub may be omitted.
- Connect launch, control teaching, encounters, side-room choices, defeat/revive, restart, victory, and extraction into a testable session; define only the flow needed for the slice.
- Measure actual run length against the intended 5–15 minutes and adjust encounter pacing from playtest evidence.
- Keep persistent saving, online co-op implementation, campaign branching, and town progression outside the slice unless the owner changes scope.

**Exit:** A first-time player can make progress through a complete solo-plus-AI run, and the run fits the intended duration closely enough for owner review.

### 6. Deliver the MONEY SHOT payoff

**Question:** Does a significant finish feel special and does its music resolve cleanly?

- Implement the selective zoom/push-in, slowdown, and gore presentation for the Goblin King execution.
- Deliver the required adaptive musical crescendo/sting that resolves into the current track. A rough musical example is acceptable for the slice.
- Test effect eligibility, frequency, and restoration of normal camera/time/music behavior; do not make the effect automatic for every kill.
- Validate timing in the browser as well as locally. Music is an explicit slice requirement, not a later optional enhancement.

**Exit:** The full boss payoff plays once at the right outcome and returns cleanly to normal gameplay and music in native and browser builds.

### 7. Prepare the 0.1.0 public slice

**Question:** Can the complete experience be shared reliably with external testers?

- Integrate all four playable heroes with starter sets, six enemy archetypes before the boss, both squad wheels, the short mission, and the complete Goblin King/MONEY SHOT showcase.
- Agree concrete release checks and a browser/hardware baseline. Measure the 60 FPS target rather than treating it as already verified.
- Verify browser launch, input, audio, performance, loading, restart, and full-run completion on the agreed browser/device set.
- Replace temporary Mystara assets or verify the rights and distribution terms for every asset before public sharing. The current private preview's reuse permission is unverified.
- Review accessibility, controls/help, and hosting/distribution decisions that matter to the chosen public test. A proper save and online co-op are not slice requirements.
- Record final test results and known issues, then package and announce 0.1.0 only after owner review.

**Exit:** The GDD's complete 0.1.0 scope is present, release checks pass on the chosen baseline, and public asset/distribution questions are resolved.

## Open gates to revisit during planning

- Any new core-combat feel issue that emerges during later playtests.
- Starter kits, attack/combo execution, movement/collision rules, enemy armor/status rules, and hero-switch details.
- Six enemy identities/kits and the Goblin King sequence gates/recovery.
- Reacharound and Circle Jerk interaction details, companion AI arbitration, slowdown, and anti-spam.
- Mission teaching/session flow and the specific job of side rooms.
- Music style/implementation and browser timing; public assets and reuse rights.
- Browser/device performance baseline, release checks, accessibility needs, hosting, and distribution.

The full open-question list and recorded playtest items are maintained in [Open Questions](Open-Questions.md). This roadmap should be revised when evidence or owner decisions change the sequence.
