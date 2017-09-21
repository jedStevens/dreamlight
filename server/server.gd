extends Node2D

var server

func _print(msg):
	print("[gdku]: ", msg)

func _ready():
	server = TCP_Server.new()
	var port = int(OS.get_environment("PORT"))
	
	if port == 0:
		port = 3000
	_print("server starting on port " + str(port))
	var err = server.listen(port)
	if err:
		print(": error: ", err)
	
func _on_timer():
	if server.is_connection_available():
		print(server.take_connection())
	