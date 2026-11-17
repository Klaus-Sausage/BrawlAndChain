extends Node2D
## Isolated browser feasibility lab, not combat authority or final game UI.
## The base music keeps its transport/pitch while only gameplay time slows.

const Schedule = preload("res://scripts/money_shot_schedule.gd")
const LOOP = preload("res://assets/audio_lab/tonic_loop.wav")
const OVERLAY = preload("res://assets/audio_lab/finish_overlay.wav")
const LOOP_SECONDS: float = 4.0
const LAB_SLOWDOWN: float = 0.2
const LAB_ZOOM: float = 1.22

var schedule := Schedule.new()
var music: AudioStreamPlayer
var finish: AudioStreamPlayer
var camera: Camera2D
var status: Label
var readout: Label
var start_button: Button
var trigger_button: Button
var _started: bool = false
var _music_loops: int = 0
var _last_music_phase: float = 0.0
var _music_seconds: float = 0.0
var _saved_time_scale: float = 1.0
var _saved_zoom: Vector2 = Vector2.ONE
var _simulation_distance: float = 0.0
var _last_resolution_late_ms: float = 0.0
var _finish_count: int = 0
var _crescendo_count: int = 0


func _ready() -> void:
	_saved_time_scale = Engine.time_scale
	camera = Camera2D.new()
	camera.position = Vector2(240, 135)
	add_child(camera)
	_saved_zoom = camera.zoom
	music = AudioStreamPlayer.new()
	music.name = "BaseMusic"
	var loop := LOOP.duplicate() as AudioStreamWAV
	loop.loop_mode = AudioStreamWAV.LOOP_FORWARD
	loop.loop_begin = 0
	loop.loop_end = roundi(LOOP_SECONDS * float(loop.mix_rate))
	music.stream = loop
	music.playback_type = AudioServer.PLAYBACK_TYPE_STREAM
	music.volume_db = -5.0
	add_child(music)
	finish = AudioStreamPlayer.new()
	finish.name = "AdaptiveOverlay"
	finish.stream = OVERLAY
	finish.playback_type = AudioServer.PLAYBACK_TYPE_STREAM
	finish.volume_db = -3.0
	add_child(finish)
	_build_ui()
	print("MONEY_SHOT_LAB_READY platform=%s playback=Stream bpm=120 original_audio=true" % OS.get_name())
	queue_redraw()


func _build_ui() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	var panel := Control.new()
	panel.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	layer.add_child(panel)
	_label(panel, "MONEY SHOT — browser audio/time lab", Vector2(16, 8), 17)
	_label(panel, "Technical placeholder • 120 BPM • no final music style", Vector2(16, 30), 10)
	start_button = _button(panel, "Start audio", Vector2(16, 49), Vector2(106, 28), start_audio)
	trigger_button = _button(panel, "Test finish", Vector2(130, 49), Vector2(106, 28), request_finish)
	trigger_button.disabled = true
	_button(panel, "Reset", Vector2(244, 49), Vector2(75, 28), reset_lab)
	_button(panel, "Preview", Vector2(327, 49), Vector2(75, 28), _return_to_preview)
	status = _label(panel, "Press Start audio, then Test finish. Headphones help.", Vector2(16, 83), 11)
	_label(panel, "The marker slows; the music keeps its beat and resolves on a bar.", Vector2(16, 215), 10)
	readout = _label(panel, "", Vector2(16, 231), 10)
	_label(panel, "Focus loss stops audio and restores time/camera; click Start to resume.", Vector2(16, 249), 9)


func _label(parent: Node, text: String, at: Vector2, size: int) -> Label:
	var label := Label.new()
	label.text = text
	label.position = at
	label.add_theme_font_size_override("font_size", size)
	parent.add_child(label)
	return label


func _button(parent: Node, text: String, at: Vector2, size: Vector2, callback: Callable) -> Button:
	var button := Button.new()
	button.text = text
	button.position = at
	button.size = size
	button.add_theme_font_size_override("font_size", 12)
	button.pressed.connect(callback)
	parent.add_child(button)
	return button


func start_audio() -> void:
	# Called only by the visible button's input gesture, so web audio can unlock.
	if _started:
		return
	_music_loops = 0
	_last_music_phase = 0.0
	_music_seconds = 0.0
	music.play()
	_started = true
	start_button.disabled = true
	trigger_button.disabled = false
	status.text = "Listen for the loop, then request a finish at any beat."
	print("MONEY_SHOT_AUDIO_STARTED gesture=true")


func request_finish() -> void:
	if not _started:
		return
	_update_music_clock()
	if not schedule.request(_music_seconds):
		print("MONEY_SHOT_IGNORED reason=already_active")
		return
	_saved_time_scale = Engine.time_scale
	_saved_zoom = camera.zoom
	Engine.time_scale = _saved_time_scale * LAB_SLOWDOWN
	camera.zoom = _saved_zoom * LAB_ZOOM
	trigger_button.disabled = true
	status.text = "Slowdown + zoom; musical resolution queued for the next bar."
	print("MONEY_SHOT_REQUEST music=%.4f resolve=%.4f slowdown=%.2f" % [_music_seconds, schedule.resolve_at, Engine.time_scale])
	_advance_schedule()


