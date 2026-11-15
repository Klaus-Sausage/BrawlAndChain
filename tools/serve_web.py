#!/usr/bin/env python3
"""Serve the generated single-threaded web launch test on loopback only."""
from functools import partial
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

if __name__ == "__main__":
    directory = Path(__file__).resolve().parents[1] / "exports" / "web"
    if not (directory / "index.html").is_file():
        raise SystemExit("Export Web to exports/web/index.html first.")
    print("Open http://127.0.0.1:8060/ (Ctrl+C to stop)", flush=True)
    ThreadingHTTPServer(("127.0.0.1", 8060), partial(SimpleHTTPRequestHandler, directory=str(directory))).serve_forever()
