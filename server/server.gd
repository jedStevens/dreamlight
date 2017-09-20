extends Node2D

var server

func _ready():
	server = TCP_Server.new()
	var port = int(OS.get_environment("PORT"))
	
	if port == 0:
		print("Got no port")
		port = 3000
	print("Port set to: ", port)
	var err = server.listen(port)
	
	print("The server is starting: ", err)
	
func _on_timer():
	if server.is_connection_available():
		print(server.take_connection())
	