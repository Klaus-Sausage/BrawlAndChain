extends "res://scripts/combat_exchange.gd"
## Private combo lab. Controls and tuning are experimental, not final class kits.

const ComboState = preload("res://scripts/combo_combat_state.gd")
var combo := ComboState.new()
var _combo_label: Label
var _combo_label_left: float = 0.0
var _combo_cues: Node2D
var _sequence: Array[String] = []


func _enter_tree() -> void:
	exchange = combo
	super._enter_tree()


func _ready() -> void:
	super._ready()
	$ExchangeHelp.text = "WASD move  ·  J light  ·  L heavy  ·  hold K guard  ·  R reset  ·  F2 zone"
	_combo_label = Label.new()
	_combo_label.position = Vector2(150, 60)
	_combo_label.add_theme_font_size_override("font_size", 12)
	add_child(_combo_label)
	_combo_cues = Node2D.new()
	_combo_cues.draw.connect(_draw_combo_cues)
	add_child(_combo_cues)
	combo.combo_action_started.connect(_on_combo_action)
	combo.combo_input_buffered.connect(func(kind: StringName): print("COMBO_BUFFER kind=%s" % kind))
	combo.combo_knockback_applied.connect(func(distance: float): print("COMBO_KNOCKBACK distance=%s" % distance))
	print("COMBO_LAB_READY controls=J_light+L_heavy+K_guard+R_reset provisional=true")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"heavy_strike", false):
		$Hero.action_requested.emit(&"heavy_strike")
		get_viewport().set_input_as_handled()


func _process(delta: float) -> void:
	super._process(delta)
	_combo_label_left = maxf(0.0, _combo_label_left - delta)
	_combo_label.visible = _combo_label_left > 0.0
	if combo.is_attacking and combo.current_kind == &"heavy" and combo.hero_health > 0:
		$Hero/Visual.modulate = Color("ffc16a") if _hero_flash <= 0.0 else Color("ff7777")
	_combo_cues.queue_redraw()


func _on_combo_action(kind: StringName, step: int) -> void:
	if step == 1:
		_sequence.clear()
	_sequence.append("HEAVY" if kind == &"heavy" else "LIGHT")
	_combo_label.text = " > ".join(_sequence)
	_combo_label.modulate = Color("ffc16a") if kind == &"heavy" else Color.WHITE
	_combo_label_left = combo.action_duration() + 0.45
	print("COMBO_ACTION kind=%s step=%s" % [kind, step])


func _draw_combo_cues() -> void:
	if not combo.is_attacking or combo.current_kind != &"heavy":
		return
	var progress: float = clampf(combo.attack_elapsed / combo.action_contact_time(), 0.0, 1.0)
	var origin: Vector2 = combo.hero_position + Vector2(0, -32)
	var orientation: float = 0.0 if combo.attack_facing_direction > 0.0 else PI
	_combo_cues.draw_arc(origin, 30.0, orientation - PI / 2.0, orientation - PI / 2.0 + PI * progress, 24, Color("ffc16a"), 3.0)


func _on_reset() -> void:
	super._on_reset()
	_sequence.clear()
	if is_instance_valid(_combo_label):
		_combo_label.text = ""
	_combo_label_left = 0.0
