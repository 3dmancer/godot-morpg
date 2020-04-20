extends Node

var client : NetworkedMultiplayerENet


func connect_to_server():
	if client and client.is_connected: return
	
	Logger.print("Connecting to server...")
	
	client = NetworkedMultiplayerENet.new()
	
	if client.create_client("localhost", 9000) != 0: printerr("Failed to create client")
	
	get_tree().set_network_peer(client)
	
	if get_tree().connect("connected_to_server", self, "_connected_to_server") != 0: printerr("Failed to connect signal")
	if get_tree().connect("connection_failed", self, "_connection_failed") != 0: printerr("Failed to connect signal")

func _connected_to_server():
	Logger.print("Connected to server")
	# TODO: Only allow us to start login process after this signal	
	
func _connection_failed():
	Logger.printerr("Failed to connect to server")


func send_login_request(username : String, password: String):
	if !client.is_connected:
		Logger.printerr("Not connected to server.")

	Logger.print("Logging in...")
	rpc_id(1, "_send_login_request", username, password)
