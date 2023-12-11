extends Node

func proximity(toggle: String):
	match toggle:
		"on": DialogueManager.update_context("tree", 0)
		"off": DialogueManager.remove_context("tree")
