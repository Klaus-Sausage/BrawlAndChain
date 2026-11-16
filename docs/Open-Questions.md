# Open Questions and Playtest Backlog

Updated 2026-11-16 (Australia/Melbourne). These are remaining details, not permission to redesign recovered systems. Read [GDD](GDD.md) before asking the owner. Only resolve what the next task needs.

## Project setup status

| Item | Status | Needed outcome |
| --- | --- | --- |
| Codex project/environment organization | CURRENT | Private `Default Cloud` connected to BrawlAndChain and published 2026-11-16; setup clone verified. Cloud read/write subsequently verified with a temporary branch created, checked, and deleted at `10361e8`. Fresh task launched from published configuration still untested. No automatic file sync. |
| Repository and external backup | CURRENT | Private `Klaus-Sausage/BrawlAndChain` created; initial push and fresh clone verified 2026-11-16. Automatic sync is not configured. |
| Local Linux checkout | CURRENT | Setup record identifies `/home/klaus/Documents/BrawlAndChain`; remote backup verified. Keep local/cloud checkouts separate and explicitly synchronized. Inspect actual paths and branches before work. |
| Godot tooling/version/export templates | CURRENT local and cloud pinned checks | Godot 4.7.2 import, four headless harnesses and matching web export pass in this cloud task. Headless Chromium software WebGL 2 exercises all three scenes; new native-window play remains unverified. See Godot-Setup.md and Progress. |
| Browser export validation | CURRENT exchange feel and placeholder rhythm/resolution / OPEN full slice and FPS | Owner accepts the exchange (D-073) and audio lab rhythm/resolution (D-074). Final soundtrack/genre, gamepad, real focus loss and performance remain open. The combo lab passes automated checks and needs owner feel review. See Progress. |
| First prototype | CURRENT 0.0.1 implemented; initial feel check complete | Owner approved the ROM-derived armed Mystara Fighter appearance/cadence and is satisfied with the current 95 px strike range/hit positions. Native/browser checks pass. Further balance tuning is not locked and can be revisited if a later test identifies a problem. See [Visual Preview](Visual-Preview.md) and [Roadmap](Roadmap.md). |

## Current roadmap focus

The initial preview, first hold-guard exchange and placeholder audio rhythm/resolution proofs are accepted (D-071/D-073/D-074). The next [combo experiment](Combo-Experiment.md) uses the owner's knockback finisher choice (D-075); its tuning/feel remain experimental. Class comparison and steps 5–14 are unimplemented. Final kits, slots and wheel rules remain staged gates under the [private roadmap](Roadmap.md).

Before expanding each dependent system, prepare the relevant brief and settle its open decisions. Continue independent authorized work while awaiting an answer. Private full-slice acceptance precedes public art/rights/hosting decisions; neither candidate completion nor publication is claimed here.

## Next design gates

1. Verify and review the separate Light/Heavy knockback combo experiment (D-075), then specify the Barbarian/Thief contrast before adding class variants.
2. Agree four starter-kit and six enemy briefs before implementing their abilities/states. All required boss actions must fit starter sets, including Executioner Axe.
3. Specify two-hero switching/down/revive and minimum AI behavior; then Reacharound confirmation/targeting and paired Circle Jerk feasibility/feedback/anti-spam.
4. Specify boss vulnerability/recovery and mission/session behavior as their proofs become actionable. Deeper companion customization remains current full-game direction; a rich editor is not an explicit slice gate.
5. Name browser/hardware and measurable private acceptance checks before full-run performance review. Public distribution and replacement art follow private gameplay proof.

## Mechanics needing specification before their implementation

