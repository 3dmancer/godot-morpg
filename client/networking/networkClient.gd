extends Node

var client : NetworkedMultiplayerENet
onready var NetworkConnection = get_node("/root/Game/NetworkConnection")

func _ready():
	print("Connecting to server...")
	client = NetworkedMultiplayerENet.new()
	if client.create_client("localhost", 9000) != 0: printerr("Failed to create client")
	get_tree().set_network_peer(client)
	if get_tree().connect("connected_to_server", self, "_connected_to_server") != 0: printerr("Failed to connect signal")
	if get_tree().connect("connection_failed", self, "_connection_failed") != 0: printerr("Failed to connect signal")
	

func _connected_to_server():
	print("Connected to server")
	# Only allow us to start login process after this signal	
	
func _connection_failed():
	printerr("Failed to connect to server")
