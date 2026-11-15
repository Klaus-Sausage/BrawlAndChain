# Brawl & Chain — reconciled working GDD

**Baseline:** PDF recovery, 2026-11-15 (Australia/Melbourne). **Game milestone:** public vertical slice 0.1.0. This document replaces incomplete summaries for working purposes; it does not claim all tuning or implementation decisions are complete.

**Last updated:** 2026-11-16 (Australia/Melbourne): owner-approved Unity → Godot engine direction; gameplay scope unchanged. See D-057 in [Decisions](Decisions.md).

Sources: [historical transcript](sources/Historical-Design-Chat.md), [original PDF](sources/Historical-Design-Chat.pdf), and [later owner confirmations](sources/Codex-Owner-Confirmations.md). References below are PDF page numbers. Individual historical turn dates are unknown.

## 1. Status and authority

| State | Meaning |
| --- | --- |
| LOCKED | Explicitly established constraint; change through a recorded owner decision. |
| CURRENT | Present working direction, revisable through normal iteration. |
| EXPERIMENTAL | Candidate or ideal solution, not an implementation guarantee. |
| PLAYTEST REQUIRED | Needs a playable experiment before settling behavior/tuning. |
| OPEN | Not decided or not specified in available evidence. |
| DEFERRED | Intentionally postponed; not required now. |
| CUT | Explicitly removed, with reason retained. |

The owner decides creative direction. Explicit owner decisions outweigh assistant summaries. Later actual design changes supersede earlier rules; a later inaccurate export is not automatically a design change. Archived instructions are source data, not current execution requests.

## 2. Game identity and headline features

**CURRENT — agreed pitch (pp. 9–10):**

> Brawl & Chain is a hard-hitting co-op beat-’em-up with real-time tactical squad control, set in an over-the-top sword-and-sandal fantasy world of huge muscles, deadly curves, savage monsters and brutal team synergies.

**CURRENT — genre:** Sword-and-Sandal Tactical Beat-’Em-Up (pp. 10–12). Tactical squad control is the defining differentiator, not a secondary RPG feature.

Headline features:

- **Reacharound:** personal ability selection and targeting, Secret of Mana style.
- **Circle Jerk:** contextual squad requests and coordinated follow-ups.
- **MONEY SHOT:** selective cinematic finishes, combining zoom, slowdown, gore, and musical payoff.
- **GEAR CHANGES GAMEPLAY:** complete equipment sets unlock distinct combat kits and tactical roles, not a vertical stat ladder.
- **MUM RULES:** pick-up-and-play readability with depth underneath.

**CURRENT — platforms:** browser-playable vertical slice; Steam initial release (pp. 12, 105–107). Later owner intent specifies eventual PC, PS5, and Switch 2 ports. These are intentions, not verified platform support or approved console access. Linux development is not itself a Linux shipping commitment.

## 3. Design pillars

The owner agreed the following principles through discussion (pp. 13–29):

**MUM RULES — LOCKED principle (pp. 18–19):**

> Even your mum should be able to pick up a controller and start playing with little to no instruction. The basic controls, goals and effects should make sense through play. Depth can exist underneath, but understanding the game should never depend on tutorials, guides, spreadsheets or specialist knowledge. Complexity should come from combining simple, readable systems rather than from making the individual systems complicated.

- **FAST COMBAT:** Keep fights moving. Tanky enemies and bosses are allowed; coordinated tactics should break them down faster than repeated basic attacking. This replaces the opening summary's blanket under-30-second TTK framing; no universal numeric TTK cap is established.
- **STRATEGY WITHOUT BLUE BALLS:** Tactical control stays inside the action. Brief slowdown is acceptable; a full tactical pause is not the core design. Exact slowdown remains PLAYTEST REQUIRED.
- **GEAR CHANGES GAMEPLAY:** Equipment changes abilities, role expression, playstyle, and combo potential, rather than replacing old gear with larger numbers.
- **CO-OP WITHOUT PILLOW TALK:** Voice chat must never be required. In-game requests and communication must support the important coordination.
- **READABLE CHAOS:** Bloody, hectic combat must keep allies, threats, attacks, and opportunities readable with minimal UI.
- **EASY TO GET INTO, HARD TO GET OUT:** Basic fighting hooks immediately; deeper systems become increasingly important and eventually need to be learned.
- **GOOD FROM THE FIRST TOUCH:** Basic attacks must feel responsive and satisfying before advanced systems are added.
- **NO BUILD TAX:** No permanent bad build choices. Class/gear provide abilities, and setups can change between rounds. Progression opens choices instead of invalidating starter gear.
- **BIG, STUPID, PULP FANTASY:** Dark/mythic world, excessive heroic physiques, sensuality, huge weapons, monsters, and campy bravado. Not grounded realism.

