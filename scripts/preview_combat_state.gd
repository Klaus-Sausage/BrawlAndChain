extends RefCounted
## Gameplay state for the accepted one-strike experiment. No scene or sprite dependency.
## The scene advances this state at the fixed physics rate; controllers only submit intent.

signal strike_started(facing_direction: float)
signal strike_contact(facing_direction: float)
signal attack_finished
signal strike_resolved(did_hit: bool)

# Approved source cadence: five captured ticks to contact, eleven to completion.
# These are gameplay timings, independent of atlas frames and animation callbacks.
const CAPTURE_FPS: float = 59.637405
const CONTACT_TIME: float = 5.0 / CAPTURE_FPS
const ATTACK_DURATION: float = 11.0 / CAPTURE_FPS

var movement_speed: float = 90.0
var horizontal_margin: float = 24.0
var floor_top: float = 185.0
var floor_bottom: float = 246.0
var strike_repeat_delay: float = 0.32
var strike_range: float = 95.0
var lane_tolerance: float = 18.0
var knockback_distance: float = 12.0
var settle_speed: float = 90.0

var hero_position := Vector2(140.0, 226.0)
var goblin_position := Vector2(340.0, 226.0)
var goblin_home_x: float = 340.0
var facing_direction: float = 1.0
var attack_facing_direction: float = 1.0
var is_moving: bool = false
var is_attacking: bool = false
var attack_elapsed: float = 0.0
var strike_cooldown: float = 0.0

var _movement_intent := Vector2.ZERO
var _contact_emitted: bool = false

func set_movement_intent(movement: Vector2) -> void:
	_movement_intent = movement.limit_length()

func request_action(action: StringName) -> bool:
	if action != &"strike" or is_attacking or strike_cooldown > 0.0:
		return false
	is_attacking = true
	attack_elapsed = 0.0
	attack_facing_direction = facing_direction
	strike_cooldown = strike_repeat_delay
	_contact_emitted = false
	strike_started.emit(attack_facing_direction)
	return true

func advance(delta: float) -> void:
	if delta <= 0.0:
		return
	strike_cooldown = maxf(0.0, strike_cooldown - delta)
	hero_position += _movement_intent * movement_speed * delta
	hero_position.x = clampf(hero_position.x, horizontal_margin, 480.0 - horizontal_margin)
	hero_position.y = clampf(hero_position.y, floor_top, floor_bottom)
	is_moving = _movement_intent != Vector2.ZERO
	if _movement_intent.x != 0.0 and not is_attacking:
		facing_direction = signf(_movement_intent.x)
	goblin_position.x = move_toward(goblin_position.x, goblin_home_x, settle_speed * delta)
	if not is_attacking:
		return
	attack_elapsed = minf(attack_elapsed + delta, ATTACK_DURATION)
	if not _contact_emitted and attack_elapsed >= CONTACT_TIME:
		_contact_emitted = true
		strike_contact.emit(attack_facing_direction)
		var checks := hit_checks(attack_facing_direction)
		var did_hit: bool = checks.front and checks.range and checks.lane
		if did_hit:
			goblin_position.x += attack_facing_direction * knockback_distance
		strike_resolved.emit(did_hit)
	if attack_elapsed >= ATTACK_DURATION:
		is_attacking = false
		attack_finished.emit()

func hit_checks(facing: float) -> Dictionary:
	var offset := goblin_position - hero_position
	return {
		"front": offset.x * facing > 0.0,
		"range": absf(offset.x) <= strike_range,
		"lane": absf(offset.y) <= lane_tolerance,
	}
