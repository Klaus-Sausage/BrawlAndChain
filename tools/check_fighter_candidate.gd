extends SceneTree
var scene: Node
var hits: Array[bool] = []
var contacts: Array[int] = []
var accepted: int = 0
var failures: Array[String] = []

func _initialize() -> void:
	_run.call_deferred()

func key(code: Key, pressed: bool, echo: bool = false) -> void:
	var event := InputEventKey.new()
	event.keycode = code
	event.pressed = pressed
	event.echo = echo
	Input.parse_input_event(event)

func frames(count: int) -> void:
	for i in range(count):
		await process_frame

func check(ok: bool, label: String) -> void:
	print("CANDIDATE_CHECK %s=%s" % [label, ok])
	if not ok:
		failures.append(label)

func strike_at(pos: Vector2, facing: float, expected: bool, label: String) -> void:
	scene.get_node("Hero").position = pos
	key(KEY_D if facing > 0 else KEY_A, true)
	await frames(2)
	key(KEY_D if facing > 0 else KEY_A, false)
	await frames(24)
	var before := hits.size()
	key(KEY_J, true)
	await frames(5)
	key(KEY_J, false)
	await frames(20)
	check(hits.size() == before + 1 and hits.back() == expected, label)

func _run() -> void:
	scene = load("res://scenes/fighter_candidate.tscn").instantiate()
	root.add_child(scene)
	current_scene = scene
	await frames(2)
	var hero = scene.get_node("Hero")
	var anim = scene.get_node("Hero/HeroAnimation")
	var visual = scene.get_node("Hero/Visual")
	scene.get_node("CombatResolver").strike_resolved.connect(func(hit: bool): hits.append(hit))
	anim.strike_contact.connect(func(_facing: float): contacts.append(visual.frame))
	hero.strike_requested.connect(func(_facing: float): accepted += 1)
	await frames(90)
	key(KEY_D, true)
	var seen: Array[int] = []
	for i in range(48):
		await frames(1)
		if visual.frame >= 4 and visual.frame <= 16 and visual.frame not in seen: seen.append(visual.frame)
	key(KEY_D, false)
	await frames(3)
	print("WALK_OBSERVED ", seen, " stopped_frame=", visual.frame)
	check(seen.size() == 13 and visual.frame < 4, "walk_all_poses_then_idle")
	check(visual.flip_h, "face_right")
	key(KEY_A, true)
	await frames(8)
	key(KEY_A, false)
	check(not visual.flip_h, "face_left")
	await strike_at(Vector2(280,226), 1, true, "close_hit")
	await strike_at(Vector2(140,226), 1, false, "distant_miss")
	await strike_at(Vector2(280,226), -1, false, "facing_away_miss")
	await strike_at(Vector2(280,190), 1, false, "wrong_lane_miss")
	hero.position = Vector2(280,226)
	key(KEY_D,true)
	await frames(2)
	var start: Vector2 = hero.position
	var before := accepted
	key(KEY_J,true)
	await frames(5)
	key(KEY_D,false)
	key(KEY_A,true)
	await frames(3)
	check(accepted == before+1 and hero.position != start and visual.flip_h, "moving_swing_repeat_lock_facing")
	key(KEY_J,false)
	key(KEY_A,false)
	await frames(24)
	key(KEY_J,true)
	await frames(3)
	key(KEY_J,false)
	await frames(20)
	check(accepted == before+2, "next_swing_after_finish")
	check(contacts.all(func(f: int): return f==22), "contact_at_atlas_22")
	hero.position = Vector2(479,269)
	key(KEY_D,true);key(KEY_S,true)
	await frames(4)
	key(KEY_D,false);key(KEY_S,false)
	check(hero.position.x <=456 and hero.position.y<=246, "arena_bounds")
	hero.position = Vector2(140,226)
	await frames(45)
	var held_before := accepted
	key(KEY_J, true)
	for i in range(7):
		await frames(10)
		key(KEY_J, true, true)
	check(accepted == held_before + 1, "hold_j_only_one_attack")
	key(KEY_J, false)
	await frames(25)
	key(KEY_J, true)
	await frames(1)
	key(KEY_J, false)
	check(accepted == held_before + 2, "separate_tap_starts_next_attack")
	await frames(45)
	print("CANDIDATE_RESULTS hits=%s contacts=%s failures=%s" % [hits,contacts,failures])
	quit(0 if failures.is_empty() else 1)
