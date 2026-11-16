#!/usr/bin/env python3
"""Exercise exported private previews with Chromium and Playwright.

Requires Python Playwright and a Chromium executable (BRAWL_BROWSER_BIN may
override discovery). Writes screenshots and measured results to ignored exports/.
This verifies browser behavior and nonzero audio output, not human listening or FPS.
"""

import argparse
import json
import os
from pathlib import Path
import re
import shutil

from playwright.sync_api import sync_playwright

OBSERVATIONS = []


AUDIO_PROBE = r"""
(() => {
  window.__brawlAudio = { peak: 0, samples: 0, taps: [] };
  const connect = AudioNode.prototype.connect;
  const attached = new WeakSet();
  AudioNode.prototype.connect = function(destination, ...args) {
    const result = connect.call(this, destination, ...args);
    if (destination === this.context.destination && !attached.has(this)) {
      attached.add(this);
      const analyser = this.context.createAnalyser();
      analyser.fftSize = 256;
      const muted = this.context.createGain();
      muted.gain.value = 0;
      connect.call(this, analyser);
      connect.call(analyser, muted);
      connect.call(muted, destination);
      window.__brawlAudio.taps.push({ analyser, context: this.context });
    }
    return result;
  };
  setInterval(() => {
    for (const tap of window.__brawlAudio.taps) {
      const data = new Float32Array(tap.analyser.fftSize);
      tap.analyser.getFloatTimeDomainData(data);
      for (const value of data) {
        window.__brawlAudio.peak = Math.max(window.__brawlAudio.peak, Math.abs(value));
      }
      window.__brawlAudio.samples += data.length;
    }
  }, 50);
})();
"""


def wait_log(page, logs, marker, count=1, timeout=20000):
    elapsed = 0
    while sum(marker in entry for entry in logs) < count:
        if elapsed >= timeout:
            raise AssertionError(f"Missing log {marker!r} x{count}: {logs[-12:]}")
        page.wait_for_timeout(100)
        elapsed += 100


def canvas_click(page, x, y):
    box = page.locator("canvas").bounding_box()
    assert box and box["width"] > 0 and box["height"] > 0
    page.mouse.click(box["x"] + x * box["width"] / 480,
                     box["y"] + y * box["height"] / 270)


def new_page(browser):
    page = browser.new_page(viewport={"width": 960, "height": 540})
    page.route("**/favicon.ico", lambda route: route.fulfill(status=204))
    logs, errors = [], []
    observation = {"url": "about:blank", "logs": logs, "errors": errors}
    OBSERVATIONS.append(observation)

    def on_console(msg):
        logs.append(f"{msg.type}: {msg.text}")
        if msg.type == "error" and not msg.location.get("url", "").endswith("/favicon.ico"):
            errors.append(msg.text)

    page.on("console", on_console)
    page.on("pageerror", lambda error: errors.append(str(error)))
    page.on("response", lambda response: errors.append(f"HTTP {response.status}: {response.url}")
            if response.status >= 400 and not response.url.endswith("/favicon.ico") else None)
    page.on("framenavigated", lambda frame: observation.update(url=frame.url)
            if frame == page.main_frame else None)
    return page, logs, errors


def assert_clean(logs, errors):
    script_errors = [line for line in logs if re.search(r"\b(?:SCRIPT )?ERROR:", line)]
    assert not errors and not script_errors, errors + script_errors


def check_preview(browser, url, output):
    page, logs, errors = new_page(browser)
    page.goto(url, wait_until="domcontentloaded")
    wait_log(page, logs, "COMBAT_TEST_READY")
    canvas_click(page, 240, 135)
    page.keyboard.press("F2")
    page.keyboard.down("j")
    page.wait_for_timeout(1300)
    page.keyboard.down("j")  # An echo must not start another action.
    page.wait_for_timeout(250)
    assert sum("STRIKE_RESULT" in line for line in logs) == 1, logs
    page.keyboard.up("j")
    page.wait_for_timeout(400)
    page.keyboard.press("j")
    wait_log(page, logs, "STRIKE_RESULT", count=2)
    assert "hit=false" in [line for line in logs if "STRIKE_RESULT" in line][0]
    page.keyboard.down("d")
    page.wait_for_timeout(1600)
    page.keyboard.up("d")
    page.wait_for_timeout(150)
    page.keyboard.press("j")
    wait_log(page, logs, "STRIKE_RESULT", count=3)
    assert "hit=true" in [line for line in logs if "STRIKE_RESULT" in line][-1], logs
    page.screenshot(path=str(output / "preview.png"))
    assert_clean(logs, errors)
    page.close()
    return {"logs": logs, "page_errors": errors, "held_attack_once": True,
            "separate_tap": True, "movement_to_close_hit": True}


