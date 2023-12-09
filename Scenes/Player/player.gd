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
	
	
	if area.has_method("collect"):
		area.collect()
		
#SIGNAL ON AREA EXITED
func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()

#function to update label
func update_interactions():
	if all_interactions:
		#grabs interct_label variable defined in each object
		interactLabel.text = all_interactions[0].interact_label
		
	else:
		interactLabel.text = ""


#had to have this down here elsewise it caused issues with above code
#allows the position of the player to be manipulated, used by portals (doorways)
func _ready():
	self.global_position = Global.player_map_position



func _on_area_2d_body_entered(body):
	if (body.is_in_group("mobs")):
		DialogueManager.update_health(-10)
		if DialogueManager.player_health <= 0:
			DialogueManager.player_health = 0
			print("Player health at 0, use your imagination for the player fainting like Pokemon")
		DialogueManager.update_context("player_hurt", true)
		DialogueManager.remove_context("player_healthy")
		print(DialogueManager.get_context("player_hurt"))
