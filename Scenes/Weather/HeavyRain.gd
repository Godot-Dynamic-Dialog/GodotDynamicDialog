extends Node2D


func _ready():
	var rain_reference = get_node("/root/MainMenu")
	var rainState = rain_reference.getRainState()
	
	print("Current rainstate: ", rainState)
	if (rainState != 2):
		hide()
