extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func collect():
	queue_free()
	#DialogueDatabase.fruits_collected += 1
	#print(DialogueDatabase.fruits_collected)
	var current_fruit = $InteractArea.interact_label
#	DialogueManager.update_context("hunger", true)
#	DialogueManager.trigger_dialogue("hunger")
#
#	DialogueManager.increment_context("health", 10)
#	DialogueManager.trigger_dialogue("health")
#
#	DialogueManager.increment_context("total_" + current_fruit, 1)
#	DialogueManager.trigger_dialogue("total_" + current_fruit)
	DialogueManager.update_context("hungry", false)
	DialogueManager.update_context("full", true)
	DialogueManager.update_context("player_hurt", false)
	DialogueManager.update_context("player_healthy", true)
	DialogueManager.update_context(current_fruit + "s", true)
	
	print(DialogueManager.game_context)
	
	
