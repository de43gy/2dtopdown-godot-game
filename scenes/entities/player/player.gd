extends CharacterBody2D

var max_speed = 120
var acceleration = .15

func _process(_delta):
	var target_velocity = max_speed * calc_direction()
	
	velocity = velocity.lerp(target_velocity, acceleration)
	print(velocity)
	move_and_slide()

func calc_direction ():
	var movement_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var movement_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(movement_x,movement_y).normalized()
