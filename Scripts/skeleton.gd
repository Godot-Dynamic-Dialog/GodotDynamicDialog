extends CharacterBody2D

@onready var player = $"../Player"
@onready var animation_player = get_tree().get_root().get_node("Main").get_node("ghost").get_node("AnimationPlayer")

const SPEED = 25.0

func _physics_process(delta):
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * SPEED
	
	move_and_slide()
	
	if velocity.length() > 0:
		animation_player.play("forward")
