# Development Progress and Build Log

Updated 2026-11-16 (Australia/Melbourne).

## Current build — private 0.0.1 Mystara Fighter preview

The approved default scene is scenes/visual_preview.tscn. It shows the ROM-derived armed Fighter with sword and shield, the Mystara goblin, and Village of Trintan. Ax Battler and its comparison scene/assets have been retired from the active project; the dated decision history records that experiment.

The prototype has provisional WASD floor movement, idle/walk and one sword attack. J triggers once per fresh press; holding does not repeat. Movement remains available during a swing. Contact resolves at attack step 5 / atlas frame 22. The original strike cadence is about 0.1845 seconds and the owner likes its speed and on-screen appearance. The owner set strike_range to 95 px after using the F2 overlay; lane_tolerance is 18 px. F2 shows the exact front-facing range/lane zone and separate FRONT/RANGE/LANE checks. These are experimental values, not final balance.

## Verification completed

- MAME 0.264 audited the supplied ddsomur1 USA 960209 ROM. The game's viewer assembled the original sword and shield; timing and frame origin were derived from emulated frames. ROMs, keys, emulator, dumps and intermediate captures remain outside the repository. Asset reuse permission is unverified; the project stays private.
- Native Godot 4.7.2 Compatibility on RTX 3080 rendered the 480×270 preview at 60 fps. Synthetic checks passed all walk poses, idle return, facing, hit/miss conditions, contact timing, moving attack/facing lock, hold-repeat suppression, distinct follow-up tap, and arena bounds.
- Browser WebGL 2 Compatibility loaded the 480×270 canvas. Close hit and distant/facing-away/wrong-lane misses were observed. Holding J for 1.8 seconds yielded one strike; a separate tap yielded the next. F2 overlay rendered and reported FRONT=YES, RANGE=NO, LANE=YES at the original 200 px gap.
- The owner reviewed the armed Fighter appearance and walk and said it looked and felt great. Native and browser previews use the same framing. The 95 px range and updated Web build are checked in.
- The browser export is versioned under web-preview/ and can be served locally as documented there. GitHub does not host it as a playable site; the repository is private.

## Current next action

The 0.0.1 hit-position feel check is accepted (D-071); do not repeat it without new evidence. The foundation, audio lab and [reciprocal exchange](Combat-Experiment.md) are implemented with objective checks below. Next, have the owner play the hold-guard exchange and listen to the audio lab before treating those subjective gates as passed. Starter kits/slots, enemy roster and wheel rules remain later staged gates under the authorized [14-step private roadmap](Roadmap.md).

## Private full-slice foundations — implementation and checks, 2026-11-16

- Recovered the newer local roadmap/status records before implementation, including D-071; recovery commit is `3f88cd2` on the current feature branch. This records local Git history, not a remote push claim.
- Expanded the maintained roadmap to the approved 14-step private-first sequence; added the reciprocal exchange brief and D-072, and aligned assistant instructions, GDD, README/handoff and open gates. Public production/release follows private gameplay proof.
- Minimum authority extraction is implemented: input/AI intent, action acceptance/contact/outcomes and visual playback are separated while preserving accepted preview behavior. The original scene remains the default.
- The separate hold-guard exchange is implemented with hidden 3 HP per actor, stationary goblin, 90 px enemy range/18 px lane, 0.70 s windup, 0.65 s recovery and 0.42 s small-goblin flinch. K guard plants the hero, covers the front and prevents a new strike; it does not cancel a committed strike. R resets the encounter. These are provisional experiment rules, not final starter-kit decisions.
- The separate MONEY SHOT lab uses locally generated original placeholder audio with Stream playback. It schedules a crescendo/resolution from the music clock while simulation time slows, then restores camera/time. It does not implement the final boss or demonstrate human approval of the musical quality.

Gameplay source was committed as `6d0467c`; `d2fd9f9` additionally normalizes generated HTML whitespace. The regenerated Web build's source-manifest.json identifies `d2fd9f9`, engine 4.7.2 and clean runtime inputs (`git_dirty=false`); source SHA-256 is `8539f2ff0aef4e378cd253b34c7d6069995daa99f410366e3908c6f8b76084d8`. The later documentation/build commit retains that source identity.

### Verification completed this session

| Check | Result and practical limit |
| --- | --- |
| Pinned import and four headless harnesses | PASS: Godot 4.7.2, fixed-60 harness execution; `PROJECT_CHECKS_PASS harnesses=4`. Preview regressions, authority at 15/30/60/144 presentation rates and absent/disabled visuals, audio scheduling/restoration, and all 22 exchange checks report `failures=[]`. These are simulation/notification checks, not measured game FPS. [Saved output](foundation-evidence/headless-checks.log). |
| Web export | PASS: the pinned matching templates produce a single-threaded Compatibility build. `tools/export_web.py` records source/artifact hashes and only replaces checked-in preview artifacts with `--update-preview`. |
| Headless Chromium preview | PASS: Chromium 156.0.8078.79 with software WebGL 2 loaded the export. Actual keyboard input verified one held strike, another distinct tap, movement and a close hit. [Frame](foundation-evidence/preview.png). |
| Headless Chromium exchange | PASS: guard caused no hero damage; releasing it allowed damage through defeat; R reset; three subsequent strikes defeated the goblin; another reset worked. [Guard frame](foundation-evidence/exchange-guard.png). |
| Headless Chromium audio lab | PASS objective proof: Start audio gesture unlocked Stream playback; Web Audio measured nonzero output (peak approximately 0.2095); two resolution events, interrupt/reset and return to preview worked. Human listening and musical quality remain pending. [Active lab frame](foundation-evidence/money-shot-active.png). |
| Browser errors | No Godot, JavaScript or HTTP errors in the automated three-scene run. [Browser results](foundation-evidence/browser-results.json). |

