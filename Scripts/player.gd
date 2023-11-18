extends CharacterBody2D
@onready var AnimatedSprite = $Sprite


const MAX_SPEED = 65
const ACCELERATION = 600
const FRICTION = 550

var axis = Vector2.ZERO

func _physics_process(delta):
	move(delta)
	animate()

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
	
func animate():
	if axis != Vector2.ZERO:
		# Determine the primary direction of motion
		if abs(axis.x) > abs(axis.y):
			# Moving more horizontally
			if axis.x > 0:
				AnimatedSprite.play("right")
			else:
				AnimatedSprite.play("left")
		else:
			# Moving more vertically
			if axis.y > 0:
				AnimatedSprite.play("forward")
			else:
				AnimatedSprite.play("back")
	else:
		# No movement, stop the animation on the current frame
		AnimatedSprite.stop()
		AnimatedSprite.frame = 1	
