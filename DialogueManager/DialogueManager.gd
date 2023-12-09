extends Node

var dialogue_database = DialogueDatabase

var game_context = {"outside": true, "total_apple": 0, "total_banana": 0, "total_watermelon": 0, "player_healthy": true, "hunger_full": true, "weather_clear": true}

func update_context(key: String, value) -> void:
	game_context[key] = value

func remove_context(key: String) -> void:
	if game_context.has(key):
		game_context.erase(key)

func get_context(key: String):
	var context = game_context[key]
	return context
	
func increment_context(key: String, increment: int = 1) -> void:
	if game_context.has(key):
		game_context[key] += increment
	else:
		game_context[key] = increment

func trigger_dialogue(event_id: String) -> void:
	var dialogue_entry = dialogue_database.get_dialogue_for_event(event_id, game_context)
	if dialogue_entry:
		print(dialogue_entry.text)