The shared visible Chrome attempt was blocked by unsupported WebGL 2; it did not display a playable game. A pinned native capture attempt could not access the managed X11 display (authorization unavailable); Wayland fallback was also unavailable, so no new native-window render is claimed. The independent headless Chromium renderer produced the captured frames above. Real browser focus loss could not be generated in that headless run; focus notification behavior passed harness checks only. New native-window gameplay, human listening/feel, gamepad support, full-run behavior and 60 FPS performance are not verified.

Roadmap status: steps 1 and 3 technically complete for this foundation; step 2 implemented/objective checks passed with listening pending; step 4 implemented/objective checks passed with owner feel review pending. Steps 5–14 have not started. The private full slice is not complete and public publication is not authorized by this work.

### Repeat these checks

Use the pinned editor and matching templates described in [Godot Setup](Godot-Setup.md#managed-cloud-foundation-checks--2026-11-16):

```bash
python3 tools/check_project.py --godot "$GODOT_BIN"
python3 tools/export_web.py --godot "$GODOT_BIN"
python3 -m http.server 8060 --bind 127.0.0.1 --directory exports/private-preview
```

In another terminal, run `python3 tools/check_browser_preview.py --url http://127.0.0.1:8060/`. Browser automation requires Python Playwright and Chromium; it writes ignored evidence to exports/browser-evidence/. The default URL is the accepted preview; add `?lab=combat-exchange` or `?lab=money-shot` for the separate experiments. Use `python3 tools/export_web.py --godot "$GODOT_BIN" --update-preview` only when intentionally refreshing the versioned private build.

## Roadmap planning — 2026-11-16

At the owner's request, added [Roadmap](Roadmap.md), a proposed full delivery sequence for 0.1.0. It uses the slice requirements already in the GDD, keeps open mechanics and content decisions as gates, and assigns no dates or 0.0.x build numbers. Linked it from the README, handoff, GDD, decision register, and open questions. This was documentation work only; no game code or build was changed and no gameplay verification was run.

The owner then confirmed satisfaction with the current 95 px strike range/hit positions and requested no further tuning. Marked the 0.0.1 hit-position check complete in the roadmap, GDD, Open Questions, Visual Preview, and handoff. No specific overlay diagnostic readings or new gameplay test were reported; the approval records the owner's feel judgment only.

## Superseded art experiment and extraction history

The first downloaded Mystara Fighter sheet was followed by an Ax Battler / Golden Axe II experiment. The owner disliked the walk feel, then chose the armed Mystara Fighter extracted from the supplied MAME ROM. The Ax-only art, scene, scripts, screenshots, and preparation branch were removed from the current tree in the 2026-11-16 cleanup. Historical approvals and reversals remain in docs/Decisions.md; archived source conversations remain unchanged.

The supplied ROM support files resolved the earlier MAME blockers. The verified secret viewer and palette capture produced idle, full walk, and sword attack frames with original equipment assembly. See assets/temporary_mystara_rom/README.md for technical provenance and reproducible external capture details. Emulator outputs and ROM data were kept outside the repository.

## Earlier setup and repository history

- Godot 4.7.2 stable, GDScript and matching web templates are installed locally; Compatibility rendering and minimal native/browser launch were verified. Cloud Godot setup is unverified. See docs/Godot-Setup.md.
- The repository is private at https://github.com/Klaus-Sausage/BrawlAndChain. Push/pull are explicit; cloud and PC checkouts do not sync automatically.
- The initial visual study established the provisional 480×270 canvas, 960×540 window, nearest filtering and Trintan arena. These settings remain provisional.
- Public milestone is 0.1.0. The initial proposed roadmap was superseded by D-072's approved private-first sequence in [Roadmap](Roadmap.md); staged design gates and one-primary-proof builds remain.

## Build log

| Build | Primary question | Current result | Next |
| --- | --- | --- | --- |
| 0.0.1 private preview | Do basic movement and one satisfying strike work with readable original Mystara Fighter animation? | Owner approves the armed look, cadence, speed, and current 95 px range/hit positions. Native/browser checks pass. | Preserve as regression baseline; review the implemented separate reciprocal exchange. |
| Unnumbered foundation experiments | Can authoritative combat preserve the preview while a reciprocal exchange and browser music/slowdown proof work separately? | Four headless harnesses and three-scene browser checks pass; owner exchange feel and human musical listening remain pending. No later slice systems are implemented. | Owner plays exchange/listens to lab; record observations before dependent expansion. |


## Cleanup and final verification — 2026-11-16

Retired the Golden Axe/Ax Battler files and comparison experiment from the current tree, removed its branch from the visual asset-preparation tool, and renamed the approved scene, animation and check tool to stable preview names. The default scene remains the ROM-derived Mystara Fighter at 95 px strike range with F2 diagnostics and fresh-press J input. Dated decision history and archived source transcripts are preserved.

Native Godot 4.7.2 Compatibility rerun on RTX 3080 passed the full preview harness after the rename: all 13 walk poses, both facings, close hit, distant/facing-away/wrong-lane misses, moving attack/facing lock, follow-up tap, contact frame 22, arena bounds, and one swing from a held/repeating J key (failures=[]). Browser WebGL2 Compatibility loaded the renamed default at 480×270; F2 displayed the 95 px zone and FRONT/RANGE/LANE status. No browser console errors were reported. The regenerated web-preview export matches the active project. Export/editor printed restricted socket/editor-settings messages after the pack was written; browser launch confirmed the export works.
