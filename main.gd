extends Node2D

func _ready() -> void:
	$RoundTimer.start()

func _on_player_interact_requested() -> void:
	print("Interacción recibida")

func _on_round_timer_timeout() -> void:
	$Player.set_process(false)
	$Player.set_process_unhandled_input(false)
	print("Fin de la ronda")
