extends Label

var JSON_URL = "res://DialogueManager/dialogues.json"

# Called every frame. 'delta' is the elapsed time since the previous frame.
# using this to have a constant update to the values as I do not fully know how to update only when a prompt is changed
func _process(delta):
	var file = FileAccess.open(JSON_URL, FileAccess.READ)
	$Health.text = str(0)
	$Hunger.text = str(0)
	$TotalApple.text = str(0)
	$TotalBanana.text = str(0)
	$TotalWatermelon.text = str(0)
	$RainState.text = str(0)
