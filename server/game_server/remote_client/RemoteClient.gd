extends Node2D

# Just for readability
var peer_id : int

# Simple enum to keep track of the client's state, for now
enum client_states { CONNECTED, LOGGED_IN, IN_WORLD }
var client_state

var loginToken : String

func _ready():
	peer_id = int(name)
	client_state = client_states.CONNECTED


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
		client_state = client_states.LOGGED_IN
		rpc_id(peer_id, "_login_success")
	else:
		rpc_id(peer_id, "_login_fail", error)
