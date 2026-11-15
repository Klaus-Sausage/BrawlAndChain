# Design Decisions Register

Baseline recorded 2026-11-15 (Australia/Melbourne). Historical turn dates unknown. Page references point to the [original PDF](sources/Historical-Design-Chat.pdf) and corresponding headings in the [full transcript](sources/Historical-Design-Chat.md). This register summarizes owner-confirmed rules; it does not make every tunable or example immutable.

Updated 2026-11-16 (Australia/Melbourne). D-057 supersedes the engine portion of D-046; D-056 reflects subsequent verified repository setup. Historical source documents are unchanged.

## Identity and principles

| ID | Decision | Status | Source / reason |
| --- | --- | --- | --- |
| D-001 | Working title Brawl & Chain. | CURRENT | pp. 7–10; owner retains title. |
| D-002 | Sword-and-Sandal Tactical Beat-’Em-Up; tactical squad control immediately follows beat-'em-up in the pitch. | CURRENT | pp. 8–12; defining differentiator. Exact pitch in GDD. |
| D-003 | MUM RULES: even your mum should pick up a controller and play with little to no instruction. | LOCKED principle | pp. 17–19; owner refocuses on immediate playability, approves wording. Gear progression is separate, not part of its definition. |
| D-004 | FAST COMBAT permits tanky enemies with tactical ways to break them down faster. | CURRENT | pp. 19–20; replaces opening blanket under-30-second TTK framing. |
| D-005 | STRATEGY WITHOUT BLUE BALLS: tactical action continues; slowdown allowed, no core full tactical pause. | CURRENT | pp. 20–21; exact dilation requires playtests. |
| D-006 | GEAR CHANGES GAMEPLAY; new abilities/playstyles instead of larger numbers. | LOCKED principle | pp. 21–22; owner calls it core concept. |
| D-007 | CO-OP WITHOUT PILLOW TALK: important tactics must work without voice chat. | LOCKED principle | pp. 22–23; communication wheel carries coordination. |
| D-008 | READABLE CHAOS, immediate accessibility with eventual tactical depth, GOOD FROM THE FIRST TOUCH. | CURRENT pillars | pp. 23–26; readability and basic feel before complexity. |
| D-009 | NO BUILD TAX: no permanent bad build choices; change setups between rounds. | CURRENT | pp. 26–27; experimentation without forced stat progression. |
| D-010 | BIG, STUPID, PULP FANTASY: dark/mythic world, camp/excessive heroes. | CURRENT | pp. 27–29; balances Conan-like darkness and cheese. |

## Combat, heroes, and squad systems

| ID | Decision | Status | Source / reason |
| --- | --- | --- | --- |
| D-011 | Classic side-on combat with floor-depth movement; grounded/weighty baseline. | CURRENT | pp. 29–30; later Codex confirms Streets of Rage/TMNT/Mystara influence. |
| D-012 | Four total unique party members, human/AI combinations; fixed heroes/classes. | CURRENT | pp. 12–13, 35–38; manageable readable party. |
| D-013 | Solo controls one hero, three AI companions; switching returns previous hero to AI. | CURRENT | Direct later owner confirmations in Codex. Switch restrictions not specified. |
| D-014 | Tank/DPS/Heals/CC formal roles; ideally each class expresses all four through gear. | CURRENT target | pp. 35–38, 81–84; class flavor survives role changes. |
| D-015 | Working starters Barbarian, Thief, Cleric, Wizard; names not selected. | CURRENT | pp. 56–62; resolves earlier roster-as-examples answer. Amazon experiment withdrawn. |
| D-016 | Defense universal category, class-dependent type; grabs/throws and airborne mobility class/ability-dependent. | CURRENT | pp. 30–31, 45; no universal jump/parry/grapple requirement. |
| D-017 | Same active-slot count across characters; number not chosen. Favor cooldowns but leave resource system open. | CURRENT / OPEN details | pp. 31–32; avoid inventing slot count or mana rules. |
| D-018 | Light/Heavy input strings, max about 3–4 inputs; shared openings branch; distinct tactical functions; whiff vulnerability. | CURRENT | pp. 39–41; short readable strings with consequences. |
| D-019 | Abilities outside combo chain, may trigger after inputs complete while animation plays. | CURRENT / OPEN timing | p. 41; buffering/cancel semantics not decided. |
| D-020 | Breakable armor with visible feedback; shield defense. | CURRENT | pp. 42–43; HP versus damage reduction and guard model remain open. |
| D-021 | Statuses useful alone and as setups; executions use compatible state/gear. Resistances/immunities; CC downgrade where appropriate. | CURRENT | pp. 43–46; cooperative payoff without useless standalone abilities. |
| D-022 | No ordinary teammate chip damage; potential adverse friendly status effects. | PLAYTEST REQUIRED | pp. 44–45, 110; preserve experiment rather than invent broad friendly-fire rules. |
| D-023 | Reacharound selects own ability/target; no teammate puppeteering. | CURRENT | pp. 48–49; replaces initial teammate-circle idea and obsolete opening summary. |
| D-024 | Circle Jerk contextual squad requests; provisional open → action → target → release. | CURRENT purpose / PLAYTEST flow | pp. 49–50; valid setup and gear determine options. |
| D-025 | Bias contextual default toward strongest attack opportunity; urgent healing requests normally outrank attacks. | CURRENT / OPEN arbitration | pp. 50–52; discovery bias differs from request urgency. |
| D-026 | AI state/feasibility can override; requests override routine presets when feasible. Human requests remain optional. | CURRENT direction | pp. 50–52; preserve agency and avoid impossible actions. Predictive queue/reject behavior is an ideal to test. |
| D-027 | Audio-first request acceptance/queue/rejection feedback. Anti-spam required; mechanism unspecified. | CURRENT / PLAYTEST details | pp. 51–52, 110–111; minimal visual clutter. |
| D-028 | Role-based companion defaults and deeper conditional customization. | CURRENT / PLAYTEST depth | pp. 52–54, 112; exact rule set/UI open. Later preparation location is between missions. |

