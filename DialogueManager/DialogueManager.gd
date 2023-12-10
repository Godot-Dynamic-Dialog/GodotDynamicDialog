extends Node

var dialogue_database = DialogueDatabase

var game_context = {"location_outside": 0, "total_apple": 0, "total_banana": 0, "total_watermelon": 0, "player_healthy": 0, "hunger_full": 0, "weather_clear": 0}
var player_health = 10

func update_context(key: String, value) -> void:
	game_context[key] = value

func remove_context(key: String) -> void:
	if game_context.has(key):
		game_context.erase(key)

func get_context(key: String):
	var context = game_context[key]
	return context

func update_health(hitpoints):
	player_health += hitpoints
	if player_health == 100:
		print("Player health at max")
		update_context("player_healthy", 0)
	elif player_health <= 0:
		print("Player health at 0")
		player_health = 0
	else:
		if hitpoints > 0:
			update_context("player_healthy", 0)
			remove_context("player_hurt")
		else:
			update_context("player_hurt", 0)
			remove_context("player_healthy")


func increment_context(key: String, increment: int = 1) -> void:
	increment = 1
	if game_context.has(key):
		game_context[key] += increment
	else:
		game_context[key] = increment

func trigger_dialogue(event_id: String) -> void:
	var dialogue_entry = dialogue_database.get_dialogue_for_event(event_id, game_context)
	if dialogue_entry:
		print(dialogue_entry.text)
		
func create_prompt():
	var prompt = ""
	for key in game_context:
		var dialogue_entry = dialogue_database.get_dialogue_for_event(key, game_context)
		if key == dialogue_entry.id:
			prompt += " " + dialogue_entry.text
			if game_context[key] > 0:
				prompt += str(game_context[key]) + "."
	print("The prompt: " + prompt)
	return prompt
