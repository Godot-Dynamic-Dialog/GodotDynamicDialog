# DialogueDatabase.gd
extends Node

var dialogues = []
var apple = preload("res://Scenes/Objects/apple.tscn")
var watermelon = preload("res://Scenes/Objects/watermelon.tscn")
var banana = preload("res://Scenes/Objects/banana.tscn")

#total number of fruits collected - incremented when item picked up
var fruits_collected = 0

###--- Rain state variable ---###
# Rain states:
	# 0 == No rain -- default
	# 1 == Light rain
	# 2 == Heavy rain
	
@export var rainState = 0
@export var numOfFruits = 50
@export var fruits = [apple, watermelon, banana]

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


#getter for grabbing current rainstate
func getRainState():
	return rainState


func getNumOfFruits():
	return numOfFruits
	
	
