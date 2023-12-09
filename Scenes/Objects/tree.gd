extends Node

func proximity(toggle):
	match toggle:
		"on": DialogueManager.update_context("tree", true)
		"off": DialogueManager.remove_context("tree")
