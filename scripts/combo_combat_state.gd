extends "res://scripts/combat_exchange_state.gd"
## Separate three-input combo experiment. All numerical values are provisional.
## One fresh input may be buffered; held keys and finisher mashing never repeat.

signal combo_action_started(kind: StringName, step: int)
signal combo_input_buffered(kind: StringName)
signal combo_knockback_applied(distance: float)

var followup_window: float = 0.45
var heavy_contact_time: float = 0.30
var heavy_duration: float = 0.60
var heavy_repeat_delay: float = 0.75
var heavy_push: float = 32.0
var heavy_finisher_push: float = 48.0

var current_kind: StringName = &"light"
var current_step: int = 0
var chain_length: int = 0
var chain_expires_at: float = 0.0
var queued_action: StringName = &""
var simulation_time: float = 0.0
var _controller_movement := Vector2.ZERO


func _init() -> void:
	super()
	goblin_max_health = 6
	goblin_health = goblin_max_health
	strike_resolved.connect(_on_combo_contact)


func request_action(action: StringName) -> bool:
	if action != &"strike" and action != &"heavy_strike":
		return false
	if is_finished() or guard_held:
		return false
	if is_attacking or strike_cooldown > 0.0:
		# A finisher must recover before another deliberate sequence begins.
		if current_kind == &"heavy" or current_step >= 3 or queued_action != &"":
			return false
		if chain_length <= 0 or simulation_time > chain_expires_at:
			return false
		queued_action = action
		combo_input_buffered.emit(&"heavy" if action == &"heavy_strike" else &"light")
		return true
	return _start_action(action)


func _start_action(action: StringName) -> bool:
	if simulation_time > chain_expires_at:
		chain_length = 0
	var previous_kind := current_kind
	var previous_step := current_step
	current_kind = &"heavy" if action == &"heavy_strike" else &"light"
	current_step = chain_length + 1
	if not super.request_action(&"strike"):
		current_kind = previous_kind
		current_step = previous_step
		return false
	queued_action = &""
	chain_length = current_step if current_kind == &"light" and current_step < 3 else 0
	chain_expires_at = simulation_time + action_duration() + followup_window
	combo_action_started.emit(current_kind, current_step)
	return true


func set_movement_intent(movement: Vector2) -> void:
	_controller_movement = movement.limit_length()
	super.set_movement_intent(Vector2.ZERO if _heavy_committed() else _controller_movement)


func set_guard_intent(held: bool) -> void:
	super.set_guard_intent(held)
	if held:
		# Defense clears planned follow-ups, but cannot cancel the active strike.
		queued_action = &""
		chain_length = 0
		chain_expires_at = 0.0


func advance(delta: float) -> void:
	if not is_finite(delta) or delta <= 0.0:
		return
	simulation_time += delta
	super.set_movement_intent(Vector2.ZERO if _heavy_committed() else _controller_movement)
	super.advance(delta)
	if is_finished():
		queued_action = &""
		chain_length = 0
		return
	if simulation_time > chain_expires_at:
		chain_length = 0
		queued_action = &""
	if not is_attacking and strike_cooldown <= 0.0 and queued_action != &"":
		var next_action := queued_action
		queued_action = &""
		if not guard_held:
			_start_action(next_action)


func _heavy_committed() -> bool:
	return is_attacking and current_kind == &"heavy"


func action_contact_time() -> float:
	return heavy_contact_time if current_kind == &"heavy" else super.action_contact_time()


func action_duration() -> float:
	return heavy_duration if current_kind == &"heavy" else super.action_duration()


func action_repeat_delay() -> float:
	return heavy_repeat_delay if current_kind == &"heavy" else super.action_repeat_delay()


func action_knockback() -> float:
	if current_kind == &"heavy":
		return heavy_finisher_push if current_step == 3 else heavy_push
	return super.action_knockback()


func presentation_attack_elapsed() -> float:
	if current_kind != &"heavy":
		return super.presentation_attack_elapsed()
	# Reuse rough source frames while keeping visible contact aligned to the
	# authoritative heavy marker; no new matching sprite extraction is needed.
	if attack_elapsed <= heavy_contact_time:
		return attack_elapsed / heavy_contact_time * CONTACT_TIME
	return CONTACT_TIME + (attack_elapsed - heavy_contact_time) / (heavy_duration - heavy_contact_time) * (ATTACK_DURATION - CONTACT_TIME)


func _on_combo_contact(did_hit: bool) -> void:
	if not did_hit or current_kind != &"heavy":
		return
	# A heavy creates actual space rather than a visual nudge that returns home.
	var pushed := clampf(goblin_position.x, horizontal_margin, 480.0 - horizontal_margin)
	goblin_position.x = pushed
	goblin_home_x = pushed
	combo_knockback_applied.emit(action_knockback())


func reset_encounter() -> void:
	current_kind = &"light"
	current_step = 0
	chain_length = 0
	chain_expires_at = 0.0
	queued_action = &""
	simulation_time = 0.0
	_controller_movement = Vector2.ZERO
	super.reset_encounter()
