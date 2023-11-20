extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_chat_enter_pressed():
	get_node("ScreenText").set_text(get_node("ChatBox").get_text())
