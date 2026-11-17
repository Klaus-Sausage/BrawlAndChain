# GitHub Pages PC playtest

2026-11-17: the owner requested a public PC test and clarified that it must use GitHub. D-076 supersedes the earlier private-only delivery restriction for this public GitHub test. This is still an incomplete prototype, not the 0.1.0 release; asset provenance and unverified reuse rights remain recorded.

## Prepared build

The `gh-pages` branch contains only the exported runtime files and `.nojekyll`. The current combo experiment opens at the site root; `?lab=preview`, `?lab=combat-exchange`, `?lab=money-shot`, and `?lab=combos` select the separate references/experiments. No external hosting service was created.

`python3 tools/prepare_github_pages.py` verifies the checked-in export against its source/artifact manifest, copies runtime files to ignored `exports/github-pages/`, and adds the hosted default without changing the accepted local preview. The payload's manifest records the hosted artifact hashes and upstream source identity. The WebAssembly file is below GitHub's 100 MiB file limit. Relative asset URLs support the `/BrawlAndChain/` repository path; single-threaded export does not need isolation headers.

## GitHub settings still required

The connected GitHub integration can push branches but returns HTTP 403 `Resource not accessible by integration` for repository visibility and Pages administration. The owner must complete those settings in GitHub:

1. Repository **Settings → General → Danger Zone → Change visibility → Public**.
2. **Settings → Pages → Build and deployment → Deploy from a branch**, select **gh-pages**, folder **/(root)**, then **Save**.

After GitHub builds the site, its Pages settings report the actual playable URL. The expected address is `https://klaus-sausage.github.io/BrawlAndChain/`; it is not a verified live deployment until the settings/build finish. Check anonymously that HTML, WebAssembly, pack and audio-worklet files load, then verify the combo input. Repository publicity and Pages enablement must not be claimed merely because the branch was pushed.

Game controls: WASD move, J Light, L Heavy, hold K guard, R reset, F2 diagnostics. Try J–J–J and J–J–L. This is keyboard-only testing; new combo feel, gamepad support and full-slice performance remain separate checks.

## Preparation verification

Prepared branch commit: `1c22ae65ef9320a4dc8292ec543b1bc57a43c352`. Chromium 156 software WebGL 2 checked the actual payload under a local `/BrawlAndChain/` subpath: queryless root opens combos, explicit preview input works, JJJ/LLH/hold/reset pass, and the audio lab produces nonzero output and restores time/camera. WebAssembly, pack, JavaScript and both audio worklets return HTTP 200 without console/script/page errors. [Saved results](github-pages-evidence/results.json).

This is payload/subpath verification. Live GitHub visibility, Pages publication and anonymous Internet access remain blocked/unverified until the owner saves the settings above.
