extends YSort

onready var RemoteClient = preload("res://networking/remote_client/RemoteClient.tscn")

remote func player_entered_world(peer_id: int, player_name: String, player_position: Vector2):
	# Don't do anything if the player joining is ourself
	if NetworkManager.local_client.name == str(peer_id): return
	Logger.print("%s joined at %s" % [player_name, str(player_position)])
	
	var remote_client = RemoteClient.instance()
	remote_client.name = str(peer_id)
	
	add_child(remote_client)
	yield(get_tree(), "idle_frame")
	remote_client.spawn_player(player_name, player_position)