**LOCKED production principle:** Game feel takes priority over feature count or a predetermined roadmap (pp. 108–109, 121–123).

## 4. Perspective, movement, and party control

**CURRENT (pp. 29–38; later Codex confirmations):**

- Classic side-on belt-scroller, with free movement up/down the floor depth as well as left/right. Streets of Rage, Mystara, and TMNT are references.
- Grounded, weighty baseline movement. Airborne mobility/jumps depend on class/abilities; no universal jumping system was agreed.
- Four total party members maximum, human or AI in any combination in the full-game direction. No duplicate heroes/classes within a party.
- Solo slice: directly control one hero and use three AI companions. Switch heroes; the departing hero returns to AI control.
- Fixed hero identities and fixed classes; names/personalities are not chosen yet. No extra personal gameplay-trait layer beyond class/gear. Writing/voice/backstory are presentation layers.

**OPEN:** locomotion speeds/acceleration, facing and aiming, lane/collision model, switching controls/timing/restrictions, player joins/leaves, downed-hero selection, and online session behavior.

## 5. Roles and starter heroes

**CURRENT (pp. 35–38, 56–62):** Four formal role categories: **Tank / DPS / Heals / Crowd Control**. Each class should ideally support all four through distinct class-flavored equipment sets. This is a design target, not permission to make every class play identically. Party composition matters without enforcing an MMO-style mandatory composition.

The initial “these are examples” answer was later resolved by explicitly selecting these four working starters:

| Hero | Starter identity and combat direction | Status / notes |
| --- | --- | --- |
| Barbarian | Tank identity; heavy, slow, powerful damage. | CURRENT; straight Barbarian rather than disciplined Fighter. |
| Thief | Sneaky DPS; fast/mobile, repeated slashes and dirty tricks. | CURRENT; Swashbuckler is an alternate-set idea, not slice scope. |
| Cleric | Classic armored holy warrior, closer to Paladin; support/heals with shield, blocking, and aggro-related protection. | CURRENT; owner also says the Cleric should tank by drawing aggro and blocking. Exact starter kit/role boundary remains OPEN. Do not reduce this to “healing only.” |
| Wizard | Classic Wizard; ranged DPS plus crowd control, very fragile. | CURRENT; exact spell roster OPEN. Mage/Wizard in the source refer to this working archetype. |

Starter gear is intentionally viable for the whole game, with unique and useful playstyles. Role identity is not a claim that the default set is statistically strongest.

**EXPERIMENTAL directions:** Barbarian Shaman with bear hat, totems, chants, potions; Thief Swashbuckler or alchemical bombs/potions for CC. These are useful creative anchors, not complete kits. **DEFERRED:** Amazon hero and Warlock direction (pp. 57–59, 113).

## 6. Core combat

### Attacks and combos

**CURRENT (pp. 30–32, 39–46):**

- Light and Heavy attacks, using deliberate input strings of at most roughly **3–4 button presses**.
- Shared openings can branch based on the finishing input. Different strings have distinct tactical functions, not just different damage totals.
- Common Light/Heavy input logic across classes; actual moves, cadence, animations, and outcomes differ.
- Strong/heavy finishers leave the player vulnerable on a whiff.
- Active abilities sit outside the basic combo chain. Owner permits triggering after combo input completes while its animation is still playing. Exact buffering, animation overlap, execution timing, and cancellation are OPEN; this is not approval to cancel any move freely.
- Defense is a universal action category, but type depends on class/set: physical/magical shields, dodge, etc. Keep defense simple and class dependent; no universal precision parry system was agreed.
- Grabs/throws are class/ability-specific, not universal.
- Same number of active ability slots for all characters; the actual number is OPEN. Class/gear determine abilities.
- Cooldowns heavily favored as the primary limiter, but resource model remains OPEN; no finalized mana/stamina/charge system.

### Armor, statuses, and finishers

