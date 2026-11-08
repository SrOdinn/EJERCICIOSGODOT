extends CharacterBody2D

const SPEED := 240.0
var turbo := 0.0
var playing := true
var facing := "down"
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	var frames := SpriteFrames.new()
	frames.remove_animation("default")
	var sheet := preload("res://assets/torrente.png")
	for row in 3:
		var animation: String = ["down", "up", "right"][row]
		frames.add_animation(animation)
		frames.set_animation_speed(animation, 8.0)
		for col in 3:
			var texture := AtlasTexture.new()
			texture.atlas = sheet
			texture.region = Rect2(416 + col * 268, row * 248, 176, 240)
			frames.add_frame(animation, texture)
	sprite.sprite_frames = frames
	sprite.animation = "down"

func _physics_process(delta: float) -> void:
	if not playing:
		velocity = Vector2.ZERO
		sprite.stop()
		return
	turbo = maxf(0.0, turbo - delta)
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED * speed_multiplier()
	move_and_slide()
	if direction != Vector2.ZERO:
		if direction.x != 0:
			facing = "right"
			sprite.flip_h = direction.x < 0
		else:
			facing = "up" if direction.y < 0 else "down"
			sprite.flip_h = false
		sprite.speed_scale = speed_multiplier()
		sprite.play(facing)
	else:
		sprite.stop()
		sprite.frame = 0

func speed_multiplier() -> float:
	return 2.0 if turbo > 0.0 else 1.0
