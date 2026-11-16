extends SceneTree
## Tests musical quantization and cleanup without claiming audible playback.

const Schedule = preload("res://scripts/money_shot_schedule.gd")
var failures: Array[String] = []


func check(condition: bool, label: String) -> void:
	print("MONEY_SHOT_CHECK %s=%s" % [label, condition])
	if not condition:
		failures.append(label)


func _initialize() -> void:
	_run.call_deferred()


func _run() -> void:
	var schedule := Schedule.new()
	check(not schedule.request(-1.0) and not schedule.request(INF), "reject_invalid_clock")
	check(schedule.request(0.25), "accept_finish")
	check(is_equal_approx(schedule.resolve_at, 2.0), "resolve_on_bar")
	check(not schedule.request(0.3), "reject_overlapping_finish")
	check(schedule.advance(0.25) == ["crescendo"], "start_midbar_crescendo")
	check(schedule.advance(1.99).is_empty(), "wait_for_music_not_gameplay_time")
	check(schedule.advance(2.01) == ["resolution"], "single_resolution")
	check(schedule.advance(2.1).is_empty(), "no_duplicate_resolution")
	check(schedule.advance(2.75) == ["restored"] and not schedule.active, "restore_after_tail")
	check(schedule.request(3.8) and is_equal_approx(schedule.resolve_at, 6.0), "late_request_keeps_crescendo_window")
	check(schedule.advance(3.9).is_empty(), "wait_for_next_crescendo")
	check(schedule.advance(4.03) == ["crescendo"], "start_next_bar_crescendo")
	check(schedule.cancel() and schedule.advance(6.8).is_empty(), "cancel_has_no_late_events")
	check(not schedule.cancel(), "cancel_idempotent")
	check(schedule.request(8.0) and schedule.advance(11.0) == ["crescendo", "resolution", "restored"], "large_clock_step_restores")
	await _test_runtime_cleanup()
	print("MONEY_SHOT_RESULTS failures=%s audible_browser_check_required=true" % [failures])
	quit.call_deferred(0 if failures.is_empty() else 1)


func _test_runtime_cleanup() -> void:
	var original_scale := Engine.time_scale
	Engine.time_scale = 0.8
	var scene = load("res://scenes/money_shot_lab.tscn").instantiate()
	root.add_child(scene)
	await process_frame
	scene.start_audio()
	scene.request_finish()
	check(is_equal_approx(Engine.time_scale, 0.16) and scene.camera.zoom.x > 1.0, "runtime_slow_and_zoom")
	scene.reset_lab()
	check(is_equal_approx(Engine.time_scale, 0.8) and scene.camera.zoom == Vector2.ONE and not scene.finish.playing, "reset_restores_captured_state")
	scene.request_finish()
	scene._notification(Node.NOTIFICATION_APPLICATION_FOCUS_OUT)
	check(is_equal_approx(Engine.time_scale, 0.8) and not scene.music.playing and not scene.schedule.active, "focus_loss_restores_and_stops_audio")
	scene.start_audio()
	scene.request_finish()
	scene.free()
	check(is_equal_approx(Engine.time_scale, 0.8), "scene_exit_restores_time")
	Engine.time_scale = original_scale
	# Audio mixing uses real time even with --fixed-fps. A SceneTreeTimer can
	# finish before a single mixer callback under that flag. Pump frames across
	# a bounded real-time interval so stopped playbacks release their streams.
	var release_until := Time.get_ticks_msec() + 200
	while Time.get_ticks_msec() < release_until:
		OS.delay_msec(2)
		await process_frame
