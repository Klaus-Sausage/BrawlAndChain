extends Node2D
## Human intent provider. Gameplay position, timing and outcomes belong to the simulation.

signal action_requested(action: StringName)

func movement_intent() -> Vector2:
	return Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"strike", false):
		action_requested.emit(&"strike")
