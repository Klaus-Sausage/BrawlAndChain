extends Node2D
## Shows the exact front/range/lane test used by CombatResolver when toggled.

@export var toggle_key: Key = KEY_F2
@export var fill_color := Color(0.2, 0.95, 0.75, 0.16)
@export var edge_color := Color(0.25, 1.0, 0.8, 0.95)
@export var hit_color := Color(0.35, 1.0, 0.35, 1.0)
@export var miss_color := Color(1.0, 0.3, 0.25, 1.0)

@onready var hero: Node2D = get_parent().get_node("Hero")
@onready var goblin: Node2D = get_parent().get_node("Goblin")
@onready var resolver: Node = get_parent().get_node("CombatResolver")
var _visible_debug := false

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == toggle_key:
		_visible_debug = not _visible_debug
		queue_redraw()

func _process(_delta: float) -> void:
	if _visible_debug:
		queue_redraw()

func _draw() -> void:
	if not _visible_debug:
		return
	var h := to_local(hero.global_position)
	var g := to_local(goblin.global_position)
	var facing: float = resolver.simulation.facing_direction
	var reach := float(resolver.get("strike_range"))
	var lane := float(resolver.get("lane_tolerance"))
	var start_x := h.x if facing > 0.0 else h.x - reach
	var zone := Rect2(start_x, h.y - lane, reach, lane * 2.0)
	draw_rect(zone, fill_color, true)
	draw_rect(zone, edge_color, false, 1.0)
	draw_line(Vector2(h.x, h.y - lane - 5.0), Vector2(h.x, h.y + lane + 5.0), edge_color, 1.0)
	var checks: Dictionary = resolver.simulation.hit_checks(facing)
	var in_front: bool = checks.front
	var in_range: bool = checks.range
	var in_lane: bool = checks.lane
	var valid := in_front and in_range and in_lane
	draw_line(h, g, hit_color if valid else miss_color, 1.0)
	draw_circle(g, 3.0, hit_color if valid else miss_color)
	var font := ThemeDB.fallback_font
	draw_string(font, Vector2(10, 18), "HIT CHECK  (F2 toggles)", HORIZONTAL_ALIGNMENT_LEFT, -1, 10, Color.WHITE)
	draw_string(font, Vector2(10, 31), "FRONT %s   RANGE %s   LANE %s" % [_yes_no(in_front), _yes_no(in_range), _yes_no(in_lane)], HORIZONTAL_ALIGNMENT_LEFT, -1, 9, hit_color if valid else miss_color)
	draw_string(font, Vector2(10, 44), "reach %.0f px   lane +/- %.0f px   facing %s" % [reach, lane, "right" if facing > 0.0 else "left"], HORIZONTAL_ALIGNMENT_LEFT, -1, 9, Color.WHITE)

func _yes_no(value: bool) -> String:
	return "YES" if value else "NO"
