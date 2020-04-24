extends Node2D

var client_state = load("res://game_server/remote_client/ClientState.gd").new()

# Just for readability
var peer_id : int

var loginToken : String

func _ready():
	peer_id = int(name)
	client_state.connect("state_changed", self, "_on_state_changed")
	client_state.set_state(peer_id, client_state.ClientState.CONNECTED)


func _on_state_changed(old_state, new_state):
	rpc_id(peer_id, "_set_game_state", new_state)

######################################################
# Refactor to a login handler/manager under the client

remote func request_login(username: String, password: String):
	print("Got login request from client '%s'" % peer_id)
	
	# Send login request to the REST API 
	if !$HttpClient.auth.is_connected("login_complete", self, "_on_login_complete"):
		$HttpClient.auth.connect("login_complete", self, "_on_login_complete")

	var json = JSON.print({"username": username, "password": password})
	$HttpClient.auth.login(json)
	

# Signal from routes/auth
func _on_login_complete(successful, token, error):
	if successful:
		loginToken = token
		client_state.set_state(peer_id, client_state.ClientState.LOGGED_IN)
		rpc_id(peer_id, "_login_success")
	else:
		rpc_id(peer_id, "_login_fail", error)
