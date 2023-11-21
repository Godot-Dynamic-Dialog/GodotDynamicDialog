extends CharacterBody2D

@onready var player = $"../Player"
@onready var animationTree = get_tree().get_root().get_node("Main").get_node("skeleton").get_node("AnimationTree")

const speed = 25.0

func _physics_process(delta):
	#animationTree.set("parameters/Run/blend_position", axis)
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
