extends SceneTree
## Deterministic gameplay checks; rendered frames never drive the simulation clock.

const CombatState = preload("res://scripts/preview_combat_state.gd")
const FighterPresentation = preload("res://scripts/fighter_animation.gd")
const STEP: float = 1.0 / 60.0

var failures: Array[String] = []

func _initialize() -> void:
	_run.call_deferred()

func check(ok: bool, label: String) -> void:
	print("AUTHORITY_CHECK %s=%s" % [label, ok])
	if not ok:
		failures.append(label)

func _run() -> void:
	check(_outcome(Vector2(245, 226), 1.0), "range_boundary_inclusive")
	check(not _outcome(Vector2(244.99, 226), 1.0), "outside_range_misses")
	check(_outcome(Vector2(280, 208), 1.0), "lane_boundary_inclusive")
	check(not _outcome(Vector2(280, 207.99), 1.0), "outside_lane_misses")
	check(not _outcome(Vector2(340, 226), 1.0), "same_origin_is_not_in_front")
	check(_outcome(Vector2(400, 226), -1.0), "left_facing_hits")
	_check_timing_and_cooldown()
	var baseline := _run_render_schedule(60, false)
	check(baseline.hits == [true, true, false, false, false], "expected_hits_and_misses")
	check(baseline.accepted == [true, false, false, true, true, true, true], "lock_and_cooldown_reject_repeated_requests")
	check(baseline.contacts == 5 and baseline.finished == 5, "one_contact_and_completion_per_accepted_action")
	for fps in [15, 30, 60, 144]:
		check(_run_render_schedule(fps, true) == baseline, "same_gameplay_with_%s_fps_presentation" % fps)
	print("AUTHORITY_RESULTS failures=%s" % [failures])
	quit(0 if failures.is_empty() else 1)

func _outcome(position: Vector2, facing: float) -> bool:
	var state := CombatState.new()
	state.hero_position = position
	state.facing_direction = facing
	var hits: Array[bool] = []
	state.strike_resolved.connect(func(hit: bool): hits.append(hit))
	state.request_action(&"strike")
	state.advance(CombatState.CONTACT_TIME)
	return hits.size() == 1 and hits[0]

func _check_timing_and_cooldown() -> void:
	var state := CombatState.new()
	var events: Array[String] = []
	state.strike_contact.connect(func(_facing: float): events.append("contact"))
	state.attack_finished.connect(func(): events.append("finished"))
	check(not state.request_action(&"unknown"), "unknown_action_rejected")
	check(state.request_action(&"strike"), "initial_strike_accepted")
	state.advance(CombatState.CONTACT_TIME - 0.000001)
	check(events.is_empty(), "no_contact_before_gameplay_marker")
	state.advance(0.000002)
	check(events == ["contact"], "contact_at_gameplay_marker")
	state.advance(CombatState.ATTACK_DURATION - state.attack_elapsed)
	check(events == ["contact", "finished"] and not state.is_attacking, "completion_at_gameplay_duration")
	check(not state.request_action(&"strike"), "cooldown_outlasts_visual_action")
	state.advance(0.32 - CombatState.ATTACK_DURATION + 0.000001)
	check(state.request_action(&"strike"), "new_action_after_point_32_seconds")
	state.advance(1.0)
	check(events.count("contact") == 2 and events.count("finished") == 2, "large_step_does_not_duplicate_contact_or_finish")
	var data: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://assets/temporary_mystara_rom/display/animations.json"))
	var ticks: Array = data.clips.attack.ticks
	var contact_ticks: int = 0
	var duration_ticks: int = 0
	for index in range(ticks.size()):
		duration_ticks += int(ticks[index])
		if index < int(data.clips.attack.contact_step):
			contact_ticks += int(ticks[index])
	check(is_equal_approx(CombatState.CONTACT_TIME, contact_ticks / float(data.capture_fps)) and is_equal_approx(CombatState.ATTACK_DURATION, duration_ticks / float(data.capture_fps)), "gameplay_timing_preserves_approved_source_cadence")

func _run_render_schedule(render_fps: int, with_presentation: bool) -> Dictionary:
	var state := CombatState.new()
	var hits: Array[bool] = []
	var accepted: Array[bool] = []
	var counts := {"contacts": 0, "finished": 0}
	state.strike_resolved.connect(func(hit: bool): hits.append(hit))
	state.strike_contact.connect(func(_facing: float): counts.contacts += 1)
	state.attack_finished.connect(func(): counts.finished += 1)
	var hero: Node2D
	var presentation: Node
	if with_presentation:
		hero = Node2D.new()
		var sprite := Sprite2D.new()
		sprite.name = "Visual"
		sprite.hframes = 27
		hero.add_child(sprite)
		presentation = FighterPresentation.new()
		hero.add_child(presentation)
		root.add_child(hero)
		presentation.set_process(false)
		presentation.bind_simulation(state)
	var tick: int = 0
	var accumulator: float = 0.0
	while tick < 120:
		accumulator += 1.0 / render_fps
		while accumulator + 0.00000001 >= STEP and tick < 120:
			match tick:
				0:
					state.hero_position = Vector2(280, 226)
					accepted.append(state.request_action(&"strike"))
				1, 12:
					accepted.append(state.request_action(&"strike"))
				2:
					state.set_movement_intent(Vector2.LEFT)
				3:
					check(state.facing_direction == 1.0 and state.hero_position.x < 280.0, "moving_attack_keeps_accepted_facing_%s_%s" % [render_fps, with_presentation])
				13:
					state.set_movement_intent(Vector2.ZERO)
				20:
					state.hero_position = Vector2(280, 226)
					state.facing_direction = 1.0
					accepted.append(state.request_action(&"strike"))
				45:
					state.hero_position = Vector2(140, 226)
					accepted.append(state.request_action(&"strike"))
				70:
					state.hero_position = Vector2(280, 190)
					accepted.append(state.request_action(&"strike"))
				95:
					state.hero_position = Vector2(280, 226)
					state.facing_direction = -1.0
					accepted.append(state.request_action(&"strike"))
			state.advance(STEP)
			accumulator -= STEP
			tick += 1
		if presentation != null:
			presentation._process(1.0 / render_fps)
	if hero != null:
		hero.free()
	return {"hits": hits, "accepted": accepted, "contacts": counts.contacts, "finished": counts.finished, "hero": state.hero_position, "goblin": state.goblin_position, "facing": state.facing_direction, "locked": state.is_attacking, "cooldown": state.strike_cooldown}
