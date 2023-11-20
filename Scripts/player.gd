extends CharacterBody2D
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

@export var MAX_SPEED = 65
@export var ACCELERATION = 600
@export var FRICTION = 550

var axis = Vector2.ZERO
var player_attacking = false

func _physics_process(delta):
	move(delta)

func get_input_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis.normalized()
	
func move(delta):
	axis = get_input_axis()
	
	if (axis == Vector2.ZERO):
		animation_state.travel("Idle")
		if (velocity.length() > (FRICTION * delta)):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector2.ZERO
	else: 
		animation_tree.set("parameters/Idle/blend_position", axis)
		animation_tree.set("parameters/Run/blend_position", axis)
		animation_state.travel("Run")
		velocity += (axis * ACCELERATION * delta)
		velocity = velocity.limit_length(MAX_SPEED)
	move_and_slide()
