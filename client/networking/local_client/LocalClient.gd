# This is the local client (the player's client). On the server, this will be 
# represented as one of several RemoteClients. There will only ever be one 
# LocalClient in the tree, under the Clients node. Other players will be 
# represented as a RemoteClient, just like on the server.

# Every client node will have its name set to its peer id so that both client 
# and server will have the same node paths.

extends Node


remote func set_client_state(new_state):
	ClientState.state = new_state

func request_login(username : String, password: String):
	if ClientState.state != ClientState.ClientState.CONNECTED:
		Logger.printerr("Not connected to server.")
		return

	Logger.print("Logging in...")
	rpc_id(1, "request_login", username, password)


remote func login_fail(error):
	Logger.printerr(error)
	
func request_enter_world():
	rpc_id(1, "request_enter_world")
	
remote func enter_world(accepted: bool, error = ""):
	if not accepted: 
		Logger.printerr(error)
		return
	
