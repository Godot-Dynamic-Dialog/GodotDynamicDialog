extends CheckButton

@export var rainState = false


func _ready():
	var rain = get_node("/root/MainMenu")
	print(rain.getRainState)
	if (rain.getRainState() == true):
		button_pressed = true
		

func _on_toggled(button_pressed):
	var rain = get_node("/root/MainMenu")
	if (button_pressed == true):
		rain.rainState = true
	else:
		rain.rainState = false
		
	print("BUTTON PRESSED, state is now: ", rain.rainState)


