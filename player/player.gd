extends Sprite2D

var speed = 200

func _process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position += direction * speed * delta
