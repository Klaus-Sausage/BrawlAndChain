extends Node
## Presents movement and one-shot attack animation without owning combat outcomes.

@export var walk_first_frame: int = 1
@export var walk_frame_count: int = 12
@export var walk_frames_per_second: float = 8.0
@export var attack_first_frame: int = 13
@export var attack_frame_count: int = 9
@export var attack_frames_per_second: float = 16.0
@export var attack_contact_frame: int = 8

signal strike_contact(facing_direction: float)
signal attack_finished

@onready var visual: Sprite2D = get_parent().get_node("Visual")

var _mode: String = "idle"
var _is_moving: bool = false
var _facing_direction: float = 1.0
var _frame_index: int = 0
var _frame_time: float = 0.0
var _contact_emitted: bool = false

func _ready() -> void:
	visual.frame = 0
	visual.flip_h = true

func _process(delta: float) -> void:
	if _mode == "attack":
		_advance_attack(delta)
	elif _mode == "walk":
		_advance_walk(delta)

func set_movement_state(is_moving: bool, facing_direction: float) -> void:
	_is_moving = is_moving
	_facing_direction = facing_direction
	visual.flip_h = _facing_direction > 0.0
	if _mode != "attack":
		_set_mode("walk" if _is_moving else "idle")

func play_attack(facing_direction: float) -> void:
	_facing_direction = facing_direction
	visual.flip_h = _facing_direction > 0.0
	_frame_index = 0
	_frame_time = 0.0
	_contact_emitted = false
	_set_mode("attack")

func _advance_walk(delta: float) -> void:
	_frame_time += delta
	var frame_duration := 1.0 / maxf(walk_frames_per_second, 0.1)
	while _frame_time >= frame_duration:
		_frame_time -= frame_duration
		_frame_index = (_frame_index + 1) % walk_frame_count
		visual.frame = walk_first_frame + _frame_index

func _advance_attack(delta: float) -> void:
	_frame_time += delta
	var frame_duration := 1.0 / maxf(attack_frames_per_second, 0.1)
	while _frame_time >= frame_duration and _mode == "attack":
		_frame_time -= frame_duration
		_frame_index += 1
		if _frame_index >= attack_frame_count:
			_set_mode("walk" if _is_moving else "idle")
			attack_finished.emit()
			return
		visual.frame = attack_first_frame + _frame_index
		if not _contact_emitted and _frame_index >= attack_contact_frame:
			_contact_emitted = true
			strike_contact.emit(_facing_direction)

func _set_mode(next_mode: String) -> void:
	if _mode == next_mode:
		return
	_mode = next_mode
	_frame_index = 0
	_frame_time = 0.0
	match _mode:
		"idle":
			visual.frame = 0
		"walk":
			visual.frame = walk_first_frame
		"attack":
			visual.frame = attack_first_frame
