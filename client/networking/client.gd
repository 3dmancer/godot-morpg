extends Node

var client : NetworkedMultiplayerENet

func _ready():
	client = NetworkedMultiplayerENet.new()
	if client.create_client("localhost", 9000) != 0: printerr("Failed to create client")
	get_tree().set_network_peer(client)
