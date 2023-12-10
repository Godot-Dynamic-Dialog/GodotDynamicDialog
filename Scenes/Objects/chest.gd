extends Node

func proximity(toggle: String):
	match toggle:
		"on": DialogueManager.update_context("chest", 0)
		"off": DialogueManager.remove_context("chest")
