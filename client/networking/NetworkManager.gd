extends Node

var client : NetworkedMultiplayerENet


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
	var networkClient = load("res://networking/NetworkClient.tscn").instance()
	networkClient.set_name(str(get_tree().get_network_unique_id())) 
	get_node("/root/Game/Clients").add_child(networkClient)
	
func _connection_failed():
	Logger.printerr("Failed to connect to server")


func send_login_request(username : String, password: String):
	if !get_tree().has_network_peer():
		Logger.printerr("Not connected to server.")

	Logger.print("Logging in...")
	rpc_id(1, "request_login", username, password)
