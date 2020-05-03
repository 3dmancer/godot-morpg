extends Node2D

func broadcast_player_entered_world(client: Node):
	rpc(
		"player_entered_world",
		client.peer_id,
		client.player.name,
		client.player.position)
