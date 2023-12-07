extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	# This code sample assumes the current script is extending MarginContainer.
	var margin_value = 1
	add_theme_constant_override("margin_top", margin_value)
	add_theme_constant_override("margin_left", margin_value)
	add_theme_constant_override("margin_bottom", 3)
	add_theme_constant_override("margin_right", margin_value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
