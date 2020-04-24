# This is where it all begins

extends Node

func _ready():
	NetworkManager.connect_to_server()