- **CURRENT:** Shields block or reduce damage. Armor can break during combat and must visibly communicate the break. **OPEN:** heavy-armor HP versus damage reduction, guard/armor model, exact values (pp. 42–43).
- **PLAYTEST REQUIRED:** Hit reactions, stagger, and stun-lock susceptibility vary by enemy type/size. A light hit might interrupt a goblin while barely affecting a troll (pp. 41–42, 110–111).
- **CURRENT:** Formal readable statuses such as Stunned, Burning, Frozen, Bleeding, Poisoned, Knocked Down can be inflicted/exploited. These are category examples, not a finalized exhaustive roster.
- Statuses are useful alone and become more powerful in team combinations. Default combo payoff is extra damage; other results remain possible.
- Enemy resistances and appropriate full immunities exist. Boss/large-enemy CC can be downgraded where appropriate; tuning is encounter dependent.
- Executions exploit valid prepared states and compatible gear: **Stunned + Executioner Axe → decapitation; Frozen + Hammer → shatter**. Eligibility/duration/damage remain unspecified.
- **PLAYTEST REQUIRED:** No routine teammate chip damage; potentially negative allied side effects, such as an ice storm freezing/slowing friends. Do not silently implement full friendly damage or blanket ally immunity (pp. 44–45, 110).

**LOCKED feel direction (pp. 92–94):** Responsiveness is universal; weight is character-dependent. Thief speed and Barbarian impact should come from cadence, animation commitment, recoil, sound, and reactions, not artificial input lag.

## 7. Reacharound — personal ability wheel

**CURRENT (pp. 48–54, 87–90):**

1. Hold its input to open the wheel.
2. Select an ability belonging to the controlled character.
3. Select the recipient/target, cycling through valid targets.

Examples: cast Mind Bolt at a goblin; Heal a Barbarian. Exact spell inventory is not implied by examples.

The owner initially considered cycling teammates' ability circles, then revised the division of responsibility: **Reacharound is your own action selection; Circle Jerk handles squad requests.** It never directly controls another human player's abilities, and direct puppeteering of AI abilities through Reacharound is not the current direction.

Later controls discussion specifies both wheels are held, with D-pad up/down cycling multiple menus if they exist. This does not reinstate direct teammate ability control. Reacharound's exact confirm/release and cancellation rules remain OPEN; Circle Jerk has an explicit provisional release step.

Cooldown counters may appear in Reacharound. Opening a wheel exposes the tactical information layer. **PLAYTEST REQUIRED:** exact selection mechanics, live validity updates, slowdown, anti-spam, and related details.

## 8. Circle Jerk — contextual squad requests

**CURRENT purpose (pp. 49–54):** Ask the party for useful actions, preserving human agency and using AI state/ability feasibility. It is not simply a static long-term AI stance wheel, as the opening summary suggested.

**PLAYTEST REQUIRED interaction flow, proposed by the owner:**

1. Open/hold the wheel.
2. Choose an action/ability; point initially at a valid contextual opportunity when available.
3. Select a target.
4. Release to request.

**CURRENT contextual rule:** Surface useful valid actions based on combat state and party capability. If a goblin is stunned and the party has a Barbarian with an Executioner Axe, Decapitate can appear. Without the stun or compatible gear, it does not appear.

- Prioritize the strongest contextual option, with an attack bias when surfacing opportunities.
- Human teammates receive requests they may act on or ignore; no forced control. Healing requests normally outrank attack requests in request urgency.
- AI requests take precedence over configured routine behavior, while feasibility and higher-priority current actions still matter.
- **EXPERIMENTAL ideal / PLAYTEST REQUIRED:** A companion busy reviving might queue a non-urgent freeze; a time-sensitive execution should be rejected if it cannot finish before stun expires. The source's 0.5-second example is illustrative, not a fixed timing threshold or a promised predictive AI system.
- Acceptance/queue/rejection must be communicated; prefer audio over persistent UI. A short “No!” bark with a small red-X speech bubble is an example, not mandatory final art.
- **Required direction; solution PLAYTEST REQUIRED:** anti-spam measures. Exact cooldowns/rate limits are not chosen.

Attack-biased contextual selection and urgent healing priority describe different aspects; the full arbitration policy remains OPEN. Do not invent a universal numeric priority table.

## 9. AI companions and communication

**CURRENT (pp. 51–54, 87–90):** Each character has sensible role-based default behavior. Secret of Mana-inspired customization should support deeper conditional rules than broad presets. Health thresholds, target priorities, and ability conditions are examples; the exact rule set and UI depth are PLAYTEST REQUIRED.

Originally described as customizable through pause/pre-round menus, management was later placed between missions, likely in town buildings. The current intended preparation location is between missions; any separate pause-menu access remains a question, not a reason to invent full combat tactical pause.

