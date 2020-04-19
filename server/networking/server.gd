extends Node

const PORT = 9000
const MAX_PLAYERS = 200

var _server : NetworkedMultiplayerENet

func _ready():
	_server = NetworkedMultiplayerENet.new()
	if _server.create_server(PORT, MAX_PLAYERS) != 0: printerr("Failed to create server")

	get_tree().set_network_peer(_server)

	if get_tree().connect("network_peer_connected", self, "_client_connected") != 0: printerr("Failed to connect signal")
	if get_tree().connect("network_peer_disconnected", self, "_client_disconnected") != 0: printerr("Failed to connect signal")
	if get_tree().connect("connected_to_server", self, "_connected_ok") != 0: printerr("Failed to connect signal")
	if get_tree().connect("connection_failed", self, "_connected_fail") != 0: printerr("Failed to connect signal")
	if get_tree().connect("server_disconnected", self, "_server_disconnected") != 0: printerr("Failed to connect signal")
	
	var apiClient = load("res://networking/ApiClient.tscn").instance()
	get_tree().get_root().call_deferred("add_child", apiClient)

func _client_connected(id):
	print("Client: '%s' connected" % str(id))

	var client = load("res://networking/remote_client.tscn").instance()
	client.set_name(str(id))
	get_tree().get_root().add_child(client)
