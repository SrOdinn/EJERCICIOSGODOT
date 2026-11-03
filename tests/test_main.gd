extends SceneTree

var failures: int = 0

func check(condition: bool, description: String) -> void:
	if condition:
		print("OK: " + description)
	else:
		failures += 1
		push_error(description)

func _initialize() -> void:
	call_deferred("run_tests")

func run_tests() -> void:
	var scene = load("res://main.tscn")
	var main = scene.instantiate()
	root.add_child(main)
	var player = main.get_node("Player")
	var target = main.get_node("Target")
	var timer = main.get_node("RoundTimer")
	var label = main.get_node("StatusLabel")
	check(main.score == 0 and label.text == "Puntos: 0", "Inicio con cero puntos")
	check(timer.one_shot and not timer.autostart and timer.wait_time == 30.0, "Timer de 30 segundos")
	check(target.position.x >= main.left_limit and target.position.x <= main.right_limit and target.position.y == player.position.y, "Objetivo inicial dentro de limites")
	player.position = Vector2(100, 270)
	target.position = Vector2(400, 270)
	player.interact_requested.emit()
	check(main.score == 0, "Lejos no suma")
	target.position = player.position + Vector2(30, 0)
	main.interaction_radius = 1.0
	player.interact_requested.emit()
	check(main.score == 0, "Fallo reproducido: distancia 30, radio 1, no suma")
	main.interaction_radius = 48.0
	player.interact_requested.emit()
	check(main.score == 1 and label.text == "Puntos: 1", "Radio corregido a 48: suma uno")
	check(target.position.x >= main.left_limit and target.position.x <= main.right_limit and target.position.y == player.position.y, "Recolocacion tras acierto")
	target.position = player.position + Vector2(48, 0)
	player.interact_requested.emit()
	check(main.score == 2, "Distancia igual al radio suma")
	target.position = player.position + Vector2(48.1, 0)
	player.interact_requested.emit()
	check(main.score == 2, "Fuera del radio no suma")
	timer.start(0.05)
	await timer.timeout
	await process_frame
	check(not main.playing and not player.is_processing() and not player.is_processing_unhandled_input(), "Timeout real bloquea jugador")
	check(label.text == "Fin: 2 puntos", "Resultado final")
	var final_target: Vector2 = target.position
	player.position = target.position
	player.interact_requested.emit()
	check(main.score == 2 and target.position == final_target and label.text == "Fin: 2 puntos", "Senal despues del final no cambia resultado ni objetivo")
	main.free()
	main = scene.instantiate()
	root.add_child(main)
	check(main.score == 0 and main.playing and main.get_node("Player").is_processing(), "Nueva escena reinicia ronda")
	main.free()
	print("Fallos: ", failures)
	quit(0 if failures == 0 else 1)
