extends Node2D

const MAP := preload("res://scenes/casino.tscn")
const PLAYER := preload("res://scenes/player.tscn")
const MUG := preload("res://scenes/penultima.tscn")
var current_map: Node2D
var player: CharacterBody2D
var mug: Node2D
var score := 0
var remaining := 60.0
var playing := false
var hud: Control
var clock_label: Label
var score_label: Label
var turbo_label: Label
var end_panel: PanelContainer
var end_label: Label

func _ready() -> void:
	var bindings := {"move_left": [KEY_A, KEY_LEFT], "move_right": [KEY_D, KEY_RIGHT], "move_up": [KEY_W, KEY_UP], "move_down": [KEY_S, KEY_DOWN], "restart": [KEY_R]}
	for action in bindings:
		InputMap.add_action(action)
		for code in bindings[action]:
			var key := InputEventKey.new()
			key.physical_keycode = code
			InputMap.action_add_event(action, key)
	current_map = MAP.instantiate()
	current_map.position = Vector2(0, 112)
	add_child(current_map)
	player = PLAYER.instantiate()
	current_map.add_child(player)
	mug = MUG.instantiate()
	current_map.add_child(mug)
	build_hud()
	start_round()

func start_round() -> void:
	player.position = Vector2(768, 960)
	player.velocity = Vector2.ZERO
	player.turbo = 0.0
	player.playing = true
	player.sprite.stop()
	player.sprite.animation = "down"
	player.sprite.flip_h = false
	player.sprite.frame = 0
	score = 0
	remaining = 60.0
	playing = true
	end_panel.hide()
	mug.show()
	spawn_mug()
	update_hud()

func spawn_mug() -> void:
	var candidates: Array[Vector2] = []
	for point in current_map.mug_points:
		if point.distance_to(player.position) >= 160:
			candidates.append(point)
	mug.position = candidates.pick_random()

func _physics_process(delta: float) -> void:
	if not playing:
		return
	remaining = maxf(0.0, remaining - delta)
	if remaining <= 0.0:
		playing = false
		player.playing = false
		player.velocity = Vector2.ZERO
		mug.hide()
		end_label.text = "SE ACABÓ LA RONDA\n\n%d PUNTOS" % score
		end_panel.show()
	elif mug.can_collect(player):
		score += 1
		player.turbo += 2.0
		spawn_mug()
	update_hud()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart") and not event.is_echo():
		start_round()

func update_hud() -> void:
	clock_label.text = "%02d s" % ceili(remaining)
	score_label.text = "%02d PUNTOS" % score
	turbo_label.text = "TURBO ×2  %.1f s" % player.turbo
	clock_label.modulate = Color("ff8c75") if remaining <= 10 else Color.WHITE

func make_label(value: String, pos: Vector2, size: int, color: Color) -> Label:
	var label := Label.new()
	label.text = value
	label.position = pos
	label.add_theme_font_size_override("font_size", size)
	label.add_theme_color_override("font_color", color)
	hud.add_child(label)
	return label

func build_hud() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)
	hud = Control.new()
	hud.mouse_filter = Control.MOUSE_FILTER_IGNORE
	layer.add_child(hud)
	make_label("TORRENTE", Vector2(28, 4), 38, Color("f6d58e"))
	make_label("LA ÚLTIMA RONDA", Vector2(255, 20), 18, Color("cfae81"))
	make_label("AL CASI, PERO NO", Vector2(28, 59), 28, Color("f5e7d0"))
	clock_label = make_label("", Vector2(792, 16), 38, Color("f6d58e"))
	score_label = make_label("", Vector2(944, 20), 28, Color("f5e7d0"))
	turbo_label = make_label("", Vector2(1208, 15), 23, Color("9edbbd"))
	make_label("WASD / FLECHAS  Mover     Recogida automática     +2 s de turbo por jarra     R  Reiniciar", Vector2(28, 1144), 21, Color("d1bdab"))
	end_panel = PanelContainer.new()
	end_panel.position = Vector2(448, 400)
	end_panel.custom_minimum_size = Vector2(640, 320)
	var style := StyleBoxFlat.new()
	style.bg_color = Color("221b28")
	style.border_color = Color("e9bd68")
	style.set_border_width_all(4)
	style.set_content_margin_all(32)
	end_panel.add_theme_stylebox_override("panel", style)
	hud.add_child(end_panel)
	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 24)
	end_panel.add_child(box)
	end_label = Label.new()
	end_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	end_label.add_theme_font_size_override("font_size", 30)
	box.add_child(end_label)
	var button := Button.new()
	button.text = "OTRA PENÚLTIMA  ·  [R]"
	button.add_theme_font_size_override("font_size", 24)
	button.pressed.connect(start_round)
	box.add_child(button)
