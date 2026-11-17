#!/usr/bin/env python3
"""Prepare the verified Web export as a GitHub Pages branch payload.

Only exported runtime files are copied. The hosted root opens the latest combo
test; explicit lab=preview keeps access to the original reference scene.
"""

import hashlib
import json
from pathlib import Path
import shutil
import subprocess


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "web-preview"
OUTPUT = ROOT / "exports" / "github-pages"


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    manifest = json.loads((SOURCE / "source-manifest.json").read_text())
    for name, expected in manifest["input_sha256"].items():
        if digest(ROOT / name) != expected:
            raise RuntimeError(f"Runtime source differs from export: {name}")
    for name, expected in manifest["artifact_sha256"].items():
        if Path(name).name != name:
            raise RuntimeError(f"Unexpected export filename: {name}")
        if digest(SOURCE / name) != expected:
            raise RuntimeError(f"Export artifact differs from manifest: {name}")
    if OUTPUT.exists():
        shutil.rmtree(OUTPUT)
    OUTPUT.mkdir(parents=True)
    for name in manifest["artifact_sha256"]:
        shutil.copyfile(SOURCE / name, OUTPUT / name)

    html = OUTPUT / "index.html"
    text = html.read_text()
    marker = "const engine = new Engine(GODOT_CONFIG);"
    if text.count(marker) != 1:
        raise RuntimeError("Expected one Godot loader initializer")
    default = (
        "// GitHub Pages opens the current PC playtest by default.\n"
        "if (!new URLSearchParams(window.location.search).has('lab')) {\n"
        "\tGODOT_CONFIG.args = ['--', '--combo-lab'];\n"
        "}\n"
    )
    html.write_text(text.replace(marker, default + marker))
    (OUTPUT / ".nojekyll").write_text("")
    manifest["hosting"] = {
        "platform": "GitHub Pages",
        "default_lab": "combos",
        "publication_source_commit": subprocess.check_output(
            ["git", "rev-parse", "HEAD"], cwd=ROOT, text=True
        ).strip(),
    }
    manifest["artifact_sha256"] = {
        path.name: digest(path) for path in sorted(OUTPUT.iterdir()) if path.is_file()
    }
    (OUTPUT / "source-manifest.json").write_text(json.dumps(manifest, indent=2, sort_keys=True) + "\n")
    print(f"GITHUB_PAGES_PREPARED {OUTPUT}")


if __name__ == "__main__":
    main()
