extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TextureProgressBar.value = DialogueManager.game_context["health"]
