extends YSort

onready var RemoteClient = preload("res://networking/remote_client/RemoteClient.tscn")

# Only called when entering world, for now.
func init_clients_in_world(clients_in_world : Dictionary):
	Logger.print("Adding clients already in world...")
	
	for id in clients_in_world:
		# Don't create a copy of ourself
		if id != NetworkManager.local_client.peer_id:
			create_remote_client(clients_in_world[id])

func create_remote_client(client: Dictionary):
	var c = RemoteClient.instance()
	c.name = str(client.peer_id)
	c.peer_id = client.peer_id
	add_child(c)
	yield(get_tree(), "idle_frame")
	c.spawn_player(client.player)
