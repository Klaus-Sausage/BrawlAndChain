extends Node2D
## Converts keyboard input into movement and strike intent. It never applies damage.

@export var movement_speed: float = 90.0
@export var horizontal_margin: float = 24.0
@export var floor_top: float = 185.0
@export var floor_bottom: float = 246.0
@export var strike_repeat_delay: float = 0.32

signal strike_requested(origin: Vector2, facing_direction: float)

@onready var visual: Sprite2D = $Visual
var facing_direction: float = 1.0
var _strike_cooldown: float = 0.0

func _process(delta: float) -> void:
	_strike_cooldown = maxf(0.0, _strike_cooldown - delta)
	var movement := Vector2(
		float(Input.is_key_pressed(KEY_D)) - float(Input.is_key_pressed(KEY_A)),
		float(Input.is_key_pressed(KEY_S)) - float(Input.is_key_pressed(KEY_W))
	).normalized()
	position += movement * movement_speed * delta
	position.x = clampf(position.x, horizontal_margin, 480.0 - horizontal_margin)
	position.y = clampf(position.y, floor_top, floor_bottom)
	if movement.x != 0.0:
		facing_direction = signf(movement.x)
	# The Fighter's unflipped source art faces left; flipping it makes it face right.
	visual.flip_h = facing_direction > 0.0
	if Input.is_key_pressed(KEY_J) and _strike_cooldown <= 0.0:
		_strike_cooldown = strike_repeat_delay
		strike_requested.emit(global_position, facing_direction)
