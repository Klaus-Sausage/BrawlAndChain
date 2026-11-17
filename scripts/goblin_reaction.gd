extends Node2D
## Flash presentation only. Displacement and settling belong to gameplay state.

@export var flash_duration: float = 0.12

@onready var visual: Sprite2D = $Visual
var _flash_left: float = 0.0

func _process(delta: float) -> void:
	_flash_left = maxf(0.0, _flash_left - delta)
	visual.modulate = Color(1.0, 0.42, 0.36) if _flash_left > 0.0 else Color.WHITE

func show_hit_reaction() -> void:
	_flash_left = flash_duration