func _process(delta: float) -> void:
	_simulation_distance = fmod(_simulation_distance + delta * 100.0, 320.0)
	if _started:
		_update_music_clock()
		_advance_schedule()
	var beat := int(_music_seconds / Schedule.BEAT_SECONDS) % 4 + 1
	readout.text = "Beat %d/4  •  music %.2fs  •  time ×%.2f  •  finishes %d  •  event late %.1fms" % [beat, _music_seconds, Engine.time_scale, _finish_count, _last_resolution_late_ms]
	queue_redraw()


func _update_music_clock() -> void:
	# Playback position is the music clock; frame delta and Engine.time_scale
	# never drive it. Clamp backwards movement caused by mix-time estimates.
	var phase := music.get_playback_position()
	if phase + LOOP_SECONDS * 0.5 < _last_music_phase:
		_music_loops += 1
	_last_music_phase = phase
	var estimate := float(_music_loops) * LOOP_SECONDS + phase + AudioServer.get_time_since_last_mix()
	_music_seconds = maxf(_music_seconds, estimate)


func _advance_schedule() -> void:
	var events := schedule.advance(_music_seconds)
	for event in events:
		if event == "crescendo":
			# Seeking compensates for the render-frame scheduling delay. The
			# prepared overlay resolves at its 2s point against the base bar.
			var offset := maxf(0.0, _music_seconds - schedule.overlay_at)
			if offset < OVERLAY.get_length():
				finish.play(offset)
			_crescendo_count += 1
			print("MONEY_SHOT_CRESCENDO music=%.4f seek=%.4f" % [_music_seconds, offset])
		elif event == "resolution":
			_last_resolution_late_ms = maxf(0.0, (_music_seconds - schedule.resolve_at) * 1000.0)
			_finish_count += 1
			status.text = "Tonic sting resolved into the continuing track."
			print("MONEY_SHOT_RESOLUTION count=%d music=%.4f target=%.4f event_late_ms=%.2f" % [_finish_count, _music_seconds, schedule.resolve_at, _last_resolution_late_ms])
		elif event == "restored":
			_restore_presentation()
			status.text = "Time and camera restored. Repeat at a different beat, or Reset."
			print("MONEY_SHOT_RESTORED reason=complete time_scale=%.4f zoom=%.4f" % [Engine.time_scale, camera.zoom.x])


func reset_lab() -> void:
	var was_active := schedule.cancel()
	finish.stop()
	_restore_presentation()
	_simulation_distance = 0.0
	status.text = "Reset: base track continues; camera and time restored."
	print("MONEY_SHOT_RESTORED reason=reset interrupted=%s time_scale=%.4f zoom=%.4f" % [was_active, Engine.time_scale, camera.zoom.x])


func _restore_presentation() -> void:
	Engine.time_scale = _saved_time_scale
	if is_instance_valid(camera):
		camera.zoom = _saved_zoom
	if is_instance_valid(trigger_button):
		trigger_button.disabled = not _started


func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT and is_instance_valid(music):
		reset_lab()
		music.stop()
		_started = false
		start_button.disabled = false
		trigger_button.disabled = true
		status.text = "Audio stopped on focus loss. Press Start audio to resume."
		print("MONEY_SHOT_FOCUS_LOST restored=true audio_stopped=true")


func _exit_tree() -> void:
	schedule.cancel()
	_restore_presentation()
	if is_instance_valid(music):
		music.stop()
		music.stream = null
	if is_instance_valid(finish):
		finish.stop()
		finish.stream = null


func _return_to_preview() -> void:
	reset_lab()
	get_tree().change_scene_to_file("res://scenes/visual_preview.tscn")


func _draw() -> void:
	draw_rect(Rect2(-60, -40, 600, 350), Color("171c2b"))
	draw_rect(Rect2(20, 113, 440, 91), Color("273348"))
	for index in range(9):
		draw_line(Vector2(35 + index * 50, 113), Vector2(35 + index * 50, 204), Color("36445b"))
	draw_line(Vector2(20, 189), Vector2(460, 189), Color("64758e"), 2.0)
	draw_circle(Vector2(80 + _simulation_distance, 174), 11, Color("e4b45a"))
	draw_line(Vector2(70, 198), Vector2(410, 198), Color("77879e"), 1.0)
	var beat := int(_music_seconds / Schedule.BEAT_SECONDS) % 4
	for index in range(4):
		draw_circle(Vector2(190 + index * 32, 130), 6.0, Color("e4b45a") if _started and index == beat else Color("64758e"))
	if schedule.resolved and schedule.active:
		var age := maxf(0.0, _music_seconds - schedule.resolve_at)
		for index in range(14):
			var angle := float(index) * 2.4
			var distance := 10.0 + age * (35.0 + float(index) * 4.0)
			var origin := Vector2(320, 165)
			var end := origin + Vector2(cos(angle), sin(angle) * 0.6) * distance
			draw_line(end, end + Vector2(3, 3), Color("c3424f"), 3.0)
