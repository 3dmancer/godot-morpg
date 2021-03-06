extends Node

var client : NetworkedMultiplayerENet

# Set when the Local Client node is ready
var local_client : Node

func connect_to_server():
	if ClientState.state != ClientState.ClientState.DISCONNECTED: return
	
	Logger.print("Connecting to server...")
	
	client = NetworkedMultiplayerENet.new()
	
	if client.create_client("localhost", 9000) != 0: printerr("Failed to create client")
	
	get_tree().set_network_peer(client)
	
	var _r = get_tree().connect("connected_to_server", self, "_connected_to_server")
	_r = get_tree().connect("connection_failed", self, "_connection_failed")
	_r = get_tree().connect("server_disconnected", self, "_disconnected_from_server")

func _connected_to_server():
	Logger.print("Connected to server")
	
	local_client = load("res://networking/local_client/LocalClient.tscn").instance()
	local_client.set_name(str(get_tree().get_network_unique_id())) 
	local_client.peer_id = local_client.name as int
	get_node("/root/Main/Game/Lobby").add_child(local_client)

func _disconnected_from_server():
	Logger.print("Disconnected from server.")
	
func _connection_failed():
	Logger.printerr("Failed to connect to server")

func _on_login_success():
	pass