Communications, barks, and contextual commands must make voice chat unnecessary. Future human squadmates must remain autonomous. Full online implementation is DEFERRED / slice stretch goal, not a public-slice gate.

## 10. Enemies and encounter structure

**CURRENT (pp. 63–74):**

- Readable familiar archetypes: grunts, shield defenders, ranged units, heavies, supports/casters, skirmishers, etc. Examples are not the selected six slice archetypes.
- Fodder between set pieces is dangerous to isolated heroes but killable through normal attacks/combos without opening wheels.
- Tactical set pieces use authored battalions that cooperate: screens/protection for ranged units, support effects, positioning, and priority targets.
- Difficulty variants should preserve the battalion concept. Adaptive party-aware director is EXPERIMENTAL / DEFERRED, not needed for the slice.
- Elites can be stronger archetypes and/or small tactical puzzles. Killing support leaders can materially weaken the group; a reviving shaman is a reference example.
- Encounter objectives can go beyond kill-all. Authored reinforcements and all-at-once compositions are both allowed.
- Bosses are deliberately varied; wheels/abilities should be key to cracking them. Use vulnerability windows and coordinated follow-ups, not only health attrition.
- One intended baseline difficulty, not an Easy/Normal/Hard ladder. Optional hardcore ideas remain OPEN; no permadeath rules are committed.

**PLAYTEST REQUIRED:** Specific AI sophistication, encounter sizes, resistance/stagger thresholds, and difficulty tuning. The example “10 goblins, 5 archers, 2 wizards” is not a required encounter.

### Goblin King showcase

**Required public-slice sequence (pp. 71–74, explicitly confirmed pp. 118–119):**

| Step | Hero action | Result |
| --- | --- | --- |
| 1 | Thief backstabs | Break guard. |
| 2 | Cleric prays | Lower resistance. |
| 3 | Wizard uses spell | Stun. |
| 4 | Barbarian uses Executioner Axe | Execute; showcase MONEY SHOT. |

Originally provisional, this sequence was later explicitly required for 0.1.0. Exact timing, health gates, failures, repeatability, and balancing remain PLAYTEST REQUIRED. Do not assume every boss follows this sequence or that each action is a chosen physical button.

**CURRENT teaching direction:** Body language, visible guard damage, effects, barks, and contextual wheel emphasis should communicate the opening. Escalating help is a discussed approach; exact tutorial implementation is OPEN.

## 11. World, missions, and town — full-game direction

**CURRENT (pp. 29–34, 75–80):**

- Point-and-click town overview with personality, secrets, and clickable buildings opening illustrated static interiors, NPCs, vendors, quests, and flavor. Betrayal at Krondor is the clarified interior reference, beyond the earlier Darkest Dungeon analogy.
- Tavern, Town Hall, magic/armor/weapon/potion shops, and NPCs. Brothel is a proposed flavor location without a defined mechanical purpose; not a slice requirement.
- Main mission from Town Hall; mission-linked side quests from other town NPCs/buildings.
- Full-game missions use connected side-scrolling sections with organic route discovery/backtracking. A map-reveal item/spell is an idea, not a finalized system.
- Combat areas temporarily lock until cleared, then permit progression/backtracking. Exact objective gates remain to be designed.
- Zero health leads to a downed state with teammate revival. Full-party wipe fails the mission and returns to town.
- Retry begins at mission start; discovered map locations and collected loot do not reset. Exact persistence scope is OPEN and not a requirement for a slice save system.
- Short rests in dungeons, possibly designated rooms. Effects/limits/costs are PLAYTEST REQUIRED.
- **No explicit long-rest system:** owner removed that earlier idea; sleep/recovery is assumed between missions.
- Objective completion does not automatically teleport the party home. Extraction depends on mission: exit staircase, Town Portal, escape, or return journey.

**CURRENT broad loop:** Town/preparation → mission/optional related quests → explore and fight → objectives → extraction → town. Leave room to reinterpret details after playtesting.

**Slice distinction:** Mostly linear mission with a couple of side rooms; town can be omitted. Full branching hub/campaign/persistence is not implied by public-slice scope.

## 12. Gear, unlocks, rewards, and economy

**CURRENT (pp. 81–87):**

