#!/usr/bin/env python3
"""Generate the original, intentionally simple MONEY SHOT lab music.

No recordings, samples, third-party melodies, or external packages are used.
The tonic arpeggio/drum loop repeats every two bars at 120 BPM. The overlay
builds for one bar, then resolves to the same tonic. These are technical test
assets rather than an agreed musical style or production soundtrack.
"""

import math
from pathlib import Path
import struct
import wave


RATE = 22050
BEAT = 0.5
BAR = BEAT * 4
DESTINATION = Path(__file__).resolve().parents[1] / "assets" / "audio_lab"
TAU = math.tau


def note(midi: int) -> float:
    return 440.0 * 2 ** ((midi - 69) / 12)


def tone(frequency: float, time: float) -> float:
    return math.sin(TAU * frequency * time) + 0.23 * math.sin(TAU * frequency * 2 * time)


def envelope(time: float, length: float, attack: float = 0.008) -> float:
    return min(time / attack, 1) * max(0, 1 - time / length) ** 2


def loop_sample(time: float) -> float:
    beat_index = int(time / BEAT)
    beat_time = time % BEAT
    melody = (62, 69, 65, 69, 74, 69, 65, 69)
    arpeggio = 0.13 * tone(note(melody[beat_index]), beat_time) * envelope(beat_time, 0.43)
    bass = 0.16 * tone(note(38), beat_time) * envelope(beat_time, 0.47)
    kick = 0.18 * math.sin(TAU * (48 * beat_time + 9 * (1 - math.exp(-35 * beat_time)))) * math.exp(-22 * beat_time)
    hat_time = time % (BEAT / 2)
    # Deterministic inharmonic oscillators provide a quiet, sample-free hat.
    hat = 0.025 * (math.sin(TAU * 3307 * hat_time) + math.sin(TAU * 5813 * hat_time)) * math.exp(-95 * hat_time)
    return arpeggio + bass + kick + hat


def finish_sample(time: float) -> float:
    if time < BAR:
        eighth_time = time % (BEAT / 2)
        step = int(time / (BEAT / 2))
        rising_notes = (62, 65, 69, 74, 77, 81, 86, 89)
        gain = 0.04 + 0.17 * (time / BAR) ** 2
        return gain * tone(note(rising_notes[step]), eighth_time) * envelope(eighth_time, 0.24)
    tail_time = time - BAR
    chord = sum(tone(note(midi), tail_time) for midi in (50, 62, 65, 69, 74)) / 5
    return 0.36 * chord * envelope(tail_time, BEAT * 1.5, 0.003)


def write_wave(name: str, duration: float, sample) -> None:
    samples = [max(-0.98, min(0.98, sample(index / RATE))) for index in range(round(duration * RATE))]
    with wave.open(str(DESTINATION / name), "wb") as output:
        output.setnchannels(1)
        output.setsampwidth(2)
        output.setframerate(RATE)
        output.writeframes(struct.pack(f"<{len(samples)}h", *(round(value * 32767) for value in samples)))


if __name__ == "__main__":
    DESTINATION.mkdir(parents=True, exist_ok=True)
    write_wave("tonic_loop.wav", BAR * 2, loop_sample)
    write_wave("finish_overlay.wav", BAR + BEAT * 1.5, finish_sample)
    print(f"Generated original 120 BPM lab audio in {DESTINATION}")
