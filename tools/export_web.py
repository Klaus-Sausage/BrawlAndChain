#!/usr/bin/env python3
"""Export the pinned Web build; update checked-in web-preview only explicitly."""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

from check_project import ROOT, import_project, pinned_engine, run_godot

OUTPUT = ROOT / "exports" / "private-preview"
MANIFEST_NAME = "source-manifest.json"
SOURCE_PATHS = [
    ".godot-version", "project.godot", "export_presets.cfg", "assets", "scenes", "scripts",
    "tools/check_project.py", "tools/export_web.py", "web-preview/.gdignore",
]


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def git(*arguments: str) -> str:
    return subprocess.check_output(["git", *arguments], cwd=ROOT, text=True).strip()


def source_hashes() -> dict[str, str]:
    """Include tracked and new runtime inputs, never imported cache/build output."""
    names = git("ls-files", "--cached", "--others", "--exclude-standard", "-z", "--", *SOURCE_PATHS)
    result = {}
    for name in sorted(set(names.split("\0")) - {""}):
        path = ROOT / name
        if not path.is_file() or path.name == "README.md":
            continue
        if name != "web-preview/.gdignore" and not name.startswith("tools/") and any(
            (parent / ".gdignore").is_file() for parent in path.parents if parent != ROOT
        ):
            continue
        result[name] = sha256(path)
    return result


def add_lab_route(html_path: Path) -> None:
    html = html_path.read_text(encoding="utf-8")
    marker = "const engine = new Engine(GODOT_CONFIG);"
    if html.count(marker) != 1:
        raise RuntimeError("Export HTML does not contain exactly one expected Engine initializer.")
    route = (
        "// Brawl & Chain: only the named technical lab can change startup arguments.\n"
        "if (new URLSearchParams(window.location.search).get('lab') === 'money-shot') {\n"
        "\tGODOT_CONFIG.args = ['--', '--money-shot-lab'];\n"
        "} else if (new URLSearchParams(window.location.search).get('lab') === 'combat-exchange') {\n"
        "\tGODOT_CONFIG.args = ['--', '--combat-exchange'];\n"
        "}\n"
    )
    # Official templates contain trailing spaces/blank lines. Keep generated
    # text clean so a refreshed checked-in preview passes git diff --check.
    routed = html.replace(marker, route + marker)
    normalized = "\n".join(line.rstrip() for line in routed.splitlines()).rstrip() + "\n"
    html_path.write_text(normalized, encoding="utf-8")


def update_preview(export_directory: Path) -> None:
    preview = ROOT / "web-preview"
    preview.mkdir(exist_ok=True)
    artifacts = {path.name for path in export_directory.iterdir() if path.is_file()}
    for path in preview.iterdir():
        # These are generated Godot artifacts; preserve README, .gdignore and other owner files.
        if path.is_file() and (path.name.startswith("index.") or path.name == MANIFEST_NAME):
            if path.name not in artifacts:
                path.unlink()
    for name in sorted(artifacts - {MANIFEST_NAME}) + [MANIFEST_NAME]:
        target = preview / name
        temporary = preview / (name + ".tmp")
        shutil.copyfile(export_directory / name, temporary)
        temporary.replace(target)
    print(f"PREVIEW_UPDATED {preview}")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--godot", default=os.environ.get("GODOT_BIN", "godot"))
    parser.add_argument(
        "--update-preview", action="store_true",
        help="Replace generated web-preview artifacts after a successful export.",
    )
    args = parser.parse_args()
    try:
        version = pinned_engine(args.godot)
        OUTPUT.parent.mkdir(parents=True, exist_ok=True)
        (OUTPUT.parent / ".gdignore").touch()
        import_project(args.godot)
        before = source_hashes()
        revision = git("rev-parse", "HEAD")
        dirty = bool(git("status", "--porcelain", "--untracked-files=all", "--", *SOURCE_PATHS))
        with tempfile.TemporaryDirectory(prefix=".private-preview-", dir=OUTPUT.parent) as directory:
            staging = Path(directory)
            run_godot(
                args.godot, ["--export-release", "Web", str(staging / "index.html")], "web_export"
            )
            required = {"index.html", "index.js", "index.wasm", "index.pck"}
            if not all((staging / name).is_file() for name in required):
                raise RuntimeError("Godot did not produce all required Web artifacts.")
            add_lab_route(staging / "index.html")
            if source_hashes() != before:
                raise RuntimeError("Runtime source changed during export; rerun after edits finish.")
            inputs_json = json.dumps(before, sort_keys=True, separators=(",", ":"))
            manifest = {
                "schema_version": 1,
                "git_revision": revision,
                "git_dirty": dirty,
                "engine_version": version,
                "source_sha256": hashlib.sha256(inputs_json.encode("utf-8")).hexdigest(),
                "input_sha256": before,
                "artifact_sha256": {
                    path.name: sha256(path) for path in sorted(staging.iterdir()) if path.is_file()
                },
            }
            (staging / MANIFEST_NAME).write_text(
                json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8"
            )
            if OUTPUT.exists():
                shutil.rmtree(OUTPUT)
            shutil.copytree(staging, OUTPUT)
        print(f"WEB_EXPORT_PASS {OUTPUT / 'index.html'} source_sha256={manifest['source_sha256']}")
        if args.update_preview:
            update_preview(OUTPUT)
        else:
            print("Checked-in web-preview was not changed. Use --update-preview after review.")
    except (OSError, RuntimeError, subprocess.SubprocessError) as exc:
        print(f"WEB_EXPORT_FAIL {exc}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
