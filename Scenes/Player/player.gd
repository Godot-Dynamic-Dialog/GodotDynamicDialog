extends CharacterBody2D
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

@onready var all_interactions = []
@onready var interactLabel = $InteractionComponents/Label

@onready var main_bgm = $"../main_bgm"
@onready var tavern_bgm = $"../tavern_bgm"
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
	if area.has_method("collect"):
		area.collect()
	if area.has_method("proximity"):
		area.proximity("on")
		
#SIGNAL ON AREA EXITED
func _on_interaction_area_area_exited(area):
	if area.has_method("proximity"):
		area.proximity("off")


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
		DialogueManager.update_context("player_hurt", 0)
		DialogueManager.update_context("player_healthy", 0)
		print(DialogueManager.get_context("player_hurt"))

#TRIGGERED WHEN PLAYER ENTERS TAVERN
func _on_tavern_body_entered(body):
	if (body.name == "Player"):
		#MUSIC IS ENABLED
		if(DialogueDatabase.bgm == 1):
			#records current playback position into variable before exiting
			DialogueDatabase.main_bgm_pos = main_bgm.get_playback_position()
			main_bgm.stop()
			
			#retrieves last playback position for that audio if exists. default is 0
			tavern_bgm.play()
			tavern_bgm.seek(DialogueDatabase.tavern_bgm_pos)
			
			
#TRIGERRED WHEN PLAYER EXITS TAVERN
func _on_tavern_body_exited(body):
	if (body.name == "Player"):
		#MUSIC IS ENABLED
		if(DialogueDatabase.bgm == 1):
			#records current playback position into variable before exiting
			DialogueDatabase.tavern_bgm_pos = tavern_bgm.get_playback_position()
			tavern_bgm.stop()
			
			#retrieves last playback position for that audio if exists. default is 0
			main_bgm.play()
			main_bgm.seek(DialogueDatabase.main_bgm_pos)
