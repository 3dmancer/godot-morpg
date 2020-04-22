extends Node

# This is the client side representation of the server's RemoteClient
# Will be renamed to the client's network ID to get the same path as on the server


func _ready():
	# Register ourselves at the NetworkManager
	NetworkManager.localClient = self
	
func send_login_request(username : String, password: String):
	if !get_tree().has_network_peer():
		Logger.printerr("Not connected to server.")

	Logger.print("Logging in...")
	rpc_id(1, "request_login", username, password)


remote func _login_success():
	Logger.print_color("Login successful", "success")
