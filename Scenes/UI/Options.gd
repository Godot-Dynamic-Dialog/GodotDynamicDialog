extends Control

@onready var dropdown = $VBoxContainer/VBoxContainer/dropdown
@onready var fruit_slider = $VBoxContainer/VBoxContainer/fruit_slider
@onready var music_slider = $VBoxContainer/VBoxContainer/music_slider
@onready var music_toggle = $VBoxContainer/VBoxContainer/bgm_toggle
# Called when the node enters the scene tree for the first time.
func _ready():
	var database = get_node("/root/DialogueDatabase")
	dropdown.selected = database.rainState
	fruit_slider.value = database.numOfFruits
	music_toggle.button_pressed = database.bgm

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/mainMenu.tscn")
	

func _on_option_button_item_selected(index):
	var rain = get_node("/root/DialogueDatabase")
	rain.rainState = index


func _on_fruit_slider_value_changed(value):
	DialogueDatabase.numOfFruits = value


func _on_bgm_toggle_toggled(button_pressed):
	if(button_pressed):
		DialogueDatabase.bgm = 1
	else:
		DialogueDatabase.bgm = 0
