extends Node2D


# Called when the node enters the scene tree for the first time.

func _ready():
	var rain_reference = get_node("/root/MainMenu")
	var rainState = rain_reference.getRainState()
	
	print("Current rainstate: ", rainState)
	if (rainState == false):
		hide()
	
	
	
	
