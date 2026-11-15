extends Node2D
## Combat scene presentation and optional verification capture. No gameplay authority.

@onready var feedback: Label = $Feedback
@export var feedback_duration: float = 0.45
var _feedback_revision: int = 0

func _ready() -> void:
	print("COMBAT_TEST_READY platform=%s renderer=%s viewport=%s controls=WASD+J" % [OS.get_name(), RenderingServer.get_current_rendering_method(), get_viewport_rect().size])
	$CombatResolver.strike_resolved.connect(_show_result)
	if "--capture-preview" in OS.get_cmdline_user_args():
		await get_tree().create_timer(1.0).timeout
		await RenderingServer.frame_post_draw
		var frame := get_viewport().get_texture().get_image()
		var result := frame.save_png("/tmp/brawl-combat-native.png")
		print("COMBAT_CAPTURE result=%s size=%s" % [result, frame.get_size()])
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
