extends CharacterBody2D


const MAX_SPEED = 65
const ACCELERATION = 600
const FRICTION = 550

var axis = Vector2.ZERO

func _physics_process(delta):
	move(delta)

func get_input_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis.normalized()
	
func move(delta):
	axis = get_input_axis()
	
	if (axis == Vector2.ZERO):
		if (velocity.length() > (FRICTION * delta)):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector2.ZERO
	else: 
		velocity += (axis * ACCELERATION * delta)
		velocity = velocity.limit_length(MAX_SPEED)
	move_and_slide()
