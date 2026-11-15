# Development Progress and Build Log

Updated 2026-11-16 (Australia/Melbourne).

## Private GitHub backup setup — 2026-11-16

Owner request: read project guidance and set up private GitHub backup. Working folder is `/home/klaus/Documents/BrawlAndChain`. Inspected the folder before initialization: no working Git repository or history existed. GitHub CLI network-authenticated as `Klaus-Sausage`; target repository did not exist. Initialized `main` and added ignore rules for local assistant/credential directories and generated Unity files, preserving source documents and `.meta` files.

Private remote created: `https://github.com/Klaus-Sausage/BrawlAndChain`; `origin/main` tracks local `main`. Initial commit `6c4b358` pushed successfully. GitHub API confirmed `isPrivate: true`; a fresh HTTPS clone into `/tmp/brawl-and-chain-backup-check-20261116` matched all 12 tracked files byte-for-byte, including the original PDF. `git diff --cached --check` passed before the initial commit. Repository-local commit identity uses the account’s GitHub noreply address.

Next action: commit/push future changes and pull before moving between separate checkouts. Automatic sync is not configured. No gameplay work performed.

## Cloud repository connection — 2026-11-16

Owner completed GitHub connector authorization and reported restricting it to BrawlAndChain. In Codex Cloud setup, verified connected identity `Klaus-Sausage` and selected only `Klaus-Sausage/BrawlAndChain` for the existing private `Default Cloud` environment. Saved the draft; the setup workspace reported a successful clone of `main` into `/workspace/BrawlAndChain`, clean and matching `origin/main`. Published the environment; the UI confirmed publication and loaded a new draft based on the published version. Existing internet and privacy settings were unchanged. No new gameplay task was started. A separate task from the published configuration has not yet been tested; cloud write/push behavior is not verified by the clone check. Local/cloud folders remain separate; pull before work and commit/push changes before switching.

## Historical state — 2026-11-15


Documentation package rebuilt at `/workspace/BrawlAndChain` from the owner's 140-page Historical Design Chat PDF and later Codex confirmations. All extracted pages and the original PDF are preserved with maintained GDD, decisions, open questions, assistant instructions, and fresh-chat handoff.

Earlier cloud documentation files became unavailable. Cause unknown; do not claim they were deliberately deleted or that cloud persistence is configured. The earlier incomplete handoff/GDD originals are absent and are not fabricated as archived files in this bundle.

**No Unity project, gameplay code, game art/audio asset library, or playable build has been created here.** No gameplay playtest has occurred. Unity editor/version, renderer, packages, SDKs, hosting, Git remote, backup, and PC checkout have not been configured or verified.

Owner's PC output verifies Pop!_OS 24.04 LTS, x86_64, Git 2.43.0. Node/npm and Unity installation status remain unknown. The owner can select the cloud environment in the installed app; exact app/project features should be checked before giving UI instructions.

## Completed documentation work

- Read actual historical design exchanges and later revisions, rather than relying on the contradictory opening summary or incomplete closing export.
- Recovered Reacharound, Circle Jerk, MUM RULES, complete-set rules, UI/presentation/audio direction, boss sequence, and explicit slice scope.
- Incorporated later direct confirmations: hero switching/AI handover and PC/PS5/Switch 2 intentions.
- Recorded true open/playtest items; preserved distinct full-game, slice, and prototype scope.
- Created a portable download package with source evidence and instructions for the next chat.

## Verification

PASS: All 10 Markdown files are nonempty and all local Markdown links resolve. The transcript preserves all 140 nonempty extracted pages in order; the archived PDF matches the uploaded original byte-for-byte. Key recovered decisions are present in the maintained GDD. The final ZIP is checked against every package file after creation. No Unity or gameplay validation applies to this documentation-only task.

## Next tasks

1. Owner downloads and saves the package, then starts a fresh chat with it.
2. New chat reads `AGENTS.md` and `NEW-CHAT-HANDOFF.md`, inspects actual environment files, and finishes cloud project/repository persistence before more development.
3. Configure Git/remote backup under owner's chosen account/service; verify rather than assume sync. Do not create/publish an external repository without appropriate account context and authorization.
4. Verify Unity tooling and choose a small first playable objective; only then implement the minimum required systems.
5. Create a local Linux checkout later, once the cloud record is reliably saved.

## Build log template — no builds yet

| Version | Date | Primary goal | Changes | Owner test notes | Other tester notes | Verification / bugs | Next step |
| --- | --- | --- | --- | --- | --- | --- | --- |
| — | — | No playable build created | — | Not tested | Not tested | Documentation only | Finish setup |

Use sequential 0.0.x playable prototypes; public slice is 0.1.0. Every build gets one primary proof, actual test results, known bugs, and next step. Iterate on poor feel rather than advancing an assumed roadmap. No specific feature-to-build numbering is approved.

## Session handoff

Do not make the owner recount missing rules again: the PDF source now includes them. Read relevant pages when in doubt. Update this file and the design records after substantive work; no background Markdown autosave is configured. Never claim Git commits, remote backups, console readiness, or tested gameplay without evidence.
