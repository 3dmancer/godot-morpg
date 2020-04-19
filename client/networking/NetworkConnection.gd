extends Node

func _ready():
	pass

func send_login_request(username : String, password: String):
	print("Logging in with: %s : %s" % [username, password])
	rpc_id(1, "_send_login_request", username, password)
