extends Node

const PORT = 9000
const MAX_PLAYERS = 200

const LOBBY_PATH = "/root/Main/Game/Lobby"
const WORLD_PATH = "/root/Main/Game/World"

var _server : NetworkedMultiplayerENet

var Client = preload("res://game_server/remote_client/RemoteClient.tscn")

var connected_clients = {}

func _ready():
	_server = NetworkedMultiplayerENet.new()
	if _server.create_server(PORT, MAX_PLAYERS) != 0: printerr("Failed to create server")

	get_tree().set_network_peer(_server)
		
	if get_tree().connect("network_peer_connected", self, "_client_connected") != 0: printerr("Failed to connect signal")
	if get_tree().connect("network_peer_disconnected", self, "_client_disconnected") != 0: printerr("Failed to connect signal")
	if get_tree().connect("connected_to_server", self, "_connected_ok") != 0: printerr("Failed to connect signal")
	if get_tree().connect("connection_failed", self, "_connected_fail") != 0: printerr("Failed to connect signal")

func _client_connected(id):
	print("Client '%s' connected" % str(id))
	
	# Create a client node and rename it to its peer_id.
	# Then add it to the Lobby and set connected state. 
	#Also add it to the convenient connected_clients dictionary
	var client = Client.instance()
	client.set_name(str(id))
	client.peer_id = id
	client.connect("state_changed", self, "_on_client_state_changed")
	get_node("/root/Main/Game/Lobby").add_child(client)
	client.set_state(Globals.ClientState.CONNECTED)
	connected_clients[id] = client

func _client_disconnected(id):
	print("Client '%s' disconnected" % str(id))
	connected_clients[id].free()
	connected_clients.erase(id)

func _on_client_state_changed(peer_id, new_state):
	match new_state:
		# Client Logged in and should enter world, but we want to bounce back
		# to the client one last time to have it request_enter_world
		# If we don't get the request in time, the client will be kicked back 
		# to the Lobby
		Globals.ClientState.ENTERING_WORLD:
			# Sanity check 
			if (connected_clients[peer_id].get_parent().get_path() 
				!= LOBBY_PATH):
				push_error("Something went wrong. Client should be in the Lobby.")
			
			# Move client to World node.
			get_node(LOBBY_PATH).remove_child(connected_clients[peer_id])
			get_node(WORLD_PATH).add_child(connected_clients[peer_id])
#
#			# Start timer
#			connected_clients[peer_id].connect(
#				"client_enter_world_timeout", 
#				self, "_on_client_enter_world_timeout")
#			connected_clients[peer_id].await_enter_world_request()

#func _on_client_enter_world_timeout(peer_id):
#	print("Kicking client '%s' back to Lobby due to enter_world_timer timeout"
#		% str(peer_id))
