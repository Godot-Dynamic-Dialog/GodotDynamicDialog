@tool

extends Area2D

@export_global_file(" ") var next_scene_path

@export var player_spawn_location = Vector2(0,0)

#throws warning if portal not configured properly I think (may not be necessary)
func _get_configuration_warnings():
	if next_scene_path == " ":
		return "next_scene_path must be set"
	else:
		return ""


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	Global.player_map_position = player_spawn_location
	if get_tree().change_scene_to_file(next_scene_path) != OK:
		#error handle
		print("Scene unavailable (ERROR)")
	
