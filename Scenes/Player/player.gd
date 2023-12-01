extends CharacterBody2D
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

@onready var all_interactions = []
@onready var interactLabel = $InteractionComponents/Label



@export var MAX_SPEED = 65
@export var ACCELERATION = 600
@export var FRICTION = 550

enum {
	MOVE,
	ATTACK
}

var state = MOVE
var axis = Vector2.ZERO
var player_attacking = false




func _physics_process(delta):
	match state:
		MOVE:
			move(delta)
		ATTACK:
			attack()

func get_input_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis.normalized()
	
func move(delta):
	axis = get_input_axis()
	#print(axis)
	if (axis == Vector2.ZERO):
		animation_state.travel("Idle")
		if (velocity.length() > (FRICTION * delta)):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector2.ZERO
	else: 
		animation_tree.set("parameters/Idle/blend_position", axis)
		animation_tree.set("parameters/Run/blend_position", axis)
		animation_tree.set("parameters/Attack/blend_position", axis)
		animation_state.travel("Run")
		velocity += (axis * ACCELERATION * delta)
		velocity = velocity.limit_length(MAX_SPEED)
	move_and_slide()
	
	if (Input.is_action_just_pressed("attack")):
		state = ATTACK

func attack():
	get_node("%Hitbox").visible = true
	velocity = Vector2.ZERO
	animation_state.travel("Attack")

func attack_animation_finished():
	state = MOVE
	get_node("%Hitbox").visible = false

func _on_hitbox_body_entered(body):
	if (body.has_method("take_damage") and (state == ATTACK)):
		body.take_damage()

#INTERACTION FUNCTIONS

#SIGNAL ON AREA ENTERED
func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()
	
	DialogueManager.increment_context("health", 10)
	DialogueManager.trigger_dialogue("health")
	print(DialogueManager.game_context)

#SIGNAL ON AREA EXITED
func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()

#function to update label
func update_interactions():
	if all_interactions:
		#grabs interct_label variable defined in each object
		interactLabel.text = all_interactions[0].interact_label
		
		#increment interact_counter variable
		all_interactions[0].interact_counter += 1
		#debugging output
		print(all_interactions[0].interact_counter)
	else:
		interactLabel.text = ""

func _ready():
	self.global_position = Global.player_map_position
