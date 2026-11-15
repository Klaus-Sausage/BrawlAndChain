# Open Questions and Playtest Backlog

Updated 2026-11-16 (Australia/Melbourne). These are remaining details, not permission to redesign recovered systems. Read [GDD](GDD.md) before asking the owner. Only resolve what the next task needs.

## Cloud/project setup — immediate next work

| Item | Status | Needed outcome |
| --- | --- | --- |
| Codex project/environment organization | OPEN | Identify current app options and selected environment; avoid assuming chats/files sync across machines. |
| Repository and external backup | CURRENT | Private `Klaus-Sausage/BrawlAndChain` created; initial push and fresh clone verified 2026-11-16. Automatic sync is not configured. |
| Local Linux checkout | CURRENT | Working repository at `/home/klaus/Documents/BrawlAndChain`; remote backup verified. Cloud checkout/setup remains separate. |
| Unity tooling/version/template | OPEN | Verify available tools, pick supported release and browser-compatible rendering/build configuration. No editor version selected. |
| First prototype | OPEN | One agreed playable question and minimal acceptance criteria. No detailed numbered roadmap approved. |

## Mechanics needing specification before their implementation

- **Starter kits:** exact Light/Heavy strings, defense, active abilities, number of equal ability slots, cooldowns/resources, move/hit timings, costs and outcomes. Preserve Cleric support plus shield/aggro details rather than assuming a pure healer.
- **Combo execution:** after-input ability trigger timing, buffering, animation overlap, whiff commitment, and cancel rules.
- **Movement/collision:** facing, hit volumes, floor-depth tolerance, movement speed, attack movement, grounded mobility and class-dependent airborne actions.
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
| PT-09 | Adaptive music approach and overall music genre. | Musical payoff remains in slice; style not chosen. |
| PT-10 | Short-rest effects, locations, limits/costs. | No explicit long-rest mechanic. Not automatically a slice gate. |
| PT-11 | Depth and usability of conditional companion AI settings. | Deeper-than-presets direction; exact rule set not fixed. |
| PT-12 | Full boss-chain readability and overall run. | Four-step sequence required; observe actual duration and uncoached understanding. |

These IDs organize future tests; no tests have been run. Numerical criteria or observer sample sizes have not been approved.

## Later production and full-game questions

- Browser/hardware baseline for 60 FPS, load size, memory, supported input, and build hosting.
- 2D sprites versus 3D pipeline, art/animation budget, asset sources/licenses, audio/voice scope, cohesive placeholder style.
- Accessibility: rebinding, visual alternatives to barks, readable hidden-health cues, text/contrast, camera shake/slowdown and gore settings. No final accessibility specification is established.
- Full-game persistence: map/loot survival on mission failure, unlock ownership, duplicate drop filtering, online loot sharing, saves. Slice does not need a proper persistent save.
- Full-game town/buildings, economy, extraction variation, campaign content, and alternate role sets.
- One baseline difficulty is established; exact optional hardcore/permadeath rules are OPEN.
- Future network topology/player join model/authority and slowdown/presentation coordination; SDK/platform approval and console testing later. No networking framework chosen.

## Explicitly deferred, not accidentally forgotten

Amazon and Warlock directions; adaptive party-aware enemy director; town gambling/minigames; full online co-op implementation (slice stretch goal only). Adaptive MONEY SHOT music is **not deferred**.
