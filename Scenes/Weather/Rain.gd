extends CheckButton

@export var rainState = false



func _on_toggled(button_pressed):
	if (rainState == false):
		rainState = true
	else:
		rainState = false
		
	print("BUTTON PRESSED, state is now: ", rainState)


func getRainState():
	
	return rainState


