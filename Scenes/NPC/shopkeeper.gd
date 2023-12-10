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
func _on_body_entered(body):
	if (body.name == "Player"):
		DialogueDatabase.NPC = true
		DialogueDatabase.call_dialogue = true

#exiting area
func _on_body_exited(body):
	if (body.name == "Player"):
		DialogueDatabase.NPC = false
	
#func _update_npc_text(outputText : String):
#	print(outputText)
#	get_node("NPCSpeechFrame/NPCTextMargins/ChatMessageNPC").set_text("YPO")
	
