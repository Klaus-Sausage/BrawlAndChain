extends RefCounted
## Pure musical schedule. Seconds are supplied by the unscaled music clock.
## The lab settings are technical proposals, not final cinematic tuning.

const BEAT_SECONDS: float = 0.5
const BAR_SECONDS: float = BEAT_SECONDS * 4.0
const MIN_CRESCENDO_SECONDS: float = BEAT_SECONDS
const RESTORE_AFTER_RESOLUTION: float = 0.75

var active: bool = false
var overlay_started: bool = false
var resolved: bool = false
var overlay_at: float = -1.0
var resolve_at: float = -1.0
var restore_at: float = -1.0


func request(music_seconds: float) -> bool:
	if active or not is_finite(music_seconds) or music_seconds < 0.0:
		return false
	resolve_at = (floorf(music_seconds / BAR_SECONDS) + 1.0) * BAR_SECONDS
	if resolve_at - music_seconds < MIN_CRESCENDO_SECONDS:
		resolve_at += BAR_SECONDS
	overlay_at = resolve_at - BAR_SECONDS
	restore_at = resolve_at + RESTORE_AFTER_RESOLUTION
	active = true
	overlay_started = false
	resolved = false
	return true


func advance(music_seconds: float) -> Array[String]:
	var events: Array[String] = []
	if not active:
		return events
	if music_seconds >= overlay_at and not overlay_started:
		overlay_started = true
		events.append("crescendo")
	if music_seconds >= resolve_at and not resolved:
		resolved = true
		events.append("resolution")
	if music_seconds >= restore_at:
		active = false
		events.append("restored")
	return events


func cancel() -> bool:
	var was_active := active
	active = false
	overlay_started = false
	resolved = false
	overlay_at = -1.0
	resolve_at = -1.0
	restore_at = -1.0
	return was_active
