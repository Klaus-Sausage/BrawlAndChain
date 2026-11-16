# Next private combat experiment — reciprocal exchange brief

Updated 2026-11-16 (Australia/Melbourne). **IMPLEMENTED private experiment; owner feel accepted (D-073).** Temporary hold-guard is owner-selected; mechanics/tuning and technical mappings remain EXPERIMENTAL. See [Roadmap step 4](Roadmap.md#4-prove-a-reciprocal-combat-exchange-in-focused-increments), D-072 and [Progress](Progress.md) for verification. The full slice is not implemented.

## Question and boundaries

Can the player read one goblin's melee tell, defend deliberately, deal a readable hit, and understand defeat/reset while the accepted movement and single-strike feel remain intact?

The separate scene is scenes/combat_exchange.tscn; the exported route is ?lab=combat-exchange. It uses one hero stand-in and one stationary goblin, retaining the accepted composition, fresh-press strike and 95 px player range. Internal health is hidden; there are no health bars or damage numbers. Rough flashes, windup marks, a guard arc, sprite reaction and defeat posture provide readable stand-ins. There are no companions, wheels, extra classes, inventory, networking, polished art or final kit specification in this proof.

## Selected temporary defense and remaining decisions

The owner selected **hold-to-guard** for this first reciprocal exchange. Implement it in the separate combat exchange scene; tap-dodge is not part of this proof. The choice does not lock the Barbarian's final defense or any other starter kit.

Holding guard plants the hero and blocks front-facing enemy contact fully. It prevents starting a new strike but does not cancel a committed strike; guarding becomes available when that strike finishes. It does not protect the rear. Review success/failure in play; no parry window, stamina, guard-break meter or permanent Barbarian defense is implied. Starter-kit details still require the later gate.

**Technical experiment mappings:** preserve WASD movement, J fresh-press strike and F2 diagnosis; use K held for guard and R for reset. Choose corresponding controller actions before calling controller support complete. These are temporary test mappings, not final game controls or class-kit bindings.

## Implemented exchange and provisional tuning

Both actors have 3 hidden health; each valid contact removes 1. The stationary goblin starts a 0.70 s windup when the hero is within 90 px and the shared 18 px lane tolerance, then has 0.65 s recovery. Facing commits at windup start; leaving its facing/range/lane avoids contact. A player hit interrupts this small goblin into a 0.42 s flinch; this is not a universal stagger rule. The player retains the accepted 95 px reach and 0.32 s minimum delay. These are editable experiment defaults, not balance approval.

## Focused implementation proofs

1. **Hit response and defeat:** route valid strikes through authoritative health and one readable reaction. Prevent repeated damage from one contact; defeat prevents further actions. Expose experimental health/tuning without default HUD numbers. Review the response before adding enemy pressure.
2. **Enemy tell and defense:** a stationary idle → marked windup → one melee contact → recovery loop. Contact resolves once against authoritative positions/defense; sprite overlap and effects do not own damage. A valid player contact is processed first in the current simulation step and interrupts a surviving goblin; keep this provisional ordering visible when reviewing simultaneous attacks.
3. **Defeat and reset:** communicate each defeat and reset positions, health, action state, animation and enemy state. Queued inputs, stale contacts and timers cannot leak into the next exchange. This local reset is not the later party-revive or mission-failure design.

The original preview remains the default regression reference. Web exports include both separate experiments without replacing that default; the export helper records source/artifact hashes. The checked-in preview is updated only through the explicit export option. Record the scene/source identity that each check exercises.

## Verification and owner review

- Automated: one outcome per contact; front/range/lane misses; hit/defense/defeat eligibility; no actions after defeat; reset clears state; accepted fresh-press and movement/strike behavior remains. Verify the selected defense's actual rules.
- Native/browser: visible windup/contact/recovery/reaction/defeat; real attack/defense/reset input; focus/input loss; repeated exchanges without stale outcomes. Headless checks cannot establish these visual/input results or feel.
- Owner: assess whether tells, defense, reactions and defeat are understandable and the exchange responsive. Record observations; no sample size, success percentage or numerical feel threshold is agreed.

**Exit:** the owner reviews this reciprocal exchange and its limitations. Resolve basic feel failures before combo branches or party expansion. This does not lock production balance, starter kits, final controls or final enemy animation.

**Owner result:** After instructions to try the goblin tell, hold-guard, strikes and reset, the owner replied “feels great.” The initial exchange's feel gate is accepted (D-073). Audio listening and later Light/Heavy/class-comparison proofs remain separate.

## Actual checks — 2026-11-16

All 22 exchange harness checks passed with pinned Godot 4.7.2. Headless Chromium 156.0.8078.79 with software WebGL 2 exercised real keyboard input: approach/guard with no hero damage, release guard and take damage through defeat, R reset, three J contacts to goblin defeat, then reset again. Godot/JavaScript/HTTP errors were absent. See [saved browser results](foundation-evidence/browser-results.json) and [headless checks](foundation-evidence/headless-checks.log).

Owner feel is accepted for this exchange (D-073). Human-visible native play, gamepad behavior and performance/FPS remain unverified. Real browser focus loss was not produced in headless testing; notification behavior has harness coverage only. No additional automated checks or musical listening results were reported with the owner's approval.
