extends Node2D
## Presentation response only; combat code owns hit validity and outcomes.

@export var flash_duration: float = 0.12
@export var knockback_distance: float = 12.0
@export var settle_speed: float = 90.0

@onready var visual: Sprite2D = $Visual
var _home_x: float
var _flash_left: float = 0.0

func _ready() -> void:
	_home_x = position.x

func _process(delta: float) -> void:
	_flash_left = maxf(0.0, _flash_left - delta)
	visual.modulate = Color(1.0, 0.42, 0.36) if _flash_left > 0.0 else Color.WHITE
	position.x = move_toward(position.x, _home_x, settle_speed * delta)

func show_hit_reaction(hit_direction: float) -> void:
	_flash_left = flash_duration
	position.x += hit_direction * knockback_distance
