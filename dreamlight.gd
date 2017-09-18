extends Node

const RUN_SERVER = false
const PORT = 4202

var _is_server = false
var host=null
var client=null
var port = 6969

var in_messages = []

var time = 0
var tick = 0

var players = []

var ip = "127.0.0.1" # "dreamlight-server.herokuapp.com"

func start():
	set_process(true)
	
	set_fixed_process(true)
	
	if OS.get_name() == "Server" or RUN_SERVER :
		print("Starting Server Version")
		_is_server = true
		create_server()

		
	else:
		print("Starting Client Version")
		get_port_hint()

func get_port_hint():
	print("Requesting port hint...")
	var http = HTTPRequest.new()
	add_child(http)
	http.request("http://localhost:5000/port-hint")
	
	http.set_download_file("user://game.port")
	http.connect("request_completed", self, "on_port_hint_req_complete")
	
	print("File should download into: ", http.get_download_file())

func on_port_hint_req_complete(res,res_code,headers,body):
	var port_file = File.new()
	port_file.open("user://game.port", File.READ)
	
	port = int(port_file.get_as_text())
	print("Got port: ", port)
	port_file.close()
	

func create_server():
	# We have to write to game.port
	# its up to you which port to use but we
	# have to pass it on through the server
	var game_port = get_valid_port()
	
	host = NetworkedMultiplayerENet.new()
	host.create_server(game_port, 4)
	get_tree().set_network_peer(host)

func create_client():
	var host = NetworkedMultiplayerENet.new()
	host.create_client("dreamlight-server.herokuapp.com", PORT)
	get_tree().set_network_peer(host)

func get_valid_port():
	var port_file = File.new()
	port_file.open("game.port", File.READ)
	port = int(port_file.get_as_text())
	return port

func _process(delta):
	if is_server():
		for msg in in_messages:
			handle(msg)
		in_messages = []
		time += delta

func _fixed_process(delta):
	tick += 1

func handle(msg):
	print(msg["ip"] + "@" + str(msg["tick"]) + " '" + msg["data"] + "'")

func is_server():
	return _is_server

func send(msg, ip="127.0.0.1"):
	# Send using TCP
	# this message dict should be created when recieved
	var message = { "ip" : ip, "data" : msg , "tick" : tick}
	in_messages.append(message)