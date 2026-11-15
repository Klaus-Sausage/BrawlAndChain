extends Control
## Technical launch check only; not a gameplay prototype.

var _status: Label
var _elapsed: float = 0.0
var _clock: Label

func _ready() -> void:
	var panel := VBoxContainer.new()
	panel.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	panel.position = Vector2(-350, -160)
	panel.size = Vector2(700, 320)
	panel.add_theme_constant_override("separation", 22)
	add_child(panel)
	var title := Label.new()
	title.text = "BRAWL & CHAIN"
	title.add_theme_font_size_override("font_size", 36)
	panel.add_child(title)
	var details := Label.new()
	details.text = "Launch test only • No gameplay\nGodot %s • GDScript\nRenderer: %s • Platform: %s" % [Engine.get_version_info()["string"], RenderingServer.get_current_rendering_method(), OS.get_name()]
	details.add_theme_font_size_override("font_size", 20)
	panel.add_child(details)
	_clock = Label.new()
	panel.add_child(_clock)
	var button := Button.new()
	button.text = "Run launch check"
	button.pressed.connect(_confirm_launch)
	panel.add_child(button)
	_status = Label.new()
	_status.text = "Ready — click the button to check input."
	panel.add_child(_status)
	print("LAUNCH_READY platform=%s renderer=%s version=%s" % [OS.get_name(), RenderingServer.get_current_rendering_method(), Engine.get_version_info()["string"]])
	if "--smoke-test" in OS.get_cmdline_user_args():
		_run_native_smoke_test()

func _process(delta: float) -> void:
	_elapsed += delta
	_clock.text = "Running: %.1f seconds" % _elapsed

func _confirm_launch() -> void:
	_status.text = "PASS — GDScript input callback received."
	_status.modulate = Color(0.45, 1.0, 0.65)
	print("LAUNCH_INPUT_PASS")

func _run_native_smoke_test() -> void:
	await get_tree().create_timer(2.0).timeout
	await RenderingServer.frame_post_draw
	var capture := get_viewport().get_texture().get_image()
	var result := capture.save_png("/tmp/brawl-launch-native.png")
	print("LAUNCH_FRAME_CAPTURE result=%s size=%s" % [result, capture.get_size()])
	get_tree().quit(result)
