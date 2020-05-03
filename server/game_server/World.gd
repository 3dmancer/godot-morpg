extends Node2D

var clients_in_world: Dictionary


func add_client(client: Dictionary):
	clients_in_world[client.peer_id] = client
	rset("clients_in_world", clients_in_world)
	
func remove_client(peer_id: int):
	var _r = clients_in_world.erase(peer_id)
	# rset clients_in_world
