extends Node

@export var slime_scene: PackedScene

var spawn_zone_size = 60
var lair_size = 15
var slime_max_count = 15
var slimes = []

func _on_timer_timeout() -> void:
	if slimes.size() < slime_max_count:
		spawn_slime()

func spawn_slime():
	var lair = get_parent() as Node2D
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_distance = randf_range(lair_size, spawn_zone_size)
	var spawn_position = lair.position + (random_direction * spawn_distance)
	
	var slime = slime_scene.instantiate() as Node2D
	slime.has_spawner = true
	slime.position = spawn_position
	
	add_child(slime)
	
	slime.tree_exited.connect(_on_slime_exited.bind(slime))
	
	slimes.append(slime)


func  _on_slime_exited(slime: Node) -> void:
	if slime != null and slime in slimes:
		slimes.erase(slime)
