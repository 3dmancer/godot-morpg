# Singleton for general RPCs sent by /root/Server

extends Node

remote func kicked_by_server(reason: String):
	Logger.print_server(reason)

remote func server_message(message: String):
	Logger.print_server(message)
	
remote func client_joined(player_name: String, player_position: Vector2):
	Logger.print("%s joined at %s" % [player_name, str(player_position)])
