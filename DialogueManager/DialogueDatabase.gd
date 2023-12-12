# DialogueDatabase.gd
extends Node

var dialogues = []
var apple = preload("res://Scenes/Objects/apple.tscn")
var watermelon = preload("res://Scenes/Objects/watermelon.tscn")
var banana = preload("res://Scenes/Objects/banana.tscn")

#total number of fruits collected - incremented when item picked up
var fruits_collected = 0
var NPC = false
var rng = RandomNumberGenerator.new()
var npc_mood = rng.randi_range(0, 5)

var NPC_text = ""
var call_dialogue : bool = false

var bgm = 1
var main_bgm_pos = 0
var tavern_bgm_pos = 0
###--- Rain state variable ---###
# Rain states:
	# 0 == No rain -- default
	# 1 == Light rain
	# 2 == Heavy rain
	
@export var rainState = 0
@export var numOfFruits = 20
@export var fruits = [apple, watermelon, banana]
@export var developer_mode = 0

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
			dialogue.number = dialogue_data["number"]
			dialogue.text = dialogue_data["text"]
			dialogues.append(dialogue)
	else:
		print("Failed to open dialogues.json")
	
func get_dialogue_for_event(event_id: String, context: Dictionary) -> PlayerDialogue:
	for dialogue in dialogues:
		if dialogue.id == event_id:
			return dialogue
	return null


#getter for grabbing current rainstate
func getRainState():
	return rainState


func getNumOfFruits():
	return numOfFruits
	
	
	
	
