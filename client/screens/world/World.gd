extends YSort

onready var RemoteClient = preload("res://networking/remote_client/RemoteClient.tscn")

remote var clients_in_world : Dictionary setget set_clients_in_world

signal clients_in_world_changed(clients_in_world)

func set_clients_in_world(value : Dictionary):
	for client in value:
		if str(client) != NetworkManager.local_client.name and not client in clients_in_world:
			create_remote_client(value[client])
		
	clients_in_world = value
	emit_signal("clients_in_world_changed", value)

func create_remote_client(client : Dictionary):
	var c = RemoteClient.instance()
	c.name = str(client.peer_id)
	add_child(c)
	yield(get_tree(), "idle_frame")
	c.spawn_player(client.player.name, client.player.position)
