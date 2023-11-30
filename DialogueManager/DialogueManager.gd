extends Node

var dialogue_database = DialogueDatabase

var game_context = {}

#@onready var dialogue_box = $DialogueBox
#@onready var dialogue_text = dialogue_box.get_node("DialogueText")

func update_context(key: String, value) -> void:
	game_context[key] = value
	
	# Function to update the game context, incrementing the value if the key exists
func increment_context(key: String, increment: int = 1) -> void:
	if game_context.has(key):
		game_context[key] += increment
	else:
		game_context[key] = increment



#func display_dialogue(text: String) -> void:
#	dialogue_text.text = text

#func hide_dialogue() -> void:
#	dialogue_box.hide()

func trigger_dialogue(event_id: String) -> void:
	var dialogue_entry = dialogue_database.get_dialogue_for_event(event_id, game_context)
	if dialogue_entry:
		print(dialogue_entry.text)
		#display_dialogue(dialogue_entry.text)
