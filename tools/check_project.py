#!/usr/bin/env python3
"""Check the pinned Godot toolchain, import, and available project harnesses."""
from __future__ import annotations

import argparse
import os
from pathlib import Path
import re
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
HARNESS_RESULTS = {
    "tools/check_visual_preview.gd": "PREVIEW_RESULTS",
    "tools/check_authority.gd": "AUTHORITY_RESULTS",
    "tools/check_money_shot_lab.gd": "MONEY_SHOT_RESULTS",
    "tools/check_combat_exchange.gd": "COMBAT_EXCHANGE_RESULTS",
    "tools/check_combo_experiment.gd": "COMBO_RESULTS",
}


def pinned_engine(executable: str) -> str:
    """Reject a different engine before importing or exporting project files."""
    pin = (ROOT / ".godot-version").read_text(encoding="utf-8").strip()
    expected = pin.replace("-", ".", 1)
    try:
        result = subprocess.run(
            [executable, "--version"], capture_output=True, text=True, check=True
        )
    except FileNotFoundError as exc:
        raise RuntimeError(
            f"Godot executable not found: {executable}. Set GODOT_BIN or --godot "
            f"to the installed {pin} editor."
        ) from exc
    except subprocess.CalledProcessError as exc:
        raise RuntimeError(f"Godot --version failed: {exc.stderr.strip()}") from exc
    versions = re.findall(r"^\d+\.\d+(?:\.\d+)?\.[A-Za-z0-9_.-]+$", result.stdout, re.M)
    if len(versions) != 1 or not (
        versions[0] == expected or versions[0].startswith(expected + ".")
    ):
        actual = result.stdout.strip() or result.stderr.strip() or "no version output"
        raise RuntimeError(
            f"Godot version mismatch: project requires {pin}; {executable} reports "
            f"{actual}. Install the matching editor/templates; the project pin was not changed."
        )
    print(f"GODOT_VERSION_PASS {versions[0]}", flush=True)
    return versions[0]


def run_godot(executable: str, arguments: list[str], label: str) -> str:
    print(f"CHECK_START {label}", flush=True)
    try:
        result = subprocess.run(
            [executable, "--headless", "--path", str(ROOT), *arguments],
            cwd=ROOT,
            capture_output=True,
            text=True,
            timeout=180,
        )
    except subprocess.TimeoutExpired as exc:
        raise RuntimeError(f"{label} exceeded the 180-second limit.") from exc
    output = result.stdout + result.stderr
    print(output, end="" if output.endswith("\n") else "\n", flush=True)
    if result.returncode != 0 or re.search(r"^(?:SCRIPT )?ERROR:", output, re.M):
        raise RuntimeError(f"{label} failed (exit {result.returncode}); see output above.")
    print(f"CHECK_PASS {label}", flush=True)
    return output


def import_project(executable: str) -> None:
    run_godot(executable, ["--editor", "--import"], "editor_import")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--godot", default=os.environ.get("GODOT_BIN", "godot"))
    args = parser.parse_args()
    try:
        pinned_engine(args.godot)
        if not (ROOT / "tools/check_visual_preview.gd").is_file():
            raise RuntimeError("Required visual-preview regression harness is missing.")
        import_project(args.godot)
        checked = 0
        for script, marker in HARNESS_RESULTS.items():
            if not (ROOT / script).is_file():
                continue
            output = run_godot(
                args.godot, ["--fixed-fps", "60", "--script", f"res://{script}"], script
            )
            result_lines = [line for line in output.splitlines() if line.startswith(marker)]
            if len(result_lines) != 1 or "failures=[]" not in result_lines[0]:
                raise RuntimeError(f"{script} did not report one successful {marker} result.")
            checked += 1
        print(f"PROJECT_CHECKS_PASS harnesses={checked}")
    except (OSError, RuntimeError) as exc:
        print(f"PROJECT_CHECKS_FAIL {exc}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
