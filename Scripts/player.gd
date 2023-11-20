extends CharacterBody2D
@onready var animation_player = $AnimationPlayer


@export var MAX_SPEED = 65
@export var ACCELERATION = 600
@export var FRICTION = 550

var axis = Vector2.ZERO
var player_attacking = false

func _physics_process(delta):
	if (Input.is_action_just_pressed("attack")):
		print("Attack")
	elif (!player_attacking):
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
				animation_player.play("right")
			else:
				animation_player.play("left")
		else:
			# Moving more vertically
			if axis.y > 0:
				animation_player.play("forward")
			else:
				animation_player.play("back")
	else:
		pass
		# No movement, stop the animation on the current frame
		#AnimatedSprite.stop()
		#AnimatedSprite.frame = 0	