def check_audio_lab(browser, url, output):
    page, logs, errors = new_page(browser)
    page.add_init_script(AUDIO_PROBE)
    page.goto(url + "?lab=money-shot", wait_until="domcontentloaded")
    wait_log(page, logs, "MONEY_SHOT_LAB_READY")
    canvas_click(page, 65, 63)
    wait_log(page, logs, "MONEY_SHOT_AUDIO_STARTED")
    page.wait_for_timeout(650)
    canvas_click(page, 180, 63)
    wait_log(page, logs, "MONEY_SHOT_REQUEST")
    page.screenshot(path=str(output / "money-shot-active.png"))
    wait_log(page, logs, "MONEY_SHOT_RESTORED reason=complete")
    complete = [line for line in logs if "MONEY_SHOT_RESTORED reason=complete" in line][-1]
    assert "time_scale=1.0000" in complete and "zoom=1.0000" in complete, complete
    canvas_click(page, 180, 63)
    wait_log(page, logs, "MONEY_SHOT_REQUEST", count=2)
    canvas_click(page, 280, 63)
    wait_log(page, logs, "reason=reset interrupted=true")
    canvas_click(page, 180, 63)
    wait_log(page, logs, "MONEY_SHOT_RESTORED reason=complete", count=2)
    audio = page.evaluate("""() => ({peak: __brawlAudio.peak,
      samples: __brawlAudio.samples,
      states: __brawlAudio.taps.map(tap => tap.context.state)})""")
    assert audio["peak"] > 0.001 and "running" in audio["states"], audio
    page.screenshot(path=str(output / "money-shot-restored.png"))
    # Returning from a lab must not re-enter it via the persistent launch args.
    canvas_click(page, 365, 63)
    wait_log(page, logs, "COMBAT_TEST_READY")
    page.wait_for_timeout(250)
    assert sum("MONEY_SHOT_LAB_READY" in line for line in logs) == 1, logs
    assert_clean(logs, errors)
    page.close()
    return {"logs": logs, "page_errors": errors, "audio": audio,
            "completion_reset_repeat_and_return": True}


def check_exchange(browser, url, output):
    page, logs, errors = new_page(browser)
    page.goto(url + "?lab=combat-exchange", wait_until="domcontentloaded")
    wait_log(page, logs, "COMBAT_EXCHANGE_READY")
    canvas_click(page, 240, 135)
    page.keyboard.press("F2")
    page.keyboard.down("d")
    page.wait_for_timeout(1600)
    page.keyboard.up("d")
    page.keyboard.down("k")
    wait_log(page, logs, "EXCHANGE_ENEMY_RESULT outcome=guarded")
    page.screenshot(path=str(output / "exchange-guard.png"))
    assert not any("EXCHANGE_DAMAGED actor=hero" in line for line in logs), logs
    page.keyboard.up("k")
    wait_log(page, logs, "EXCHANGE_DAMAGED actor=hero")
    wait_log(page, logs, "EXCHANGE_FINISHED winner=goblin")
    page.screenshot(path=str(output / "exchange-defeat.png"))
    page.keyboard.press("r")
    wait_log(page, logs, "EXCHANGE_RESET")
    page.keyboard.down("d")
    page.wait_for_timeout(1600)
    page.keyboard.up("d")
    for _ in range(3):
        page.keyboard.press("j")
        page.wait_for_timeout(400)
    wait_log(page, logs, "EXCHANGE_FINISHED winner=hero")
    page.screenshot(path=str(output / "exchange-victory.png"))
    page.keyboard.press("r")
    wait_log(page, logs, "EXCHANGE_RESET", count=2)
    assert_clean(logs, errors)
    page.close()
    return {"logs": logs, "page_errors": errors,
            "guard_damage_defeat_victory_reset": True}


