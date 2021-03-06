# This is the local client (the player's client). On the server, this will be 
# represented as one of several RemoteClients. There will only ever be one 
# LocalClient in the tree, under the Clients node. Other players will be 
# represented as a RemoteClient, just like on the server.

# Every client node will have its name set to its peer id so that both client 
# and server will have the same node paths.

extends Node

onready var Player = preload("res://player/Player.tscn")
onready var player : Node2D

var peer_id : int
	
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

# Tell the server we finished loading the world
func send_entered_world():
	rpc_id(1, "entered_world")

# Not doing anything here yet
remote func enter_world(accepted: bool, error = ""):
	if not accepted: 
		Logger.printerr(error)
		return


remote func spawn_player(position):
	player = Player.instance()
	player.name = "player_" + name
	player.position = position
	add_child(player)


func request_clients_in_world():
	rpc_id(1, "request_clients_in_world")


remote func response_clients_in_world(clients_in_world: Dictionary):
	if get_parent().name != "World": 
		push_error("Should be in world scene")
		return
	get_parent().init_clients_in_world(clients_in_world)
	


func i_am_a_client():
	pass
