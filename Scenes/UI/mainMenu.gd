extends Control


	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#PLAY BUTTON
func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

#OPTIONS BUTTON -> GO TO OPTIONS SCENE
func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Options.tscn")

#EXIT BUTTON
func _on_exit_pressed():
	get_tree().quit()

#LINK BUTTON
func _on_link_button_pressed():
	OS.shell_open("https://github.com/Godot-Dynamic-Dialog/GodotDynamicDialog")

#dev mode 
func _on_check_button_toggled(button_pressed):
	if(button_pressed):
		DialogueDatabase.developer_mode = 1
		get_tree().set_debug_collisions_hint(true)
	else:
		DialogueDatabase.developer_mode = 0
		get_tree().set_debug_collisions_hint(false)
