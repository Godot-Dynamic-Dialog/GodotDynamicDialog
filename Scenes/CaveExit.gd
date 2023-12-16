extends Area2D

#Makes Player exit cave
func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if "Player" in body.name:
		print("Cave Exited")
		DialogueManager.update_context("location_cave", false)
		DialogueManager.update_context("location_outside", true)
		get_tree().change_scene_to_file("res://Scenes/main.tscn")
#