## Encounters, world, progression, and presentation

| ID | Decision | Status | Source / reason |
| --- | --- | --- | --- |
| D-029 | Fodder between tactical authored battalions; familiar archetypes, coordinated enemies, supports/priority targets. | CURRENT | pp. 63–70; fodder dangerous alone, normal combos sufficient. |
| D-030 | Bosses varied; vulnerability/coordination and both wheels key. | CURRENT | pp. 66–74; tactical payoff, not only health attrition. |
| D-031 | Goblin King: Thief backstab guard break → Cleric prayer resistance down → Wizard stun → Barbarian Executioner Axe. | Required slice sequence; tuning PLAYTEST | pp. 71–74, 119; initially provisional, later explicitly required. |
| D-032 | One intended baseline difficulty; no easy mode; optional hardcore specifics unresolved. | CURRENT / OPEN modifiers | pp. 68–70, 112. |
| D-033 | Full game: point-and-click town, static illustrated interiors, main mission Town Hall and linked NPC side quests. | CURRENT full-game direction | pp. 75–80; Betrayal at Krondor-like interiors. |
| D-034 | Full game: connected side-scrolling sections, organic route discovery, temporary combat-area locks. | CURRENT | pp. 32–34, 76–78; slice topology narrowed separately. |
| D-035 | Downed revival; full wipe fails mission; restart at entrance while discovered map/collected loot persist. | CURRENT full-game direction | pp. 33–34, 77–78; exact persistence and revive rules open. |
| D-036 | Short rests in dungeon; no explicit long rests; recovery assumed between missions. | CURRENT / PLAYTEST short-rest details | pp. 77–78, 112; supersedes initial short/long-rest idea. |
| D-037 | Complete objective then extract; route/portal/escape varies by mission. | CURRENT full-game direction | pp. 78–80; no automatic teleport rule. |
| D-038 | Complete sets assembled from pieces; usable only once complete; fixed sidegrades and viable starters. | CURRENT | pp. 81–83; replaces loose gear-slot assumptions. |
| D-039 | Eventually one set per formal role per hero; no duplicate owned pieces drop. Authored/random unlocks, consumables/economy/story rewards. | CURRENT full-game target | pp. 83–87; ownership and economy details open. |
| D-040 | Equal controller/keyboard priority; tap attacks, defense tap/hold by kit, hold wheels; cycle valid targets and menus. | CURRENT / OPEN exact mapping | pp. 87–90. |
| D-041 | Hidden default HUD, no damage numbers, no default health bars; physical/audio damage cues. Tactical details in wheels; map/menu objectives. | CURRENT | pp. 88–90; keep screen clean. |
| D-042 | Cleaned-up 80s/90s pulp; Mystara/Heavy Metal; full gore, strong silhouettes, controlled VFX. | CURRENT | pp. 90–97; no final asset pipeline selected. |
| D-043 | Responsiveness universal; weight character-dependent. Mid-distance dynamic/narrative camera. | CURRENT | pp. 92–96; heavy Barbarian must not feel input-lagged. |
| D-044 | MONEY SHOT selective cinematic zoom/slowdown; significant final/boss/elite finishes, exact frequency tested. | CURRENT / PLAYTEST triggers | pp. 98–102, 111; name approved by owner. |
| D-045 | Big combat audio, frequent purposeful barks, tactical/enemy cues, camp/badass delivery; music genre tested. | CURRENT / PLAYTEST music | pp. 102–105, 111. |

