# First Light/Heavy combo experiment

Updated 2026-11-16 (Australia/Melbourne). **CURRENT objective:** the owner selected knockback to create space for the first Heavy finisher (D-075). Implementation and automated checks are complete; owner feel and numerical tuning remain EXPERIMENTAL.

## Question and controls

Does a short shared opening make quick pressure and a committed space-making finish feel deliberately different?

Use the separate scene `scenes/combo_experiment.tscn` and exported route `?lab=combos`. The accepted movement/strike preview, reciprocal exchange and audio lab remain separate references. Temporary controls: WASD movement, J Light, L Heavy, K held guard, R reset and F2 diagnostics. This is a one-hero/one-goblin test, not final class kits or the full slice.

## Implemented technical proposals for playtesting

- J–J–J produces three Light contacts for pressure. J–J–L shares the first two Lights and finishes with a stronger displacement. Each contact still deals one hidden health point; the tactical distinction is space/commitment rather than extra damage.
- Standalone Heavy and an early Heavy after one Light are usable and end the current sequence. Their push is 32 px; the third-step Heavy pushes 48 px. Displacement persists in gameplay state and clamps at arena edges. Light reactions retain the original temporary nudge/settle behavior.
- Light retains the accepted source cadence/contact and 0.32 s minimum delay. A new Light follow-up may be selected within 0.45 s after the prior Light finishes. Expiration starts a fresh chain.
- At most one fresh next input buffers during a Light or its delay. Additional presses cannot queue an entire string. A Heavy or third Light ends the chain and accepts no buffered fourth action. Held-key autorepeat never adds actions.
- Heavy contact is at 0.30 s, the action lasts 0.60 s, and the next attack is available after 0.75 s. Heavy plants the hero through the active action, including misses. K does not cancel an accepted strike; holding it clears planned follow-ups and guarding becomes available after the strike ends.
- The existing source frames are reused as rough stand-ins with Heavy tint/arc cues and visible contact aligned to the gameplay marker. No sprite extraction or production animation is required by this test.
- The goblin has six hidden health points so one complete three-contact branch leaves a target for comparison. Hero health and enemy tell/recovery rules follow the accepted exchange. R clears positions, health, action, chain and pending input. There are no health bars or damage numbers.

These are editable prototype settings. They do not establish final combo windows, cancel rules, gear effects, animation commitment, class differences or controller mappings.

## Verification and next gate

Automated checks cover both branches, immediate first response, a single buffered follow-up, no automatic fourth action, expiration, one damage/contact, persistent bounded knockback, guard interaction, punishable Heavy misses, visible contact alignment, defeat and full reset. Existing preview/exchange regressions must pass after shared timing hooks are extended. Browser checks must exercise real J/L/guard/reset input and both branches.

**Owner review:** compare J–J–J with J–J–L, intentionally miss a Heavy, and check whether the pressure/space tradeoff and early input buffer feel clear. Record observed feedback before tuning or adding the Barbarian/Thief comparison. Approval of the earlier exchange and music lab does not pre-approve this new combat feel.

## Actual verification

Pinned Godot 4.7.2 import and all five harnesses pass, including 34 combo checks. Chromium software WebGL 2 passes all four scenes with real input, including both combo branches, early buffering, no held repeat, 48 px third-step Heavy push and reset during Heavy without stale damage. There are no Godot/JavaScript/HTTP errors. See [Progress](Progress.md) for saved evidence and limitations. Owner combo feel remains pending; no gamepad or performance/FPS claim is made.
