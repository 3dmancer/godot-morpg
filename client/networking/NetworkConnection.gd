extends Node

func _ready():
	NetworkClient.connect_to_server()

func send_login_request(username : String, password: String):
	if !NetworkClient.client.is_connected:
		Logger.printerr("Not connected to server.")
		
	Logger.print("Logging in...")
	rpc_id(1, "_send_login_request", username, password)
