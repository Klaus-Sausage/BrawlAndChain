extends Node
## ROM-captured presentation samples gameplay attack time; it never advances gameplay.

const CombatState = preload("res://scripts/preview_combat_state.gd")

@onready var visual: Sprite2D = get_parent().get_node("Visual")
var _simulation: CombatState
var _data: Dictionary
var _mode: String = "idle"
var _step: int = 0
var _elapsed: float = 0.0

func _ready() -> void:
	_data = JSON.parse_string(FileAccess.get_file_as_string("res://assets/temporary_mystara_rom/display/animations.json")) as Dictionary
	visual.flip_h = true
	_show_step()

func bind_simulation(state: CombatState) -> void:
	_simulation = state

func _process(delta: float) -> void:
	if _simulation == null:
		return
	var next_mode := "attack" if _simulation.is_attacking else ("walk" if _simulation.is_moving else "idle")
	if next_mode != _mode:
		_mode = next_mode
		_step = 0
		_elapsed = 0.0
	visual.flip_h = (_simulation.attack_facing_direction if _simulation.is_attacking else _simulation.facing_direction) > 0.0
	var clip: Dictionary = _data.clips[_mode]
	if _mode == "attack":
		# Sample the accepted source frames at authoritative elapsed action time.
		_step = 0
		var remaining := _simulation.presentation_attack_elapsed()
		while _step < clip.frames.size() - 1:
			var duration := float(clip.ticks[_step]) / float(_data.capture_fps)
			if remaining < duration:
				break
			remaining -= duration
			_step += 1
	else:
		_elapsed += delta
		var duration := float(clip.ticks[_step]) / float(_data.capture_fps)
		while _elapsed >= duration:
			_elapsed -= duration
			_step += 1
			if _step >= clip.frames.size():
				_step = int(clip.loop_start)
			duration = float(clip.ticks[_step]) / float(_data.capture_fps)
	_show_step()

func _show_step() -> void:
	visual.frame = int(_data.clips[_mode].frames[_step])
