extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var rain = get_node("/root/MainMenu")
	print(rain.rainState)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/mainMenu.tscn")
	

func _on_option_button_item_selected(index):
	var rain = get_node("/root/MainMenu")
	rain.rainState = index
