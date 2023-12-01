# DialogueDatabase.gd
extends Node

var dialogues = []

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