- Complete themed sets, equipped all-or-nothing. Pieces can be collected, but the set becomes usable only when assembled. No mix-and-match partial-set gameplay is established.
- Sets are fixed mechanical sidegrades, not numerically upgraded. Starter sets deliberately remain viable at endgame.
- Different sets change a hero's kit/playstyle substantially, retaining class/cultural identity. Four formal roles guide set design; eventual full-game target is at least one set per role per hero.
- Unlocks mix authored goals and random sources: drops, quests, discoveries, vendors, etc. Previously owned set pieces never drop again. Ownership scope and loot-sharing rules are OPEN.
- Gold can support consumables, services, information, rest/town costs, cosmetics, and vendor set pieces; no prices or economy formulas chosen.
- Mission consumables exist; types may be class-specific. Thief alchemy/bombs is an example direction.
- Story, discovery, secrets, new playstyles, and teamwork drive rewards without a stat grind.
- Town gambling/minigames are DEFERRED.

**Slice distinction:** Starter/default sets only. Unlock economy, alternate sets, crafting, and full inventory progression are not required just to demonstrate 0.1.0.

## 13. Controls and UI

**CURRENT (pp. 87–90):**

- Controller and keyboard/mouse are equal priorities. Exact physical mapping/rebinding is OPEN.
- Light/Heavy use taps. Defense can be tap or hold depending on defensive style.
- Reacharound and Circle Jerk are held. D-pad up/down can cycle multiple menus if present. Keyboard equivalent and final menu organization are OPEN.
- Target selection cycles through valid targets.
- Combat HUD stays hidden by default. No floating damage numbers. Strong opposition to health bars; damage should read through blood, wounds, posture, animation, breathing, and voice.
- Reacharound can show cooldown counters. Opening wheels can reveal tactical information: statuses, resistances/immunities, armor/guard state, valid combos, and cooldowns relevant to selection.
- Objectives/navigation belong in map/menu rather than persistent combat guidance.
- Gear, behavior, and similar preparation happen between missions, likely in town buildings. A hub-free slice still needs an appropriate minimal session/restart flow; design not specified.

**OPEN / PLAYTEST REQUIRED:** Tactical overlay layout, target cycling order, invalidation during selection, missing-target behavior, cancellation, cooldown feedback detail, hidden-health accessibility, controller remapping, visual/audio alternatives, and pause semantics. Do not add a cluttered default HUD as an assumed convenience.

## 14. Art, camera, gore, and MONEY SHOT

**CURRENT (pp. 90–102):**

- Cleaned-up 80s/90s pulp fantasy, Mystara mixed with Heavy Metal; exaggerated muscles and curves, not anime proportions.
- Palette direction: darker than Mystara, lighter than Golden Axe.
- Dark/mythic world with excessive, campy/badass heroes. Full pulp gore: decapitation, dismemberment, shattering, etc.
- Responsive arcade combat with strong impact, varied by hero. Strong silhouettes identify characters/sets without GUI labels.
- Camera baseline between Mystara and TMNT framing, dynamically adjusting for party spread and narrative space. Can move from wide/open to claustrophobic dungeon framing.
- Rich illustrated atmosphere with TMNT-like modern readability. Pulp town/interior scenes. VFX must not obscure silhouettes, enemy tells, hazards, or tactical information.
- **OPEN:** Sprites versus 3D production, resolution, asset pipeline, exact camera bounds, animation counts, and final assets. Influences do not license copying reference-game art.

**MONEY SHOT — CURRENT feature:** Select significant finishes get a brief cinematic zoom/push-in and exaggerated slowdown to enjoy the impact/gore. Last-enemy tactical finishes are a core example; bosses/elites may qualify before all enemies are dead. Exact trigger frequency/eligible kills is PLAYTEST REQUIRED; it must not become automatic/repetitive.

**Required slice showcase:** Goblin King execution with full zoom, slowdown, gore, and adaptive musical crescendo. Camera/time effects present valid combat outcomes; they should not be the sole authority deciding whether an execution occurred.

**OPEN:** Duration, restoration, input behavior during cinematic, offscreen-threat treatment, multiplayer handling, photosensitivity/motion options, and content settings.

## 15. Audio

**CURRENT (pp. 102–105):** Big exaggerated impacts, crunchy gore, and strong spells. Frequent purposeful character barks replace much UI. Distinct tactical cues communicate opportunity, acceptance/rejection, target change, and ability readiness; important enemy/boss attacks need sound tells. Heroes should sound cringe, camp, and badass together.

**PLAYTEST REQUIRED:** Music style among arcade fantasy, TMNT-like energy, heavier metal, or hybrid. No artist imitation or track choice was approved as final production direction.

