extends Node2D

# Only allow a client to ask us once every REQUEST_COOLDOWN seconds
const REQUEST_COOLDOWN = 5

var recent_requesters : Dictionary # peer_id, request_time

func get_clients() -> Dictionary:
	var client_dict = {}
	for id in Server.connected_clients:
		var client = Server.connected_clients[id]
		if client.client_state == Globals.ClientState.IN_WORLD:
			client_dict[id] = client.to_dictionary()
	return client_dict

func send_client_entered_world(client: Dictionary):
	rpc("remote_client_entered_world", client)
