extends Node2D
## Static private art study. Only optional verification capture has runtime logic.

func _ready() -> void:
	print("VISUAL_PREVIEW_READY platform=%s renderer=%s viewport=%s" % [OS.get_name(), RenderingServer.get_current_rendering_method(), get_viewport_rect().size])
	if "--capture-preview" in OS.get_cmdline_user_args():
		await get_tree().create_timer(1.0).timeout
		await RenderingServer.frame_post_draw
		var frame := get_viewport().get_texture().get_image()
		var result := frame.save_png("/tmp/brawl-visual-native.png")
		print("VISUAL_PREVIEW_CAPTURE result=%s size=%s" % [result, frame.get_size()])
		get_tree().quit(result)
