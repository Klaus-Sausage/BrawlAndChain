extends Node
## Resolves strike intent into an authoritative hit/miss outcome.

@export var strike_range: float = 78.0
@export var lane_tolerance: float = 18.0

signal strike_resolved(did_hit: bool)

@onready var hero: Node2D = get_parent().get_node("Hero")
@onready var goblin: Node2D = get_parent().get_node("Goblin")

func _ready() -> void:
	hero.strike_requested.connect(_resolve_strike)

func _resolve_strike(origin: Vector2, facing_direction: float) -> void:
	var offset := goblin.global_position - origin
	var in_front := offset.x * facing_direction > 0.0
	var in_range := absf(offset.x) <= strike_range
	var in_lane := absf(offset.y) <= lane_tolerance
	var did_hit := in_front and in_range and in_lane
	if did_hit:
		goblin.show_hit_reaction(facing_direction)
	strike_resolved.emit(did_hit)
	print("STRIKE_RESULT hit=%s" % did_hit)
