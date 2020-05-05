extends YSort

onready var RemoteClient = preload("res://networking/remote_client/RemoteClient.tscn")

var clients_in_world : Dictionary setget set_clients_in_world


func set_clients_in_world(value):
	clients_in_world = value
	add_remote_clients()
	
# Sync the added nodes with the actual list of clients in the world
func add_remote_clients():
	Logger.print("Adding remote clients...")
	
	var client_ids = []
	
	# Remove nodes not in the updated list
	for node in get_children():
		# Make sure we have a client node
		if not node.has_method("i_am_a_client"): continue
		
		# Add to temp list of names for next step
		client_ids.append(node.peer_id)
		
	# Create new client nodes not in tree
	for c in clients_in_world:
		if not c in client_ids:
			create_remote_client(clients_in_world[c])

func create_remote_client(client: Dictionary):
	var c = RemoteClient.instance()
	c.name = str(client.peer_id)
	c.peer_id = client.peer_id
	add_child(c)
	yield(get_tree(), "idle_frame")
	c.spawn_player(client.player)

# Called when server sends client disconnected
func remove_remote_client(peer_id: int):
	get_node(str(peer_id)).queue_free()
