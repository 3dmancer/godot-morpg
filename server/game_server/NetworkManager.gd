extends Node


remote func request_login(username: String, password: String):
	print("Got login request from client:")
	print("Username: %s, Password: %s" % [username, password])
	
	# Login via the REST API
	# ...
	
	# Pretend we logged in and send back login success to let the client switch
	# to the World scene
