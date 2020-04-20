extends Node


remote func _send_login_request(username: String, password: String):
	print("Got login request from client:")
	print("Username: %s, Password: %s" % [username, password])
