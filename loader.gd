extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	dreamlight.start()
	if dreamlight.is_server():
		get_tree().change_scene("res://lobby/lobby.tscn")
	else:
		get_tree().change_scene("res://main_menu/menu.tscn")
