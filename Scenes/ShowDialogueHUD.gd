extends Label

var JSON_URL = "res://DialogueManager/dialogues.json"

#sets the rain state right away, doesn't need to be constantly updated
func _ready():
	if(DialogueDatabase.rainState == 0):
		$RainState.text = str("No Rain")
	elif(DialogueDatabase.rainState == 1):
		$RainState.text = str("Light Rain")
	else:
		$RainState.text = str("Heavy Rain")
# Called every frame. 'delta' is the elapsed time since the previous frame.
# using this to have a constant update to the values as I do not fully know how to update only when a prompt is changed
func _process(delta):
	$Health.text = str(DialogueManager.game_context["player_healthy"])
	$Hunger.text = str(DialogueManager.game_context["hunger_full"])
	$TotalApple.text = str(DialogueManager.game_context["total_apple"])
	$TotalBanana.text = str(DialogueManager.game_context["total_banana"])
	$TotalWatermelon.text = str(DialogueManager.game_context["total_watermelon"])
	$CurrentScene.text = str(DialogueManager.game_context["location_outside"])
