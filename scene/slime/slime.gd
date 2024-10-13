extends CharacterBody2D

var max_speed = 80
var is_chasing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if is_chasing:
		var player = get_tree().get_nodes_in_group('player')[0] as Node2D
		if player:
			var direction = (player.global_position - global_position).normalized()
			velocity = direction * max_speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		is_chasing = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		is_chasing = false

func get_direction_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player != null:
		return (player.global_position - self.global_position).normalized()
	return Vector2.ZERO
