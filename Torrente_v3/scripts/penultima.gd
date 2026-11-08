extends Node2D

func _draw() -> void:
	# Contraste sobre la alfombra y marcador para localizar la jarra.
	draw_circle(Vector2(0, -23), 33, Color(0.02, 0.08, 0.12, 0.88))
	draw_arc(Vector2(0, -23), 33, 0, TAU, 32, Color("65fff0"), 3)
	draw_colored_polygon(PackedVector2Array([Vector2(-9, -72), Vector2(9, -72), Vector2(0, -61)]), Color("65fff0"))

func can_collect(player: CharacterBody2D) -> bool:
	if global_position.distance_to(player.global_position) > 30:
		return false
	var ray := PhysicsRayQueryParameters2D.create(player.global_position, global_position, 1)
	return get_world_2d().direct_space_state.intersect_ray(ray).is_empty()
