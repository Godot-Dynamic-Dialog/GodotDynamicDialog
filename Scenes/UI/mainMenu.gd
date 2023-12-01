extends Control

@export var rainState = 0
#rain states:
	# 0 == No rain
	# 1 == Light rain
	# 2 == Heavy rain
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#getter for grabbing current rainstate
func getRainState():
	return rainState

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
