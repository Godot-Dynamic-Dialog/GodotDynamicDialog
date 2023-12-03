extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#pickup item 
func _on_pickup_area_area_entered(area):
	queue_free()
	
	
	#if (interactLabel.text == "apple"):
	#		DialogueDatabase.appleCount += 1
	#if (interactLabel.text == "watermelon"):
	#		DialogueDatabase.watermelonCount += 1
	#if (interactLabel.text == "banana"):
	#DialogueDatabase.bananaCount += 1
	#DialogueDatabase.fruitTotal += 1
	#DialogueDatabase.fruitOutput()
	
	
	
