class_name Interactable extends Area2D

#text displayed
@export var interact_label = "none"

#value of interaction , item pickup / interaction, etc
@export var item_id =  0

@export var interaction_variable = "none"

#collects the parent fruit
func collect():
	$"..".collect()
