extends "res://scripts/preview_combat_state.gd"
## Private reciprocal-combat experiment. Values and defense rules are provisional.
## Health, guard, enemy contact and reset are gameplay state, never sprite callbacks.

signal enemy_windup_started(facing: float)
signal enemy_attack_resolved(outcome: StringName)
signal actor_damaged(actor: StringName)
signal encounter_finished(winner: StringName)
signal encounter_reset

var hero_max_health: int = 3
var goblin_max_health: int = 3
var hero_health: int = 3
var goblin_health: int = 3
var enemy_range: float = 90.0
var enemy_windup: float = 0.70
var enemy_recovery: float = 0.65
var enemy_hit_recovery: float = 0.42
var enemy_phase: StringName = &"idle"
var enemy_phase_left: float = 0.0
var enemy_facing: float = -1.0
var guard_held: bool = false
var _requested_movement := Vector2.ZERO


func _init() -> void:
	strike_resolved.connect(_on_player_strike_resolved)


func set_movement_intent(movement: Vector2) -> void:
	_requested_movement = movement.limit_length()


func set_guard_intent(held: bool) -> void:
	guard_held = held


func is_guarding() -> bool:
	return guard_held and not is_attacking and not is_finished()


func is_finished() -> bool:
	return hero_health <= 0 or goblin_health <= 0


func request_action(action: StringName) -> bool:
	if is_finished() or is_guarding():
		return false
	return super.request_action(action)


func advance(delta: float) -> void:
	if not is_finite(delta) or delta <= 0.0:
		return
	if is_finished():
		# Let the victorious hero finish the already accepted source strike.
		# No new attack may start and no further enemy contact is scheduled.
		super.set_movement_intent(Vector2.ZERO)
		if hero_health > 0 and is_attacking:
			super.advance(delta)
		is_moving = false
		return
	# A raised guard plants the hero. During a committed strike, guard has no
	# effect; it becomes available after that strike completes.
	super.set_movement_intent(Vector2.ZERO if is_guarding() else _requested_movement)
	super.advance(delta)
	if not is_finished():
		_advance_enemy(delta)


func _advance_enemy(delta: float) -> void:
	var remaining := delta
	while remaining > 0.000001 and not is_finished():
		if enemy_phase == &"idle":
			if not _enemy_can_start():
				return
			enemy_facing = signf(hero_position.x - goblin_position.x)
			enemy_phase = &"windup"
			enemy_phase_left = maxf(enemy_windup, 0.01)
			enemy_windup_started.emit(enemy_facing)
		var consumed := minf(remaining, enemy_phase_left)
		remaining -= consumed
		enemy_phase_left -= consumed
		if enemy_phase_left > 0.000001:
			return
		if enemy_phase == &"windup":
			_resolve_enemy_contact()
			enemy_phase = &"recovery"
			enemy_phase_left = maxf(enemy_recovery, 0.01)
		else:
			enemy_phase = &"idle"


func _enemy_can_start() -> bool:
	var offset := hero_position - goblin_position
	return absf(offset.x) > 0.0 and absf(offset.x) <= enemy_range and absf(offset.y) <= lane_tolerance


func _resolve_enemy_contact() -> void:
	var offset := hero_position - goblin_position
	var in_front := offset.x * enemy_facing > 0.0
	var in_range := absf(offset.x) <= enemy_range
	var in_lane := absf(offset.y) <= lane_tolerance
	if not (in_front and in_range and in_lane):
		enemy_attack_resolved.emit(&"miss")
		return
	var incoming_in_front := (goblin_position.x - hero_position.x) * facing_direction > 0.0
	if is_guarding() and incoming_in_front:
		enemy_attack_resolved.emit(&"guarded")
		return
	hero_health = maxi(0, hero_health - 1)
	actor_damaged.emit(&"hero")
	enemy_attack_resolved.emit(&"hit")
	if hero_health == 0:
		is_attacking = false
		is_moving = false
		encounter_finished.emit(&"goblin")


func _on_player_strike_resolved(did_hit: bool) -> void:
	if not did_hit or is_finished():
		return
	goblin_health = maxi(0, goblin_health - 1)
	actor_damaged.emit(&"goblin")
	# A small goblin flinches out of its windup. This is a tunable experiment,
	# not a universal stagger rule for larger future enemies.
	if goblin_health > 0:
		enemy_phase = &"recovery"
		enemy_phase_left = maxf(enemy_hit_recovery, 0.01)
	else:
		enemy_phase = &"defeated"
		enemy_phase_left = 0.0
		is_moving = false
		encounter_finished.emit(&"hero")


func reset_encounter() -> void:
	hero_position = Vector2(140.0, 226.0)
	goblin_position = Vector2(340.0, 226.0)
	goblin_home_x = 340.0
	facing_direction = 1.0
	attack_facing_direction = 1.0
	hero_health = hero_max_health
	goblin_health = goblin_max_health
	is_moving = false
	is_attacking = false
	attack_elapsed = 0.0
	strike_cooldown = 0.0
	_contact_emitted = false
	guard_held = false
	_requested_movement = Vector2.ZERO
	super.set_movement_intent(Vector2.ZERO)
	enemy_phase = &"idle"
	enemy_phase_left = 0.0
	enemy_facing = -1.0
	encounter_reset.emit()
