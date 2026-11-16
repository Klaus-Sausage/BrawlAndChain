extends Node2D
## Temporary visual comparison only. It does not touch gameplay state.

const AX_IDLE_FRAME := 0
const AX_WALK_FIRST_FRAME := 1
const AX_WALK_FRAME_COUNT := 3
const AX_ATTACK_FIRST_FRAME := 4
const AX_ATTACK_FRAME_COUNT := 4
const FIGHTER_IDLE_FRAME := 0
const FIGHTER_WALK_FIRST_FRAME := 1
const FIGHTER_WALK_FRAME_COUNT := 12
const FIGHTER_ATTACK_FIRST_FRAME := 13
const FIGHTER_ATTACK_FRAME_COUNT := 9
const WALK_FPS := 8.0
const ATTACK_FPS := 12.0

@onready var ax_visual: Sprite2D = $AxBattler/Visual
@onready var fighter_visual: Sprite2D = $MystaraFighter/Visual

var _mode: String = "idle"
var _mode_time: float = 0.0

func _ready() -> void:
	print("HERO_ART_COMPARISON_READY viewport=%s controls=1-idle,2-walk,3-attack; source=mystara-reference-atlas" % get_viewport_rect().size)
	_set_mode("idle")
	var args := OS.get_cmdline_user_args()
	for mode in ["idle", "walk", "attack"]:
		var capture_arg := "--capture-comparison-%s" % mode
		if capture_arg in args:
			_set_mode(mode)
			_capture_after_delay(mode)
			return

func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.pressed or event.echo:
		return
	match event.keycode:
		KEY_1:
			_set_mode("idle")
		KEY_2:
			_set_mode("walk")
		KEY_3:
			_set_mode("attack")

func _process(delta: float) -> void:
	_mode_time += delta
	match _mode:
		"walk":
			var walk_step := int(_mode_time * WALK_FPS)
			ax_visual.frame = AX_WALK_FIRST_FRAME + walk_step % AX_WALK_FRAME_COUNT
			fighter_visual.frame = FIGHTER_WALK_FIRST_FRAME + walk_step % FIGHTER_WALK_FRAME_COUNT
		"attack":
			var attack_step := int(_mode_time * ATTACK_FPS)
			ax_visual.frame = AX_ATTACK_FIRST_FRAME + mini(attack_step, AX_ATTACK_FRAME_COUNT - 1)
			fighter_visual.frame = FIGHTER_ATTACK_FIRST_FRAME + mini(attack_step, FIGHTER_ATTACK_FRAME_COUNT - 1)
			if _mode_time >= float(FIGHTER_ATTACK_FRAME_COUNT) / ATTACK_FPS:
				_set_mode("idle")

func _set_mode(mode: String) -> void:
	_mode = mode
	_mode_time = 0.0
	match _mode:
		"idle":
			ax_visual.frame = AX_IDLE_FRAME
			fighter_visual.frame = FIGHTER_IDLE_FRAME
		"walk":
			ax_visual.frame = AX_WALK_FIRST_FRAME
			fighter_visual.frame = FIGHTER_WALK_FIRST_FRAME
		"attack":
			ax_visual.frame = AX_ATTACK_FIRST_FRAME
			fighter_visual.frame = FIGHTER_ATTACK_FIRST_FRAME
	$Title.text = "HERO ART COMPARISON  ·  1 IDLE   2 WALK   3 ATTACK  ·  %s" % _mode.to_upper()

func _capture_after_delay(mode: String) -> void:
	await get_tree().create_timer(0.75).timeout
	await RenderingServer.frame_post_draw
	var image := get_viewport().get_texture().get_image()
	var path := "/tmp/brawl-hero-comparison-%s.png" % mode
	var result := image.save_png(path)
	print("HERO_COMPARISON_CAPTURE mode=%s result=%s size=%s path=%s" % [mode, result, image.get_size(), path])
	get_tree().quit(result)
