# This is where we start up the connection
extends Node

func _ready():	
	NetworkManager.connect_to_server()
