extends CharacterBody2D

#var message_npc = preload("res://Scenes/chat_message_npc.tscn")
#var mess = message_npc.instantiate()
#@onready var text_box = $SpeechFrame
#@onready var bubble = $SpeechFrame/NinePatchRect
#@onready var label = $SpeechFrame/TextMargins/ChatMessageNPC
#@onready var timer = $Timer
var npcText = ""


#when timer is stopped, label becomes invisible
func _process(delta):
#	if (timer.is_stopped()):
#		text_box.visible = false
	npcText = DialogueDatabase.NPC_text
	if npcText == "":
		get_node("NPCSpeechFrame").hide()
	else:
		get_node("NPCSpeechFrame").show()
		get_node("NPCSpeechFrame/NPCTextMargins/ChatMessageNPC").set_text(npcText)

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
	
#func _update_npc_text(outputText : String):
#	print(outputText)
#	get_node("NPCSpeechFrame/NPCTextMargins/ChatMessageNPC").set_text("YPO")
	
