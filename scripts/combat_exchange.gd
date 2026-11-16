extends "res://scripts/visual_preview.gd"
## Private exchange presentation. Health and attack decisions stay in ExchangeState.

const ExchangeState = preload("res://scripts/combat_exchange_state.gd")
var exchange := ExchangeState.new()
var _hero_flash: float = 0.0
var _goblin_flash: float = 0.0
var _guard_flash: float = 0.0
var _enemy_lunge: float = 0.0
var _overlay: Node2D
var _end_prompt: Label


func _enter_tree() -> void:
	# The inherited resolver/animation bind this replacement during child ready.
	get_node("CombatResolver").simulation = exchange


func _ready() -> void:
	super._ready()
	$Goblin.set_process(false)
	exchange.enemy_windup_started.connect(func(facing: float): print("EXCHANGE_WINDUP facing=%s" % facing))
	exchange.enemy_attack_resolved.connect(_on_enemy_attack)
	exchange.actor_damaged.connect(_on_actor_damaged)
	exchange.encounter_finished.connect(_on_encounter_finished)
	exchange.encounter_reset.connect(_on_reset)
	_overlay = Node2D.new()
	_overlay.name = "ExchangeCues"
	_overlay.draw.connect(_draw_exchange_cues)
	add_child(_overlay)
	var help := Label.new()
	help.text = "WASD move  ·  J strike  ·  hold K guard  ·  R reset  ·  F2 hit zone"
	help.position = Vector2(10, 254)
	help.add_theme_font_size_override("font_size", 9)
	add_child(help)
	_end_prompt = Label.new()
	_end_prompt.position = Vector2(80, 76)
	_end_prompt.add_theme_font_size_override("font_size", 15)
	add_child(_end_prompt)
	print("COMBAT_EXCHANGE_READY controls=WASD+J+hold_K+R provisional=true")


func _input(event: InputEvent) -> void:
	if event.is_action(&"guard"):
		exchange.set_guard_intent(Input.is_action_pressed(&"guard"))
	if event.is_action_pressed(&"reset_exchange", false):
		exchange.reset_encounter()
		get_viewport().set_input_as_handled()


func _physics_process(_delta: float) -> void:
	exchange.set_guard_intent(Input.is_action_pressed(&"guard"))


func _process(delta: float) -> void:
	_hero_flash = maxf(0.0, _hero_flash - delta)
	_goblin_flash = maxf(0.0, _goblin_flash - delta)
	_guard_flash = maxf(0.0, _guard_flash - delta)
	_enemy_lunge = maxf(0.0, _enemy_lunge - delta)
	$Hero/Visual.modulate = Color("ff7777") if _hero_flash > 0.0 else Color.WHITE
	$Hero/Visual.scale = Vector2(1.0, 0.32) if exchange.hero_health <= 0 else Vector2.ONE
	if exchange.hero_health <= 0:
		$Hero/Visual.modulate = Color("87818d")
	$Goblin/Visual.modulate = Color("ff7777") if _goblin_flash > 0.0 else (Color("ffd05a") if exchange.enemy_phase == &"windup" else Color.WHITE)
	$Goblin/Visual.scale = Vector2(1.0, 0.28) if exchange.goblin_health <= 0 else Vector2.ONE
	if exchange.goblin_health <= 0:
		$Goblin/Visual.modulate = Color("87818d")
	$Goblin/Visual.flip_h = exchange.enemy_facing < 0.0
	# The lunge changes only the child sprite. Gameplay positions stay in state.
	$Goblin/Visual.position.x = exchange.enemy_facing * 9.0 * _enemy_lunge / 0.18
	_overlay.queue_redraw()


func _draw_exchange_cues() -> void:
	if exchange.enemy_phase == &"windup":
		var progress := clampf(1.0 - exchange.enemy_phase_left / exchange.enemy_windup, 0.0, 1.0)
		var target_x := exchange.goblin_position.x if exchange.enemy_facing > 0.0 else exchange.goblin_position.x - exchange.enemy_range
		_overlay.draw_rect(Rect2(target_x, exchange.goblin_position.y - exchange.lane_tolerance, exchange.enemy_range, exchange.lane_tolerance * 2.0), Color(1.0, 0.45, 0.12, 0.12 + progress * 0.20))
		_overlay.draw_arc(exchange.goblin_position + Vector2(0, -28), 14.0 + progress * 6.0, -PI / 2.0, -PI / 2.0 + TAU * progress, 32, Color("ffd05a"), 2.0)
	if exchange.is_guarding() or _guard_flash > 0.0:
		var orientation := 0.0 if exchange.facing_direction > 0.0 else PI
		_overlay.draw_arc(exchange.hero_position + Vector2(exchange.facing_direction * 8.0, -28), 23.0, orientation - PI / 2.0, orientation + PI / 2.0, 20, Color("80dfff") if _guard_flash <= 0.0 else Color.WHITE, 3.0)


func _on_enemy_attack(outcome: StringName) -> void:
	_enemy_lunge = 0.18
	if outcome == &"guarded":
		_guard_flash = 0.18
		feedback.text = "BLOCK"
		feedback.modulate = Color("80dfff")
	elif outcome == &"hit":
		feedback.text = "OUCH"
		feedback.modulate = Color("ff7777")
	else:
		feedback.text = "DODGED"
		feedback.modulate = Color("dddddd")
	_feedback_revision += 1
	feedback.visible = true
	_hide_feedback_after_delay(_feedback_revision)
	print("EXCHANGE_ENEMY_RESULT outcome=%s" % outcome)


func _on_actor_damaged(actor: StringName) -> void:
	if actor == &"hero":
		_hero_flash = 0.24
	else:
		_goblin_flash = 0.18
	print("EXCHANGE_DAMAGED actor=%s" % actor)


func _on_encounter_finished(winner: StringName) -> void:
	_end_prompt.text = "Goblin defeated — R to reset" if winner == &"hero" else "Defeated — R to retry"
	print("EXCHANGE_FINISHED winner=%s" % winner)


func _on_reset() -> void:
	_hero_flash = 0.0
	_goblin_flash = 0.0
	_guard_flash = 0.0
	_enemy_lunge = 0.0
	_feedback_revision += 1
	feedback.visible = false
	_end_prompt.text = ""
	print("EXCHANGE_RESET")
