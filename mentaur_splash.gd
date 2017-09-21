extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)

func _process(delta):
	get_node("CenterContainer").set_size(get_viewport_rect().size)