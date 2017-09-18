extends Node

const RUN_SERVER = true

var _is_server = false
var server=null
var client=null
var port = 6969

var in_messages = []

var time = 0
var tick = 0

var players = []

func start():
	set_process(true)
	
	set_fixed_process(true)
	
	server = create_server()
	if OS.get_name() == "Server" or RUN_SERVER :
		_is_server = true
		
	else:
		var http = HTTPRequest.new()
		http.set_download_file("res://port.txt")
		http.request("localhost:5000/port-hint")
		print(http.get_http_client_status())
		
		client  = StreamPeerTCP.new()
		client.connect("dreamlight-server.herokuapp.com",port)

func create_server():
	# We have to write to game.port
	# its up to you which port to use but we
	# have to pass it on through the server
	var game_port = get_valid_port()
	
	var host = NetworkedMultiplayerENet.new()
	host.create_server(game_port, 4)
	get_tree().set_network_peer(host)
	
	return host

func get_valid_port():
	port = 4000
	# should test if port is in use
	# also should manage it better
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