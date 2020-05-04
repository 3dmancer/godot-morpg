extends YSort

onready var RemoteClient = preload("res://networking/remote_client/RemoteClient.tscn")

var clients_in_world : Dictionary setget set_clients_in_world


func set_clients_in_world(value):
	clients_in_world = value
	update_client_nodes()
	
# Sync the added nodes with the actual list of clients in the world
func update_client_nodes():
	Logger.print("Updating client nodes")
	
	var client_ids = []
	
	# Remove nodes not in the updated list
	for node in get_children():
		# Add to temp list of names for next step
		client_ids.append(node.name as int)
		
		if not node.name as int in clients_in_world:
			node.queue_free()
			
	# Create new client nodes not in tree
	for c in clients_in_world:
		if not c.peer_id in client_ids:
			create_remote_client(c)

func create_remote_client(client: Dictionary):
	var c = RemoteClient.instance()
	c.name = str(client.peer_id)
	add_child(c)
	yield(get_tree(), "idle_frame")
	c.spawn_player(client.player)
