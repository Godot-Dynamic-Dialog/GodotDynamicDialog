extends Resource
class_name PlayerDialogue

@export var id: String
@export var conditions: Dictionary
@export var text: String

func set_data(data: Dictionary) -> void:
	id = data.id if data.has("id") else ""
	conditions = data.conditions if data.has("conditions") else {}
	text = data.text if data.has("text") else ""
