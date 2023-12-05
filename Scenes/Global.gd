extends Node

#current number is arbitrary and kinda unneccessary, but this allows player position to be changed based on 
#what a portal wants
var player_map_position = Vector2(200,150)
#this would be used if we want character to face a specific direction leaving the portals
var player_facing = Vector2(0,0)
#I wanted a global version that gets updated to (hopefully) make it easier to import into ShowDialogueHUD
var rainState = 0
