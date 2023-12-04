extends Node2D


func _ready():
	var rain_reference = get_node("/root/DialogueDatabase")
	var rainState = rain_reference.getRainState()
	
	if (rainState != 2):
		hide()
