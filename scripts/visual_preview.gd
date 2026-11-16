extends Node2D
## Combat scene presentation and optional verification capture. No gameplay authority.

@onready var feedback: Label = $Feedback
@export var feedback_duration: float = 0.45
var _feedback_revision: int = 0

func _ready() -> void:
	print("COMBAT_TEST_READY platform=%s renderer=%s viewport=%s controls=WASD+J" % [OS.get_name(), RenderingServer.get_current_rendering_method(), get_viewport_rect().size])
	$Hero.movement_state_changed.connect($Hero/HeroAnimation.set_movement_state)
	$Hero.strike_requested.connect($Hero/HeroAnimation.play_attack)
	$Hero/HeroAnimation.strike_contact.connect($CombatResolver.resolve_strike)
	$Hero/HeroAnimation.attack_finished.connect($Hero.finish_attack)
	$CombatResolver.strike_resolved.connect(_show_result)
	var user_args := OS.get_cmdline_user_args()
	if "--capture-walk-sequence" in user_args:
		$Hero.set_process(false)
		$Hero.movement_state_changed.emit(true, 1.0)
		await _capture_walk_sequence()
	elif "--capture-preview" in user_args:
		await get_tree().create_timer(1.0).timeout
		await RenderingServer.frame_post_draw
		var frame := get_viewport().get_texture().get_image()
		var result := frame.save_png("/tmp/brawl-combat-native.png")
		print("COMBAT_CAPTURE result=%s size=%s" % [result, frame.get_size()])
		get_tree().quit(result)

func _capture_walk_sequence() -> void:
	var viewport_size := Vector2i(get_viewport_rect().size)
	var sequence := Image.create(viewport_size.x * 3, viewport_size.y, false, Image.FORMAT_RGBA8)
	var frame_indices: Array[int] = []
	for index in range(3):
		await RenderingServer.frame_post_draw
		var frame := get_viewport().get_texture().get_image()
		frame_indices.append($Hero/Visual.frame)
		sequence.blit_rect(frame, Rect2i(Vector2i.ZERO, viewport_size), Vector2i(index * viewport_size.x, 0))
		if index < 2:
			await get_tree().create_timer(0.126).timeout
	var result := sequence.save_png("/tmp/brawl-ax-native-walk.png")
	print("COMBAT_WALK_CAPTURE result=%s viewport=%s frames=%s" % [result, viewport_size, frame_indices])
	get_tree().quit(result)

func _show_result(did_hit: bool) -> void:
	_feedback_revision += 1
	var revision := _feedback_revision
	if did_hit:
		feedback.text = "HIT"
		feedback.modulate = Color(1.0, 0.75, 0.36)
	else:
		feedback.text = "MISS"
		feedback.modulate = Color(0.82, 0.82, 0.82)
	feedback.visible = true
	_hide_feedback_after_delay(revision)

func _hide_feedback_after_delay(revision: int) -> void:
	await get_tree().create_timer(feedback_duration).timeout
	if revision == _feedback_revision:
		feedback.visible = false
