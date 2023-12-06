extends CharacterBody2D

@onready var text_box = $text_box
@onready var bubble = $text_box/NinePatchRect
@onready var label = $text_box/MarginContainer/Label
@onready var timer = $Timer


#when timer is stopped, label becomes invisible
func _process(delta):
	if (timer.is_stopped()):
		text_box.visible = false

#entering interact area
func _on_interact_area_entered(area):
	DialogueDatabase.NPC = true
	#start timer to allow text box to be set to visible
	#timer.start()
	#text_box.visible = true
	#text_box.z_index = 2
	#filler message
	#label.text = "test message"

#exiting area
func _on_interact_area_exited(area):
	DialogueDatabase.NPC = false
