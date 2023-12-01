@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("HTTPSSEClient", "Node", preload("res://Scenes/Addons/HTTPSSEClient/HTTPSSEClient_modified.gd"), preload("res://Scenes/Addons/HTTPSSEClient/icon.png"))
	pass

func _exit_tree():
	remove_custom_type("HTTPSSEClient")
	pass