**CURRENT but budget-sensitive:** Rich town ambience, subject to cuts.

**LOCKED slice inclusion (pp. 113–114, 119):** Adaptive MONEY SHOT music must demonstrate a crescendo/sting resolving musically into the current track. The owner rejected deferring it; a rough placeholder/example is acceptable to prove the idea. Exact composition, musical scheduling, and implementation are OPEN.

## 16. Technical and production direction

**CURRENT (pp. 105–116 and later Codex setup):**

- Godot 4 with GDScript; browser-playable slice, later Steam/PC and PS5/Switch 2 aspirations. Owner approved replacing the historical Unity direction on 2026-11-16. Typed GDScript is the recommended initial coding convention. Exact Godot release, installations, export templates, add-ons, and physics model remain OPEN; no project has been created or configured.
- Planned browser baseline: Compatibility rendering (WebGL 2.0). Standard Godot 4 web exports currently do not support C#; use GDScript and verify export behavior against the selected release. Test browser builds early, especially audio/music timing during MONEY SHOT slowdown. Sample versus Stream playback has feature/latency tradeoffs; the playback strategy is OPEN, not already implemented.
- Console aspirations remain current, but Godot's standard download does not contain official console exporters. Platform approval, SDK access, and suitable third-party console tooling/porting services (or custom platform work) are required. Provider, budget, version compatibility, and platform support remain OPEN.
- Target **60 FPS**, including browser. Test hardware/browser and measurable budget are OPEN; this is a target, not a verified result.
- No proper persistent save needed for the short self-contained slice; session state is enough initially. Full-game persistence remains a separate requirement.
- Solo + AI slice. Online co-op implementation DEFERRED, possible stretch goal only.
- **LOCKED architecture constraint:** Keep future multiplayer in mind for every system and coding brief. Separate input/AI intent, authoritative game outcomes, and presentation sufficiently to avoid obvious rewrite traps. Framework/topology/tick/reconciliation choices remain OPEN.
- Frequent playable 0.0.x builds, each with one primary proof; 0.1.0 first public slice. If a build feels poor, iterate on it rather than advance the feature schedule.
- Rough placeholders acceptable during development. Public asset choices and licensing must be verified; no rights or production assets are established by the source. This is a delivery constraint, not a claim of a separate owner-approved art pipeline.
- Default to deferring features that delay the demo unless they directly prove its core combat/tactical identity. Do not silently remove explicit slice inclusions; record any owner-approved scope change.

Technical references checked 2026-11-16: [Godot web export and audio constraints](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_web.html), [Godot console support](https://godotengine.org/consoles/). Recheck these against the release chosen during setup; these references do not verify this game's exports or performance.

## 17. Required public vertical slice — 0.1.0

Recovered explicit scope (pp. 106–119):

| Item | Scope / evidence |
| --- | --- |
| Browser playable | CURRENT required direction; Godot 4 + GDScript, planned Compatibility baseline; exact release/export setup OPEN. |
| Approximately 5–15 minutes | CURRENT intended size, not yet measured. Owner directly describes this duration on p. 107; earlier summaries overstated uncertainty about its source. |
| Solo + AI, all four heroes playable | Required; later Codex confirmations establish hero switching. |
| Starter sets only | Required boundary; no alternate sets needed for slice. |
| Six enemy archetypes before boss | Required count, but identities/kits not selected. Not six enemies total. |
| Linear mission with a couple of side rooms | Required topology. |
| Town hub | May be skipped; not a release gate. |
| Reacharound and Circle Jerk | Both represented, simplified implementations allowed. |
| Goblin King | Required four-step guard → resistance → stun → execution interaction. |
| MONEY SHOT | Required boss showcase: zoom, slowdown, gore, adaptive crescendo. |
| Performance | 60 FPS target including browser; test baseline must be defined. |
| Save | No proper persistent save needed. |
| Online co-op | Stretch goal; not required. Architecture still future-aware. |

Replayability/game feel remain current goals. Exact pass/fail release checks, tester sample, accessibility requirements, licenses, hardware targets, and distribution method must be agreed before public release. None has been tested or signed off yet.

## 18. What is not settled

See [Open Questions](Open-Questions.md). The historical source now supplies the main design; do not describe Reacharound/Circle Jerk/MUM RULES as entirely missing again. Detailed class kits, physical controls, simulation/AI implementation, balancing, and asset production still need focused decisions and playtests.

This package contains documentation only. Actual development state and verification are in [Progress](Progress.md).
