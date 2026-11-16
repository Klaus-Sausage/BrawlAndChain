extends Node
## ROM-captured presentation. The existing intent/resolver retain gameplay authority.
signal strike_contact(facing_direction: float)
signal attack_finished

@export var playback_speed: float = 1.0
@onready var visual: Sprite2D = get_parent().get_node("Visual")
var _data: Dictionary
var _mode: String = "idle"
var _step: int = 0
var _elapsed: float = 0.0
var _moving: bool = false
var _facing: float = 1.0
var _contact_emitted: bool = false

func _ready() -> void:
	_data = JSON.parse_string(FileAccess.get_file_as_string("res://assets/temporary_mystara_rom/display/animations.json")) as Dictionary
	visual.flip_h = true
	_show_step()

func set_movement_state(is_moving: bool, facing_direction: float) -> void:
	_moving = is_moving
	if _mode != "attack":
		_facing = facing_direction
		visual.flip_h = _facing > 0.0
		var next_mode := "walk" if _moving else "idle"
		if next_mode != _mode:
			_start(next_mode)

func play_attack(facing_direction: float) -> void:
	if _mode == "attack":
		return
	_facing = facing_direction
	visual.flip_h = _facing > 0.0
	_contact_emitted = false
	_start("attack")

func _process(delta: float) -> void:
	_elapsed += delta * maxf(playback_speed, 0.01)
	var clip: Dictionary = _data.clips[_mode]
	var duration: float = float(clip.ticks[_step]) / float(_data.capture_fps)
	while _elapsed >= duration:
		_elapsed -= duration
		_step += 1
		if _step >= clip.frames.size():
			if _mode == "attack":
				_start("walk" if _moving else "idle")
				attack_finished.emit()
				return
			_step = int(clip.loop_start)
		_show_step()
		duration = float(clip.ticks[_step]) / float(_data.capture_fps)

func _start(mode: String) -> void:
	_mode = mode
	_step = 0
	_elapsed = 0.0
	_show_step()

func _show_step() -> void:
	var clip: Dictionary = _data.clips[_mode]
	visual.frame = int(clip.frames[_step])
	if _mode == "attack" and not _contact_emitted and _step == int(clip.contact_step):
		_contact_emitted = true
		strike_contact.emit(_facing)
