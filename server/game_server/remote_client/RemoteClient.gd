extends Node2D

var peer_id : int

# Simple enum to keep track of the client's state, for now
enum client_states { CONNECTED, LOGGED_IN, IN_WORLD }
var client_state

func _ready():
	# Just for readability
	peer_id = int(name)
	
	client_state = client_states.CONNECTED

# RPC
remote func request_login(username: String, password: String):
	print("Got login request from client:")
	print("Username: %s, Password: %s" % [username, password])
	
	# Login via the REST API
	# ...
	
	# Pretend we logged in and send back login success to let the client switch
	# to the World scene and add a player node
	client_state = client_states.LOGGED_IN
	
	rpc_id(peer_id, "_login_success")