## Production and slice boundaries

| ID | Decision | Status | Source / reason |
| --- | --- | --- | --- |
| D-046 | Historical engine choice: Unity. Browser slice, Steam first, eventual consoles; later console intent PS5/Switch 2. | Engine superseded by D-057; platforms CURRENT | pp. 12, 105–107 and later Codex owner statement. Unity was chosen for broad platform reach; no game project was implemented. Engine replaced by owner-approved Godot direction on 2026-11-16; platform goals retained. |
| D-047 | Solo + AI first; future network-authoritative compatibility in all system/code briefs. | LOCKED planning constraint | pp. 106–107, 114; online only a slice stretch goal. |
| D-048 | Approx. 5–15-minute self-contained slice; no proper persistent save needed. | CURRENT | p. 107; duration has direct owner evidence, not just earlier assistant framing. |
| D-049 | 60 FPS target including browser. | CURRENT target | p. 108; hardware/browser measurement baseline open. |
| D-050 | Public slice all four heroes, starter sets only, six enemy archetypes before boss, linear level plus couple side rooms. | Required slice scope | p. 118; names/kits of six archetypes unresolved. |
| D-051 | Hub can be skipped; both wheels represented, simplified implementations allowed; full Goblin King interaction and MONEY SHOT. | Required scope / hub optional | p. 119. |
| D-052 | Adaptive MONEY SHOT musical crescendo must be in slice, rough example acceptable. | LOCKED slice inclusion | pp. 113–114, 119; owner explicitly rejects proposed deferral. |
| D-053 | Amazon, Warlock, adaptive enemy director, town minigames parked; full online implementation deferred/stretch. | DEFERRED / EXPERIMENTAL | pp. 112–114. Adaptive music specifically excluded from deferrals. |
| D-054 | Frequent playable 0.0.x builds, one primary proof; first public slice 0.1.0; game feel first. | LOCKED workflow | pp. 107–109, 115–116; detailed example roadmap not approved. |
| D-055 | Build log Version/Date/Goal/Changes/Test Notes/Next Step; separate owner/other tester feedback. | CURRENT | pp. 114–116. |
| D-056 | Persistent Markdown documentation; private GitHub backup and separate cloud/Linux checkouts with explicit pull/commit/push. | CURRENT operational workflow | Later Codex owner requests and setup. Private repository, initial push/fresh clone, and local checkout were recorded during setup; subsequent cloud read/write test created, verified, and deleted a temporary branch at `10361e8`. Automatic sync is not configured; a fresh task from the published cloud configuration remains untested. See Progress. |
| D-057 | Godot 4 + GDScript replaces Unity; typed GDScript recommended initially, Compatibility rendering planned for browser. | CURRENT engine/language; recommended technical defaults, exact release OPEN | Owner approved implementing the Godot documentation plan in Codex on 2026-11-16. Rationale: 2D/browser-first suitability, lighter Linux/cloud setup, open-source engine licensing, and GDScript iteration. Tradeoffs: standard Godot 4 web export lacks C# support; consoles need approved access plus appropriate third-party tooling/services or custom work. No engine project or install/export test yet. |

## Local setup pin — 2026-11-16 (D-058)

**CURRENT:** Standard Godot **4.7.2 stable**, GDScript, matching **4.7.2.stable** web templates and Compatibility rendering for the local launch project. Web preset is single-threaded with extensions disabled for this minimal check. Source: owner's current request to install standard Godot 4, use Compatibility, verify native/browser launch and commit/push; exact stable release selected from the official download page. Reason: reproducible editor/template match and direct browser-first validation. Supersedes “exact release OPEN” for this local setup in D-057; no engine/language or gameplay reversal.

Affected: GDD technical section, AGENTS, README/handoff, setup backlog and progress. Verified results and paths are in [Godot setup](Godot-Setup.md). Editor/native rendering and browser startup/input passed; no gameplay, audio timing, full-slice performance or cloud Godot installation is proven. This technical launch check is not a numbered playable prototype. Release may change through a documented tested upgrade.

## Engine change — 2026-11-16

**Old → new:** Unity (historical D-046) → Godot 4 + GDScript (D-057). This is an engine/language decision and documentation/ignore-rule update, not a gameplay redesign or a port of existing code. Exact release remains OPEN. Typed GDScript and Compatibility rendering are recommended/planned initial technical defaults, not locked implementation details.

