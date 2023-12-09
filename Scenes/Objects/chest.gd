extends Node

func proximity(toggle):
	match toggle:
		"on": DialogueManager.update_context("chest", true)
		"off": DialogueManager.remove_context("chest")
