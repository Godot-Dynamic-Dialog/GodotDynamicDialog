extends CharacterBody2D

@onready var player = $"../Player"

const SPEED = 75.0
var chase = false
var player_detect = null


func _physics_process(delta):
	$AnimatedSprite2D.play("forward and idle")
	if chase:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * SPEED
		move_and_slide()
		#play moving right animation
		if (player.global_position.x > global_position.x):
			$AnimatedSprite2D.play("right")
		#play moving backwards
		elif (player.global_position.y < global_position.y):
			$AnimatedSprite2D.play("backwards")
		#play left animation
		elif (player.global_position.x < global_position.x):
			$AnimatedSprite2D.play("left")
		#no need for else statement since forward and idle are same animation

func chasePlayer():
	chase = true
	DialogueManager.update_context("bat_chase", true)

func stopChase():
	chase = false
	DialogueManager.remove_context("bat_chase")

func take_damage():
	queue_free()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		player_detect = body
		chasePlayer()


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		player_detect = null
		stopChase()
