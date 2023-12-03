extends Control

@onready var dropdown = $VBoxContainer/VBoxContainer/dropdown
@onready var fruit_slider = $VBoxContainer/VBoxContainer/fruit_slider
# Called when the node enters the scene tree for the first time.
func _ready():
	var database = get_node("/root/DialogueDatabase")
	dropdown.selected = database.rainState
	fruit_slider.value = database.numOfFruits

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/mainMenu.tscn")
	

func _on_option_button_item_selected(index):
	var rain = get_node("/root/DialogueDatabase")
	rain.rainState = index


func _on_fruit_slider_value_changed(value):
	var fruits = get_node("/root/DialogueDatabase")
	fruits.numOfFruits = value
