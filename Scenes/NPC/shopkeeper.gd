extends CharacterBody2D

var npcText = ""


#when timer is stopped, label becomes invisible
func _process(delta):
	npcText = DialogueDatabase.NPC_text
	if npcText == "":
		get_node("NPCSpeechFrame").hide()
	else:
		get_node("NPCSpeechFrame").show()
		get_node("NPCSpeechFrame/NPCTextMargins/ChatMessageNPC").set_text(npcText)

#entering interact area
func _on_interact_area_entered(area):
	DialogueDatabase.NPC = true

#exiting area
func _on_interact_area_exited(area):
	DialogueDatabase.NPC = false
