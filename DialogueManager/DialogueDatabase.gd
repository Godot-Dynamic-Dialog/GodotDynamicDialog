# DialogueDatabase.gd
extends Node

var dialogues = []
var apple = preload("res://Scenes/Objects/apple.tscn")
var watermelon = preload("res://Scenes/Objects/watermelon.tscn")
var banana = preload("res://Scenes/Objects/banana.tscn")

###--- Rain state variable ---###
# Rain states:
	# 0 == No rain -- default
	# 1 == Light rain
	# 2 == Heavy rain
	
@export var rainState = 0
@export var numOfFruits = 0
@export var fruits = [apple, watermelon, banana]


func _init():
	var high_health = PlayerDialogue.new()
	high_health.set_data({
		"id": "health",
		"conditions": {"health": 100},
		"text": "High Health",
		})
	dialogues.append(high_health)
	
	var low_health = PlayerDialogue.new()
	low_health.set_data({
		"id": "health",
		"conditions": {"health": 50},
		"text": "Low Health",
		})
	dialogues.append(low_health)
	
	var no_rain = PlayerDialogue.new()
	no_rain.set_data({
		"id": "rain",
		"conditions": {"rain": 0},
		"text": "No Rain",
	})
	dialogues.append(no_rain)
	
	var light_rain = PlayerDialogue.new()
	no_rain.set_data({
		"id": "rain",
		"conditions": {"rain": 1},
		"text": "It is lightly raining",
	})
	dialogues.append(light_rain)
	
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
	
