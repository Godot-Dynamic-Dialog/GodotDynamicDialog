extends Node2D


# Called when the node enters the scene tree for the first time.

func _ready():
	var rain_reference = get_node("/root/DialogueDatabase")
	var rainState = rain_reference.getRainState()
	
	if (rainState != 1):
		hide()
	
	
	
	