def check_combos(browser, url, output):
    page, logs, errors = new_page(browser)
    page.goto(url + "?lab=combos", wait_until="domcontentloaded")
    wait_log(page, logs, "COMBO_LAB_READY")
    canvas_click(page, 240, 135)
    page.keyboard.press("F2")
    page.keyboard.down("d")
    page.wait_for_timeout(1600)
    page.keyboard.up("d")
    page.keyboard.press("j")
    wait_log(page, logs, "COMBO_ACTION kind=light step=1")
    page.wait_for_timeout(60)
    page.keyboard.press("j")
    wait_log(page, logs, "COMBO_BUFFER kind=light")
    wait_log(page, logs, "COMBO_ACTION kind=light step=2")
    page.keyboard.down("j")  # Hold the accepted third input through recovery.
    wait_log(page, logs, "COMBO_ACTION kind=light step=3")
    page.wait_for_timeout(120)
    page.screenshot(path=str(output / "combo-light.png"))
    page.wait_for_timeout(800)
    page.keyboard.down("j")
    page.keyboard.up("j")
    assert sum("COMBO_ACTION" in line for line in logs) == 3, logs
    page.keyboard.press("r")
    wait_log(page, logs, "EXCHANGE_RESET")
    page.keyboard.down("d")
    page.wait_for_timeout(1600)
    page.keyboard.up("d")
    page.keyboard.press("j")
    page.wait_for_timeout(360)
    page.keyboard.press("j")
    page.wait_for_timeout(360)
    page.keyboard.down("l")  # Hold the accepted Heavy instead of pressing again later.
    wait_log(page, logs, "COMBO_ACTION kind=heavy step=3")
    wait_log(page, logs, "COMBO_KNOCKBACK distance=48")
    page.screenshot(path=str(output / "combo-heavy.png"))
    page.wait_for_timeout(900)
    page.keyboard.down("l")
    page.keyboard.up("l")
    assert sum("COMBO_ACTION kind=heavy" in line for line in logs) == 1, logs
    page.keyboard.press("l")  # Start another Heavy, then interrupt it with reset.
    wait_log(page, logs, "COMBO_ACTION kind=heavy", count=2)
    page.wait_for_timeout(80)
    page.keyboard.press("r")
    wait_log(page, logs, "EXCHANGE_RESET", count=2)
    marker = max(index for index, line in enumerate(logs) if "EXCHANGE_RESET" in line)
    page.wait_for_timeout(850)
    assert not any("EXCHANGE_DAMAGED" in line for line in logs[marker + 1:]), logs
    assert_clean(logs, errors)
    page.close()
    return {"logs": logs, "page_errors": errors,
            "light_branch_buffer_heavy_knockback_hold_and_reset": True}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--url", default="http://127.0.0.1:8060/")
    parser.add_argument("--output", type=Path, default=Path("exports/browser-evidence"))
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    executable = os.environ.get("BRAWL_BROWSER_BIN") or shutil.which("chromium")
    if not executable:
        parser.error("Chromium not found; set BRAWL_BROWSER_BIN")
    results = {}
    results["observations"] = OBSERVATIONS
    with sync_playwright() as playwright:
        browser = playwright.chromium.launch(executable_path=executable, headless=True,
            args=["--no-sandbox", "--enable-webgl", "--use-angle=swiftshader",
                  "--enable-unsafe-swiftshader"])
        try:
            results["browser"] = browser.version
            results["preview"] = check_preview(browser, args.url, args.output)
            results["money_shot"] = check_audio_lab(browser, args.url, args.output)
            results["exchange"] = check_exchange(browser, args.url, args.output)
            results["combos"] = check_combos(browser, args.url, args.output)
        except Exception as error:
            results["failure"] = str(error)
            for context in browser.contexts:
                for index, page in enumerate(context.pages):
                    page.screenshot(path=str(args.output / f"failure-{index}.png"))
            raise
        finally:
            (args.output / "results.json").write_text(json.dumps(results, indent=2) + "\n")
            browser.close()
    print("BROWSER_PREVIEW_RESULTS pass=true output=" + str(args.output))


if __name__ == "__main__":
    main()
