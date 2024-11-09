extends Node

@export var lair: PackedScene
@export var max_lairs: int = 5
@export var min_distance_from_player: float = 100

@onready var player = $Player

func _ready():
	randomize()

	if lair == null:
		push_error("Lair scene is not assigned!")
		return
	if player == null:
		push_error("Player node is not found!")
		return

	var spawn_timer = Timer.new()
	spawn_timer.wait_time = randi_range(5, 20)
	spawn_timer.one_shot = false
	spawn_timer.connect("timeout", Callable(self, "on_spawn_timer_timeout"))
	add_child(spawn_timer)
	spawn_timer.start()

func _process(_delta):
	pass

func on_spawn_timer_timeout():
	if get_tree().get_nodes_in_group("Lairs").size() >= max_lairs:
		return

	var spawn_position = get_random_position()

	if spawn_position.distance_to(player.position) < min_distance_from_player:
		return

	spawn_lair(spawn_position)

func spawn_lair(position: Vector2):
	var lair_instance = lair.instantiate()
	lair_instance.position = position
	add_child(lair_instance)
	lair_instance.add_to_group("Lairs")

func get_random_position() -> Vector2:
	var level_size = get_viewport().size
	var random_x = randi_range(0, int(level_size.x))
	var random_y = randi_range(0, int(level_size.y))
	return Vector2(random_x, random_y)
