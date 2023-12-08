extends Area2D

#Door to enter into the cave
func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if "Player" in body.name:
		print("Cave Entrance Entered")
		DialogueManager.update_context("cave", true)
		DialogueManager.update_context("outside", false)
		get_tree().change_scene_to_file("res://Scenes/Cave.tscn")