- **Starter kits:** exact Light/Heavy strings, defense, active abilities, number of equal ability slots, cooldowns/resources, move/hit timings, costs and outcomes. Preserve Cleric support plus shield/aggro details rather than assuming a pure healer.
- **Combo execution:** after-input ability trigger timing, buffering, animation overlap, whiff commitment, and cancel rules.
- **Movement/collision:** movement speed, attack movement, facing/cancel rules beyond this experiment, hit volumes, floor-depth tolerance, grounded mobility and class-dependent airborne actions. The prototype's attack facing lock and active movement are provisional.
- **Hero switching:** button/key, availability during attacks/downed state, selection order, target/input handover, camera behavior, AI continuation.
- **Reacharound:** exact ability navigation, confirmation/release, cancellation, target ordering, empty/invalid targets, selecting cooldown abilities, state changes while open.
- **Circle Jerk:** final wheel organization, action/target validity during selection, contextual default among simultaneous opportunities, request ownership/lifetime, queuing/rejection feedback, human request presentation.
- **AI arbitration:** precedence between routine behavior, current revive/locked action, healing urgency, and expiring execution opportunities. Full predictive feasibility is an ideal, not a known working feature.
- **Enemy/armor/status rules:** actual models, durations, immunity/CC treatment, guard break, health/armor reduction, execution eligibility and damage. Visible armor break is established; formula is not.
- **Goblin King:** actual guard-break positioning, prayer debuff, stun gate, execution condition, telegraphs, failed-chain recovery, phases, extra enemies, and completion behavior.
- **Slice roster:** six enemy archetype identities/kits and authored set pieces. Count established, membership not yet selected.
- **Session flow:** launch/start, control teaching, defeat/revive, reset/restart, victory, side-room function, extraction scope within hub-free slice.

## Explicit PLAYTEST REQUIRED items from history

| ID | Experiment | Established boundary |
| --- | --- | --- |
| PT-01 | Basic movement and combat feel, Thief speed versus Barbarian weight. | Input responsiveness universal; cadence/impact differ. |
| PT-02 | Hit reaction/stagger/stun-lock by enemy size/type. | Readable reactions; not every light hit must interrupt every enemy. |
| PT-03 | Wheel slowdown magnitude/behavior, eventual solo versus online. | Keep tactical action moving; no full tactical planning pause. |
| PT-04 | Contextual wheel selection, combo surfacing, live validity and default action. | Own actions vs squad requests remain separate. |
| PT-05 | Request acceptance/queue/rejection and AI feasibility. | Requests override routine behavior only when feasible; no forced human action. |
| PT-06 | Anti-spam solution. | Anti-spam required; no chosen mechanism. |
| PT-07 | Friendly status side effects. | No ordinary teammate chip damage. |
| PT-08 | MONEY SHOT frequency and eligibility, camera/time restoration. | Selective significance; Goblin King showcase required. |
| PT-09 | Adaptive music approach, genre and browser slowdown synchronization. | Stream lab passes objective checks and owner rhythm/resolution listening (D-074). Final genre/composition, production strategy and full MONEY SHOT integration remain open. |
| PT-10 | Short-rest effects, locations, limits/costs. | No explicit long-rest mechanic. Not automatically a slice gate. |
| PT-11 | Depth and usability of conditional companion AI settings. | Deeper-than-presets direction; exact rule set not fixed. |
| PT-12 | Full boss-chain readability and overall run. | Four-step sequence required; observe actual duration and uncoached understanding. |

These IDs organize focused tests. The accepted 0.0.1 movement/one-strike review covers only that preview, not completion of these broader experiments. Record new evidence in Progress; numerical criteria or observer sample sizes have not been approved.

## Later production and full-game questions

- Browser/hardware baseline for 60 FPS, load size, memory, supported input, and build hosting.
- 2D fantasy sprites are the current direction; final art/animation pipeline, budget, replacement asset sources/licenses and audio/voice scope remain open. Current private visual-study framing is owner-approved; production resolution and final art remain open.
- Accessibility: rebinding, visual alternatives to barks, readable hidden-health cues, text/contrast, camera shake/slowdown and gore settings. No final accessibility specification is established.
- Full-game persistence: map/loot survival on mission failure, unlock ownership, duplicate drop filtering, online loot sharing, saves. Slice does not need a proper persistent save.
- Full-game town/buildings, economy, extraction variation, campaign content, and alternate role sets.
- One baseline difficulty is established; exact optional hardcore/permadeath rules are OPEN.
- Future network topology/player join model/authority and slowdown/presentation coordination; SDK/platform approval and console testing later. Godot console middleware/porting provider, costs, target coverage, and compatibility with the chosen engine release remain OPEN. No networking framework chosen.

## Explicitly deferred, not accidentally forgotten

Amazon and Warlock directions; adaptive party-aware enemy director; town gambling/minigames; full online co-op implementation (slice stretch goal only). Adaptive MONEY SHOT music is **not deferred**.

## Completed private 0.0.1 playtest — 2026-11-16

The owner confirmed satisfaction with the 95 px strike range/hit positions and requested no further tuning. The overlay remains available for future diagnosis. Lane tolerance is 18 px. The armed look, walk cadence, and original sword speed are approved. Continue the separately scoped reciprocal exchange and [Roadmap](Roadmap.md); do not repeat this completed feel check without new evidence.
