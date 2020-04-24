# This is the local client (the player's client). On the server, this will be 
# represented as one of several RemoteClients. There will only ever be one 
# LocalClient in the tree, under the Clients node. Other players will be 
# represented as a RemoteClient, just like on the server.

# Every client node will have its name set to its peer id so that both client and 
# server will have the same node paths.

extends Node

signal login_success


remote func _set_game_state(new_state):
	GameState.state = new_state

func send_login_request(username : String, password: String):
	if !get_tree().has_network_peer():
		Logger.printerr("Not connected to server.")
		return

	Logger.print("Logging in...")
	rpc_id(1, "request_login", username, password)


remote func _login_success():
	Logger.print_color("Login successful", "success")
	emit_signal("login_success")

remote func _login_fail(error):
	Logger.printerr(error)
