extends Node

@export var lair: PackedScene
@export var max_enemies: int = 5
@export var min_distance_from_player: float = 100

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	if lair == null:
		print("Error load lair = null")
		return
	
	print("prepare spawn")
	_spawn_lair(Vector2(100, 100))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _spawn_lair(position: Vector2):
	var lair_instance = lair.instantiate()
	lair_instance.position = position
	add_child(lair_instance)
	print("spawn lair")
	lair_instance.add_to_group("Lairs")
