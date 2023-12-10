extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	print("BGM: ", DialogueDatabase.bgm)
	if(DialogueDatabase.bgm ==  1):
		$".".play()
	else:
		$".".stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
