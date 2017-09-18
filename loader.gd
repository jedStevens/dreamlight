extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	dreamlight.start()
	
	get_tree().change_scene("res://lobby/lobby.tscn")
