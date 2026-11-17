extends SceneTree
## Behavioral checks for deliberate branches, one buffered input and heavy commitment.

const Combo = preload("res://scripts/combo_combat_state.gd")
var failures: Array[String] = []


func _initialize() -> void:
	_run.call_deferred()


func check(ok: bool, label: String) -> void:
	print("COMBO_CHECK %s=%s" % [label, ok])
	if not ok:
		failures.append(label)


func state_at_close_range() -> Combo:
	var state := Combo.new()
	state.hero_position = Vector2(280, 226)
	state.enemy_range = 0.0
	return state


func tick(state: Combo, seconds: float) -> void:
	var remaining := seconds
	while remaining > 0.0000001:
		var step := minf(remaining, 1.0 / 60.0)
		state.advance(step)
		remaining -= step


func _run() -> void:
	var state := state_at_close_range()
	var actions: Array[String] = []
	var hits: Array[bool] = []
	state.combo_action_started.connect(func(kind: StringName, step: int): actions.append("%s%s" % [kind, step]))
	state.strike_resolved.connect(func(hit: bool): hits.append(hit))
	check(state.request_action(&"strike"), "light_starts_immediately")
	check(state.request_action(&"strike"), "one_early_followup_buffers")
	check(not state.request_action(&"strike"), "full_buffer_rejects_extra_press")
	tick(state, 0.34)
	check(actions == ["light1", "light2"], "buffer_starts_second_after_action_and_delay")
	check(state.request_action(&"strike"), "third_light_can_buffer")
	tick(state, 0.34)
	check(actions == ["light1", "light2", "light3"], "three_light_branch")
	check(not state.request_action(&"strike"), "finisher_does_not_buffer_a_fourth")
	tick(state, 0.7)
	print("COMBO_OBSERVED light_hits=%s health=%s" % [hits, state.goblin_health])
	check(hits == [true, true, true] and state.goblin_health == 3, "one_contact_each_no_auto_fourth")
	check(is_equal_approx(state.goblin_home_x, 340.0), "light_pressure_keeps_enemy_nearby")

	state = state_at_close_range()
	var branch: Array[String] = []
	state.combo_action_started.connect(func(kind: StringName, step: int): branch.append("%s%s" % [kind, step]))
	state.request_action(&"strike")
	state.request_action(&"strike")
	tick(state, 0.34)
	state.request_action(&"heavy_strike")
	tick(state, 0.34)
	check(branch == ["light1", "light2", "heavy3"], "shared_opening_branches_to_heavy")
	tick(state, 0.31)
	print("COMBO_OBSERVED heavy_branch=%s health=%s" % [branch, state.goblin_health])
	check(state.goblin_health == 3, "heavy_has_one_contact_and_no_stat_bonus")
	check(is_equal_approx(state.goblin_home_x, 388.0), "heavy_finisher_creates_48px_space")
	check(state.goblin_position.x - state.hero_position.x > 90.0, "knockback_exits_enemy_melee_range")
	tick(state, 1.0)
	check(is_equal_approx(state.goblin_position.x, state.goblin_home_x), "heavy_space_does_not_spring_back")

	state = state_at_close_range()
	check(state.request_action(&"heavy_strike"), "standalone_heavy_is_usable")
	state.set_movement_intent(Vector2.RIGHT)
	state.set_guard_intent(true)
	tick(state, 0.2)
	check(state.hero_position == Vector2(280, 226), "committed_heavy_plants_hero")
	check(state.is_attacking and not state.is_guarding(), "guard_cannot_cancel_heavy")
	check(not state.request_action(&"strike"), "heavy_has_no_queued_cancel")
	tick(state, 0.41)
	check(not state.is_attacking and state.is_guarding(), "guard_becomes_available_after_heavy")
	state.set_guard_intent(false)
	check(not state.request_action(&"strike"), "heavy_recovery_delay_is_respected")
	tick(state, 0.15)
	check(state.request_action(&"strike"), "fresh_light_after_heavy_recovers")

	state = state_at_close_range()
	state.enemy_range = 90.0
	state.facing_direction = -1.0
	tick(state, 0.3)
	state.request_action(&"heavy_strike")
	state.set_guard_intent(true)
	tick(state, 0.41)
	check(state.hero_health == 2 and state.is_attacking, "heavy_whiff_can_be_punished_during_commitment")
	check(is_equal_approx(state.goblin_home_x, 340.0), "whiff_never_knocks_target_back")

	state = state_at_close_range()
	state.request_action(&"strike")
	tick(state, 0.7)
	state.request_action(&"strike")
	check(state.current_step == 1, "late_press_starts_a_new_chain")
	state.request_action(&"heavy_strike")
	state.set_guard_intent(true)
	check(state.queued_action == &"", "defense_clears_buffer_without_canceling_action")
	state.set_guard_intent(false)
	tick(state, 0.7)
	check(state.current_kind == &"light", "cleared_heavy_does_not_fire_after_guard_release")

	state = state_at_close_range()
	state.request_action(&"heavy_strike")
	state.attack_elapsed = state.heavy_contact_time
	check(is_equal_approx(state.presentation_attack_elapsed(), state.CONTACT_TIME), "visible_heavy_contact_matches_gameplay_marker")
	state.reset_encounter()
	tick(state, 1.0)
	check(state.goblin_health == 6 and state.hero_health == 3 and not state.is_attacking and state.queued_action == &"", "reset_clears_action_health_chain_and_buffer")
	check(state.hero_position == Vector2(140, 226) and state.goblin_position == Vector2(340, 226), "reset_restores_original_arena_positions")
	state.hero_position = Vector2(400, 226)
	state.goblin_position = Vector2(450, 226)
	state.goblin_home_x = 450
	state.request_action(&"heavy_strike")
	tick(state, 0.31)
	check(state.goblin_position.x <= 456.0 and state.goblin_home_x <= 456.0, "heavy_knockback_clamps_to_arena")
	state.hero_health = 0
	check(not state.request_action(&"strike") and not state.request_action(&"heavy_strike"), "defeated_actor_cannot_start_either_action")
	check(not state.request_action(&"unknown"), "unknown_action_rejected")

	var scene: Node = load("res://scenes/combo_experiment.tscn").instantiate()
	root.add_child(scene)
	await process_frame
	check(scene.get_node("CombatResolver").simulation == scene.combo, "scene_binds_combo_state_before_resolver_ready")
	check(InputMap.has_action(&"heavy_strike"), "named_heavy_input_exists")
	scene.queue_free()
	await process_frame
	print("COMBO_RESULTS failures=%s" % [failures])
	quit(0 if failures.is_empty() else 1)
