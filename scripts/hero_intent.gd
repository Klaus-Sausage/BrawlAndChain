extends Node2D
## Converts keyboard input into movement and strike intent. It never applies damage.

@export var movement_speed: float = 90.0
@export var horizontal_margin: float = 24.0
@export var floor_top: float = 185.0
@export var floor_bottom: float = 246.0
@export var strike_repeat_delay: float = 0.32

signal movement_state_changed(is_moving: bool, facing_direction: float)
signal strike_requested(facing_direction: float)

var facing_direction: float = 1.0
var _strike_cooldown: float = 0.0
var _attack_locked: bool = false
var _last_reported_moving: bool = false
var _last_reported_facing: float = 0.0

func _process(delta: float) -> void:
	_strike_cooldown = maxf(0.0, _strike_cooldown - delta)
	var movement := Vector2(
		float(Input.is_key_pressed(KEY_D)) - float(Input.is_key_pressed(KEY_A)),
		float(Input.is_key_pressed(KEY_S)) - float(Input.is_key_pressed(KEY_W))
	).normalized()
	position += movement * movement_speed * delta
	position.x = clampf(position.x, horizontal_margin, 480.0 - horizontal_margin)
	position.y = clampf(position.y, floor_top, floor_bottom)
	if movement.x != 0.0 and not _attack_locked:
		facing_direction = signf(movement.x)
	var is_moving := movement != Vector2.ZERO
	if is_moving != _last_reported_moving or facing_direction != _last_reported_facing:
		_last_reported_moving = is_moving
		_last_reported_facing = facing_direction
		movement_state_changed.emit(is_moving, facing_direction)
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_J and event.pressed and not event.echo:
		if _strike_cooldown <= 0.0 and not _attack_locked:
			_strike_cooldown = strike_repeat_delay
			_attack_locked = true
			strike_requested.emit(facing_direction)

func finish_attack() -> void:
	_attack_locked = false
