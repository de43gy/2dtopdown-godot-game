extends Node

@export var lair: PackedScene
@export var max_lairs: int = 5
@export var min_distance_from_player: float = 100

@onready var player = $Player

func _ready():
	# Инициализируем генератор случайных чисел
	randomize()

	# Проверяем, что сцена lair и объект игрока определены
	if lair == null:
		push_error("Lair scene is not assigned!")
		return
	if player == null:
		push_error("Player node is not found!")
		return

	# Создаем и настраиваем таймер для спавна
	var spawn_timer = Timer.new()
	spawn_timer.wait_time = randi_range(5, 20)
	spawn_timer.one_shot = false
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	add_child(spawn_timer)
	spawn_timer.start()

func _process(delta):
	pass

func _on_spawn_timer_timeout():
	# Проверяем количество lair на сцене
	if get_tree().get_nodes_in_group("Lairs").size() >= max_lairs:
		return

	# Получаем случайное место для спавна
	var spawn_position = _get_random_position()

	# Проверяем, что это место далеко от игрока
	if spawn_position.distance_to(player.position) < min_distance_from_player:
		return

	# Спавним новый объект
	_spawn_lair(spawn_position)

func _spawn_lair(position: Vector2):
	# Создаем экземпляр сцены lair
	var lair_instance = lair.instantiate()
	lair_instance.position = position
	add_child(lair_instance)
	lair_instance.add_to_group("Lairs")
	print("Spawned lair at position: ", position)

func _get_random_position() -> Vector2:
	# Генерируем случайные координаты в пределах экрана
	var level_size = get_viewport().size
	var random_x = randi_range(0, int(level_size.x))
	var random_y = randi_range(0, int(level_size.y))
	return Vector2(random_x, random_y)
