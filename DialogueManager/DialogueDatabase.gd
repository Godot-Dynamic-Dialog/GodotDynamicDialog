# DialogueDatabase.gd
extends Node

var dialogues = []

func _init():
	load_dialogues()

func load_dialogues():
	var filePath = "res://DialogueManager/dialogues.json"
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var result = JSON.parse_string(dataFile.get_as_text())
		for dialogue_data in result:
			var dialogue = PlayerDialogue.new()
			dialogue.id = dialogue_data["id"]
			dialogue.conditions = dialogue_data["conditions"]
			dialogue.text = dialogue_data["text"]
			dialogues.append(dialogue)
	else:
		print("Failed to open dialogues.json")

func get_dialogue_for_event(event_id: String, context: Dictionary) -> PlayerDialogue:
	for dialogue in dialogues:
		if dialogue.id == event_id:
			var conditions_met = true
			for key in dialogue.conditions.keys():
				if not context.has(key) or context[key] != dialogue.conditions[key]:
					conditions_met = false
					break
			if conditions_met:
				return dialogue
	return null
