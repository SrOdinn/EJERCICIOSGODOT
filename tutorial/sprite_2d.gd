extends Sprite2D

var speed = 200
var angular_speed = PI

func _process(delta: float) -> void:
	rotation += angular_speed * delta
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta

func _on_button_pressed() -> void:
	set_process(not is_processing())
