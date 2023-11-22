extends CanvasLayer

func _on_button_pressed():
	get_node("Label").set_text(get_node("TextEdit").text)
