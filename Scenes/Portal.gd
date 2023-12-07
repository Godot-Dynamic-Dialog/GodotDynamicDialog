@tool

extends Area2D

@export_global_file(" ") var next_scene_path

@export var player_spawn_location = Vector2(0,0)
@export var player_direction_facing = Vector2(0,0)
@export var scene_entering = ""

#throws warning if portal doesn't have a destination
func _get_configuration_warnings():
	if next_scene_path == " ":
		return "next_scene_path must be set"
	else:
		return ""

#handles changing scenes, adds editable script stuff on the inspecter widget for each portal
func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	
	#the two $SceneTransitions don't work, not fully sure as to why
	
	#$SceneTransition.play_animation
	
	if get_tree().change_scene_to_file(next_scene_path) != OK:
		#error handle
		print("Scene unavailable (ERROR)")
	else:
		DialogueManager.game_scene = scene_entering
		#moves the player to the portal's designated location (x,y)
		Global.player_map_position = player_spawn_location
		#this one isn't working, it's just here for if we want to do this
		Global.player_facing = player_direction_facing
	
	#$SceneTransition.play_animation_backwards
	
	
