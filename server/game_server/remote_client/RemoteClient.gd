extends Node2D

# Just for readability
var peer_id : int

# Simple enum to keep track of the client's state, for now
enum client_states { CONNECTED, LOGGED_IN, IN_WORLD }
var client_state


func _ready():
	peer_id = int(name)
	client_state = client_states.CONNECTED

remote func request_login(username: String, password: String):
	print("Got login request from client '%s'" % peer_id)
	
	# Send login request to the REST API 
	var json = JSON.print({"username": username, "password": password})
	$HttpClient.auth.login(json)
	
	$HttpClient.auth.connect("login_complete", self, "_on_login_complete")



func _on_login_complete(successful, _token, _error):
	if successful:
		client_state = client_states.LOGGED_IN
		rpc_id(peer_id, "_login_success")
