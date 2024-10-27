extends Node

@export var slime_scene: PackedScene

func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var player_screen = get_viewport().get_size()
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_distance

	if abs(random_direction.x) > abs(random_direction.y):
		spawn_distance = player_screen.x / 2
	else:
		spawn_distance = player_screen.y / 2
	
	var spawn_position = player.global_position + (random_direction * spawn_distance)
	
	var enemy = slime_scene.instantiate() as Node2D
	get_parent().add_child(enemy)
	enemy.global_position = spawn_position
