extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	if(DialogueDatabase.developer_mode != 1):
		hide()

func _process(delta):
	pass
