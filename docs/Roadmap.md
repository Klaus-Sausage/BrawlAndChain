# Brawl & Chain — private full-slice delivery roadmap

Updated 2026-11-16 (Australia/Melbourne). Current planning decision: D-072 in [Decisions](Decisions.md).

## Goal, status, and working rules

Build the complete gameplay scope of [GDD §17](GDD.md#17-required-public-vertical-slice--010) as a **private full-slice candidate first**. Use rough, readable stand-ins to prove systems; public art replacement, rights, hosting, and release follow separately. The first public release remains 0.1.0. This roadmap does not claim the private candidate is built or tested.

The owner approved this delivery approach and authorized implementation. Open creative choices remain **staged design gates**: prepare a concrete brief, settle only the decisions the next experiment needs, implement that experiment, and record actual review results. Authorization to work through the roadmap does not settle unspecified kits, controls, wheel rules, or balance. Ask focused design questions at those gates; continue independent authorized work while an answer is pending.

Keep each 0.0.x build focused on one primary proof. Preserve the accepted 0.0.1 movement/strike baseline and its 95 px range; the owner completed its feel review under D-071. Reopen it only when later evidence reveals a problem. Technical tests establish behavior, while owner playtests establish feel. Revise failed proofs before expanding dependent systems. No dates, delivery estimates, future build numbers, tester sample sizes, or unobserved playtest outcomes are assigned here.

## Fourteen implementation steps

Current evidence (2026-11-16): steps 1 and 3 are technically complete for this foundation; step 2's placeholder audio rhythm/resolution proof is accepted (D-074). Step 4's first hold-guard exchange is accepted (D-073); its knockback Light/Heavy experiment passes automated checks and awaits owner feel review (D-075), while Thief comparison remains unimplemented. Steps 5–14 have not started. See [Progress](Progress.md) for evidence and limitations.

### 1. Reconcile the baseline and define the private slice contract

- Reconcile remote Git with newer local notes before development; preserve the accepted roadmap and D-071 instead of repeating the completed hit-range test. Inspect branch/status and explicitly synchronize separate PC/cloud checkouts.
- Record the contract: browser playable, approximately 5–15 minutes, one player plus three AI, all four heroes switchable, starter sets only, six enemy archetypes before Goblin King, mostly linear mission plus two side rooms, both wheels, and the full boss/MONEY SHOT payoff including adaptive music.
- Record pinned engine/templates, repeatable native/browser commands, build provenance, and a named hardware/browser baseline for the 60 FPS target. A headless run is not a graphical, browser, audio, or performance test.
- Keep town, persistent saving, alternate sets, online implementation and console ports outside this delivery. Distinguish the accepted preview/export from new experiments.

**Gate:** Source and notes agree; the private checklist and verification commands are recorded. Unknown test environments are identified rather than claimed as verified.

### 2. Prove browser audio and slowdown feasibility early

- Build a separate small MONEY SHOT lab with a rough musical loop and transition/sting, separate from authoritative combat.
- Compare normal playback, slowdown, scheduled musical transition and restoration in native and browser builds. Check browser audio unlock, repeated triggers, restart, interruption and focus changes.
- Record the playback/scheduling approach and observed limitations before the finished boss depends on it. Musical style and final composition remain open.

**Gate:** A browser-observed example demonstrates a coherent musical payoff during slowdown and reliable restoration, or a concrete alternative is agreed. Run this alongside early combat; integrate the full feature at step 13.

**Lab result:** Owner listening confirmed steady rhythm during slowdown and smooth crescendo resolution into the loop (D-074). Preserve the placeholder feasibility approach; final music selection and boss integration remain future work.

### 3. Establish the minimum authoritative combat foundation

- Separate human/AI intent, authoritative action acceptance/contact/outcomes, and presentation. Introduce only the actor/action state and observable outcomes required by the preview and next exchange.
- Keep animation contact timing usable without granting visuals ownership of damage/status rules. Preserve editable tuning and replaceable visual children.
- Regression-check accepted movement, strike timing/facing, fresh-press input, range/lane checks and F2 diagnosis. Avoid speculative networking frameworks or a general-purpose combat platform.

**Gate:** The accepted preview still behaves correctly; human input, future AI and presentation can use one authoritative action path without duplicating hit rules.

### 4. Prove a reciprocal combat exchange in focused increments

- Start with internal health, readable hit response and defeat; then add one telegraphed goblin melee action and the selected defense; then defeat/reset flow. Keep each playable proof small.
- Use [Combat Experiment](Combat-Experiment.md) to settle the immediate defense choice and provisional controls before dependent implementation. Preserve hidden default health and no damage numbers.
- Define the contact/recovery and collision rules the exchange needs. Add short Light/Heavy branching, commitment and whiff consequences after a focused brief; exact strings, buffering and cancellation remain open.
- Compare Barbarian weight and Thief responsiveness with rough stand-ins when their actions are specified. The current sword Fighter is not a final Barbarian kit.

**Gate:** Owner review finds the exchange readable and responsive, with understandable hit/defeat outcomes and reliable repetition. Record actual feedback before extending the model.

**First-exchange result:** Accepted by the owner (“feels great,” D-073). The next separate [combo experiment](Combo-Experiment.md) follows the owner's knockback choice (D-075); its new feel and later class comparison need their own review.

### 5. Agree the four starter-kit and six enemy briefs

- Specify Barbarian, Thief, Cleric and Wizard starter actions, defense, equal active-slot count, ability limiter and targeting. Settle required combo/input/commitment rules and controller/keyboard interaction before their implementation.
- Preserve Cleric support plus shield/aggro protection. Ensure all four boss actions, including the Executioner Axe, work with starter sets; temporary sword artwork does not settle that choice.
- Select six enemy archetypes and tactical jobs before closing the required status/guard model. Brief tells, vulnerabilities, protection/support relationships and encounter purpose; GDD examples are not a selected roster.
- Keep art rough and distinguishable; use stand-ins for missing poses/effects instead of making polished production a dependency.

**Gate:** Owner-reviewed briefs separate established rules, experimental tuning and unresolved questions. Each hero/enemy has a clear job without alternate-set production.

### 6. Implement only the abilities and states those briefs require

- Add shared ability/target validity, cooldown/resource, guard/resistance/status, defense and execution capabilities needed by the selected kits/enemies.
- Use the same validity/outcome logic for direct input, both wheels and AI. Recheck validity when selection and execution occur at different times.
- Make armor/guard breaks and key statuses legible through bodies, effects and sound; expose tactical detail during selection. Do not implement every example status or a default health-bar HUD.
- Settle relevant immunity/CC, expiry, interruption and allied-status behavior at this gate. Ordinary teammate chip damage remains excluded; adverse allied statuses require a focused test.

**Gate:** Required abilities work alone and in prepared-state combinations; invalid, unavailable, interrupted and expired actions have defined results without duplicate outcomes.

### 7. Prove a two-hero party before scaling to four

- Start with Barbarian and Wizard using reviewed briefs. One is directly controlled; the other uses minimal role behavior through the shared intent interface.
- Settle switching/input handover, targeting, camera, attack-lock and downed-selection rules; the departing hero returns to AI. Prevent simultaneous player/AI ownership.
- Define and test downed/revive, whole-party defeat and reset semantics at this scale. Use simple extensible AI rules; a rich conditional customization editor is not an explicit slice gate.

**Gate:** Both heroes contribute; switching is understandable; AI continuation and downed/revive/reset behavior work before wheel/roster expansion.

### 8. Prove Reacharound, then paired Circle Jerk

- First settle/build held Reacharound for the controlled hero's own ability and valid target. Resolve confirmation/release, cancellation, target order, cooldown feedback and live invalidation through its interaction brief.
- Then use the pair to prove contextual Circle Jerk requests with acceptance/queue/rejection and interruption feedback. Share eligibility with actual execution.
- Settle slowdown, anti-spam, request lifetime and minimum AI arbitration. Preserve attack-biased contextual discovery and urgent-healing direction without inventing a universal priority table or full predictive AI.
- Test controller/keyboard navigation, missing/vanished targets, expiry, and audio-first feedback with useful visual alternatives. Neither wheel puppeteers another human.

**Gate:** Players distinguish own actions from requests, use a contextual opportunity, and understand unavailable/rejected actions while combat continues. Simplified implementations are allowed.

### 9. Complete the four-hero solo party

- Add Thief and Cleric from approved briefs, retaining distinct cadence/roles. Expand switching, basic AI, targeting and revival to one player plus three companions.
- Check spacing, floor-depth navigation, camera, threat readability and request arbitration with all four. Keep identities fixed and the party free of duplicates.
- Implement only the AI customization depth needed by the slice; deeper between-mission behavior editing remains separately scoped.

**Gate:** All four starters are playable and useful; the three companions, switching and requests work coherently under encounter pressure.

### 10. Graybox the complete Goblin King interaction

- Build Thief backstab → guard break; Cleric prayer → resistance down; Wizard spell → stun; Barbarian Executioner Axe → execution.
- Agree tells, positioning, vulnerability/expiry gates, interrupted-chain recovery and completion before implementing them. Use rough distinguishable visuals and barks.
- Teach through visible changes and contextual opportunities; verify both wheels contribute. Emit the authoritative successful-execution outcome needed by MONEY SHOT.

**Gate:** Starter kits can perform the full chain; owner review finds it understandable and recoverable after failure. Prove this before content expansion.

### 11. Implement the six selected pre-boss archetypes

- Build the six briefs into readable enemies; implement differing reactions, defenses, ranged/support pressure and counterplay where those briefs require them.
- Compose fodder and authored cooperative battalions with meaningful priority targets. Ordinary combat handles fodder; coordinated actions reward tactical play.
- Recheck the party/wheels under pressure. Avoid an adaptive director, extra archetype production or a difficulty ladder.

**Gate:** All six archetypes have distinct encounter jobs and understandable tells/counters with four heroes present.

### 12. Assemble the short mission and session flow

- Build a mostly linear route with two side rooms, pre-boss encounters and Goblin King. Settle side-room purpose, gates and pacing before content expansion.
- Connect launch/start, control teaching, revival/defeat, reset/restart, victory and minimal completion/extraction. No hub or persistent save is required.
- Measure an actual complete run against the intended 5–15 minutes. Improve learning/pacing from observed play rather than padding content.

**Gate:** A complete private run works from start through victory/restart, with meaningful side rooms and recorded duration.

### 13. Integrate the full MONEY SHOT payoff

- Connect successful Goblin King execution to selective zoom, slowdown, rough readable gore and the adaptive crescendo/sting resolving into the track.
- Apply the early lab's tested scheduling/restoration approach. Settle input, offscreen threats, eligibility and relevant content/motion options.
- Verify repeated runs, interruption, defeat/restart and completion restore camera, time and audio in native/browser builds. Presentation never decides whether execution happened.

**Gate:** The full payoff is coherent and special, occurs for the correct outcome, and leaves session/audio state sound. Adaptive music is required in this private proof too.

### 14. Verify the private full-slice candidate, then scope public delivery

- Exercise step 1's complete contract, controller/keyboard, browser audio unlock, loading, focus/input loss, defeat/restart and repeated completion.
- Measure frame pacing against the named 60 FPS baseline; record loading/memory observations and hardware/browser identity. Separate measured checks, owner feel, other tester feedback, known defects and untested cases.
- Observe uncoached learning where private testing is authorized. Review hidden-health readability, visual/audio alternatives, motion/gore settings and control/help needs. Numerical acceptance thresholds/sample sizes need an explicit brief.
- Deliver a labelled **private full-slice candidate** for owner review. Public 0.1.0 follows separately: inventory/replace or clear assets, agree presentation/accessibility, choose hosting/distribution, revalidate and authorize publication in a later task.

**Gate:** Required gameplay exists, agreed private checks pass, and unresolved issues are recorded. This does not authorize public hosting or establish asset rights.

## Evidence and decision records

Update [Progress](Progress.md) after actual work/verification and [Decisions](Decisions.md) after agreed changes. Each experiment records source/build identity, one primary question, scope, native/browser checks, owner/other tester notes, limitations and next action. Keep remaining choices in [Open Questions](Open-Questions.md); preserve archived sources unchanged.

This sequence supersedes D-070's broader proposed ordering while retaining its slice content and game-feel-first workflow. Future creative gates are deliberate work items, not missing permission to continue independent foundation work.
