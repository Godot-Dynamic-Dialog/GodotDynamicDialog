extends CharacterBody2D

@onready var player = $"../Player"
@onready var animation_player = get_node("AnimationPlayer")

const SPEED = 35.0
var chase = false

func _physics_process(delta):
	if (chase):
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * SPEED
		move_and_slide()
		
		if velocity.length() > 0:
			animation_player.play("forward")

func chasePlayer():
	chase = true

func stopChase():
	chase = false

func take_damage():
	queue_free()

func _on_area_2d_body_entered(body):
	if (body.name == "Player"):
		chasePlayer()
		DialogueDatabase.call_dialogue = true

func _on_area_2d_body_exited(body):
	if (body.name == "Player"):
		animation_player.stop()
		stopChase()
