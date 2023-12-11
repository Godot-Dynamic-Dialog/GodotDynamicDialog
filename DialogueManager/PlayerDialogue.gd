extends Resource
class_name PlayerDialogue

@export var id: String
@export var number: int
@export var text: String

func set_data(data: Dictionary) -> void:
	id = data.id if data.has("id") else ""
	number = data.number if data.has("number") else 0
	text = data.text if data.has("text") else ""
