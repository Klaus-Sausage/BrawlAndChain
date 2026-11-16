extends Node
## Owns the fixed-step preview simulation and publishes outcomes to presentation.

const CombatState = preload("res://scripts/preview_combat_state.gd")

@export var strike_range: float = 95.0
@export var lane_tolerance: float = 18.0

signal strike_resolved(did_hit: bool)

var simulation: CombatState = CombatState.new()

@onready var hero: Node2D = get_parent().get_node("Hero")
@onready var goblin: Node2D = get_parent().get_node("Goblin")

func _ready() -> void:
	simulation.hero_position = hero.global_position
	simulation.goblin_position = goblin.global_position
	simulation.goblin_home_x = goblin.global_position.x
	simulation.strike_range = strike_range
	simulation.lane_tolerance = lane_tolerance
	hero.action_requested.connect(_on_action_requested)
	simulation.strike_resolved.connect(_on_strike_resolved)
	var animation := hero.get_node_or_null("HeroAnimation")
	if animation != null:
		animation.bind_simulation(simulation)

func _physics_process(delta: float) -> void:
	simulation.set_movement_intent(hero.movement_intent())
	simulation.advance(delta)
	_sync_actor_positions()

func _on_action_requested(action: StringName) -> void:
	simulation.request_action(action)

func _on_strike_resolved(did_hit: bool) -> void:
	if did_hit:
		goblin.show_hit_reaction()
	strike_resolved.emit(did_hit)
	print("STRIKE_RESULT hit=%s" % did_hit)

func _sync_actor_positions() -> void:
	hero.global_position = simulation.hero_position
	goblin.global_position = simulation.goblin_position