**Evidence and impact:** Owner requested the change after comparing engines and GDScript, then approved the implementation plan. Update GDD technical/browser sections, assistant instructions, README/handoff, setup/playtest backlog, progress notes, and generated-file exclusions. Preserve the original transcript/PDF and prior Unity rationale. Godot browser audio timing is an early MONEY SHOT test; adaptive music remains in the slice. Future multiplayer separation and all platform/slice goals are retained.

**Technical references:** [Godot web export](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_web.html), [console support](https://godotengine.org/consoles/), [engine license](https://godotengine.org/license/). Verified against published documentation during the decision discussion; recheck release-specific behavior during setup. No gameplay build or playtest evidence exists for this change.

## Reconciliation notes — 2026-11-15

- Earlier summaries marked the main wheel rules and MUM RULES missing. The PDF now recovers them; no new creative rule was invented to fill these gaps.
- The source's opening Reacharound command-wheel and Circle Jerk behavior-wheel descriptions are superseded by explicit own-actions/contextual-requests exchanges on pp. 48–54.
- The closing incomplete export is not a retraction of decisions elsewhere in the same PDF.
- Initial rigid TTK and long-rest ideas were refined/removed by the owner. Old variants stay in the source archive for history.
- Four-class examples later became the selected working roster; the brief five-hero/Amazon experiment was withdrawn and later parked.
- Guard/resistance/stun/execution was initially provisional and then adopted as required public-slice scope. Exact tuning still needs playtests.
- Adaptive music was proposed for deferral, but the owner explicitly rejected that; do not defer it silently.
- Campaign branching and town belong to full-game design; the slice is linear with side rooms and can omit the hub.
- The Cleric's support identity and shield/aggro tanking detail are both retained; exact starter kit remains an open design task.
- Controller/menu D-pad cycling does not reinstate the abandoned Reacharound teammate-puppeteering idea. Healing urgency does not erase the contextual attack-default bias.

## Future change entry format

Record **date / ID / old rule → new rule / status / owner or source / reason and evidence / affected sections / actual build or commit reference**. Use one-line reasons for simple decisions and fuller explanations for reversals. Do not invent historical timestamps, commits, approvals, or playtest evidence.

## D-059 — Private sprite visual study, 2026-11-16

**Source:** Owner confirmed eventual similar 80s/90s fantasy sprite art, temporary Mystara use purely for the first private build, then explicitly requested implementation of the visual-test plan.

**CURRENT:** 2D fantasy sprites; Fighter as temporary Barbarian visual, goblin and Village of Trintan; replaceable visual children with foot origins. **EXPERIMENTAL:** static 480×270 composition at 960×540, nearest filtering, fixed camera; no HUD or gameplay. Reason: owner wants to see scale/framing before combat development. Supersedes “2D sprites versus 3D pipeline OPEN” for the initial visual direction; final resolution and asset production remain open. Source credits/original sheets preserved, reuse permission unverified, preview restricted to private use. Affected: GDD art section, handoff, asset notes, visual scene, progress and open questions. Actual native/browser results: [Visual Preview](Visual-Preview.md). Not playable 0.0.1.


### D-059 owner review — 2026-11-16

Owner approved the current private preview composition (“yeah thats perfect”) after viewing the native and browser result. Keep this character scale, camera distance and composition as the accepted starting visual. The canvas/display dimensions remain experimental and are not a production-resolution decision. No gameplay or final-asset decision follows from this feedback.

## D-060 — First private 0.0.1 combat experiment, 2026-11-16

**Source:** Owner explicitly approved implementing “0.0.1 — Basic movement and hit feel” in the current visual study.

**CURRENT objective / EXPERIMENTAL implementation:** Move the Barbarian stand-in with provisional WASD inside the arena; press J for one directional strike; a goblin registers a valid strike with temporary flash and displacement, without enemy AI. Keep the 480×270 canvas/960×540 framing, Compatibility renderer, fixed camera, temporary Mystara art and replaceable visual children. Intent, hit resolution and visual reaction are separate scripts. Strike range, lane tolerance, repeat delay and reaction timing are editable scene/script settings. Values and feel remain **PLAYTEST REQUIRED**.

**Reason and boundary:** Prove one focused movement/strike question after the owner approved the composition. This is a first private playable experiment, not 0.1.0 scope or an approved feature roadmap. No combos, enemy attacks, health UI, damage numbers, abilities or networking. Supersedes the earlier “no gameplay; agree first playable objective” progress wording. Affected: GDD technical state, Visual Preview, Open Questions and Progress. Actual native/browser results are recorded in [Visual Preview](Visual-Preview.md); owner play-feel review is pending.
