extends SceneTree

const Exchange = preload("res://scripts/combat_exchange_state.gd")
var failures: Array[String] = []


func _initialize() -> void:
	_run.call_deferred()


func check(ok: bool, label: String) -> void:
	print("EXCHANGE_CHECK %s=%s" % [label, ok])
	if not ok:
		failures.append(label)


func close_exchange() -> Exchange:
	var state := Exchange.new()
	state.hero_position = Vector2(280, 226)
	return state


func advance(state: Exchange, seconds: float) -> void:
	var remaining := seconds
	while remaining > 0.000001:
		var delta := minf(1.0 / 60.0, remaining)
		state.advance(delta)
		remaining -= delta


func _run() -> void:
	var distant := Exchange.new()
	advance(distant, 4.0)
	check(distant.hero_health == 3 and distant.enemy_phase == &"idle", "no_attack_from_initial_distance")
	var unguarded := close_exchange()
	var outcomes: Array[StringName] = []
	unguarded.enemy_attack_resolved.connect(func(outcome: StringName): outcomes.append(outcome))
	advance(unguarded, 0.5)
	check(unguarded.hero_health == 3 and unguarded.enemy_phase == &"windup", "windup_before_contact")
	advance(unguarded, 0.25)
	check(unguarded.hero_health == 2 and outcomes == [&"hit"], "unguarded_contact_once")
	advance(unguarded, 0.40)
	check(unguarded.hero_health == 2 and outcomes.size() == 1, "recovery_has_no_second_contact")
	var guarded := close_exchange()
	guarded.set_guard_intent(true)
	guarded.set_movement_intent(Vector2.RIGHT)
	advance(guarded, 0.75)
	check(guarded.hero_health == 3 and guarded.hero_position == Vector2(280, 226), "front_guard_blocks_and_plants")
	check(not guarded.request_action(&"strike"), "guard_prevents_starting_strike")
	guarded.set_guard_intent(false)
	check(guarded.request_action(&"strike"), "release_guard_permits_strike")
	var wrong_facing := close_exchange()
	wrong_facing.facing_direction = -1.0
	wrong_facing.set_guard_intent(true)
	advance(wrong_facing, 0.75)
	check(wrong_facing.hero_health == 2, "guard_does_not_cover_rear")
	var committed := close_exchange()
	advance(committed, 0.65)
	check(committed.request_action(&"strike"), "strike_commits_during_enemy_windup")
	committed.set_guard_intent(true)
	advance(committed, 0.06)
	check(committed.hero_health == 2, "guard_does_not_cancel_committed_strike")
	var dodged := close_exchange()
	var misses: Array[StringName] = []
	dodged.enemy_attack_resolved.connect(func(outcome: StringName): misses.append(outcome))
	advance(dodged, 0.5)
	dodged.hero_position.y = 190.0
	advance(dodged, 0.25)
	check(dodged.hero_health == 3 and misses == [&"miss"], "leaving_lane_avoids_committed_attack")
	var hit := close_exchange()
	hit.request_action(&"strike")
	advance(hit, 0.25)
	check(hit.goblin_health == 2 and hit.enemy_phase == &"recovery", "player_contact_damages_once_and_staggers")
	check(not hit.request_action(&"strike"), "original_repeat_delay_preserved")
	advance(hit, 0.09)
	check(hit.request_action(&"strike"), "distinct_strike_after_original_delay")
	advance(hit, 0.34)
	hit.request_action(&"strike")
	advance(hit, 0.25)
	check(hit.goblin_health == 0 and hit.is_finished(), "goblin_defeat_after_three_contacts")
	check(not hit.request_action(&"strike"), "finished_encounter_rejects_strike")
	var defeated := close_exchange()
	advance(defeated, 5.0)
	check(defeated.hero_health == 0 and defeated.is_finished() and not defeated.request_action(&"strike"), "hero_defeat_stops_actions")
	defeated.set_movement_intent(Vector2.RIGHT)
	var dead_position := defeated.hero_position
	advance(defeated, 1.0)
	check(defeated.hero_position == dead_position, "defeated_hero_cannot_move")
	defeated.reset_encounter()
	check(defeated.hero_health == 3 and defeated.goblin_health == 3 and defeated.hero_position == Vector2(140, 226) and defeated.goblin_position == Vector2(340, 226) and not defeated.is_attacking and not defeated.guard_held and defeated.strike_cooldown == 0.0 and defeated.enemy_phase == &"idle", "reset_restores_complete_encounter")
	var active := close_exchange()
	active.request_action(&"strike")
	active.reset_encounter()
	advance(active, 0.5)
	check(active.goblin_health == 3 and not active.is_attacking and active.hero_health == 3, "reset_cancels_pending_contact")
	var scene: Node = load("res://scenes/combat_exchange.tscn").instantiate()
	root.add_child(scene)
	await process_frame
	check(scene.get_node("CombatResolver").simulation == scene.get("exchange"), "scene_binds_exchange_before_resolver_ready")
	check(InputMap.has_action(&"guard") and InputMap.has_action(&"reset_exchange"), "named_guard_and_reset_actions")
	scene.queue_free()
	await process_frame
	print("COMBAT_EXCHANGE_RESULTS failures=%s" % [failures])
	quit(0 if failures.is_empty() else 1)
