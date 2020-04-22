extends Node

var client : NetworkedMultiplayerENet

# Set when the Local Client node is ready
var localClient : Node

func connect_to_server():
	if get_tree().has_network_peer(): return
	
	Logger.print("Connecting to server...")
	
	client = NetworkedMultiplayerENet.new()
	
	if client.create_client("localhost", 9000) != 0: printerr("Failed to create client")
	
	get_tree().set_network_peer(client)
	
	if get_tree().connect("connected_to_server", self, "_connected_to_server") != 0: printerr("Failed to connect signal")
	if get_tree().connect("connection_failed", self, "_connection_failed") != 0: printerr("Failed to connect signal")

func _connected_to_server():
	Logger.print("Connected to server")
	var localClient = load("res://networking/local_client/LocalClient.tscn").instance()
	localClient.set_name(str(get_tree().get_network_unique_id())) 
	get_node("/root/Game/Clients").add_child(localClient)
	
func _connection_failed():
	Logger.printerr("Failed to connect to server")


