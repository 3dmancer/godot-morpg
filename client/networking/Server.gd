# For general RPCs sent by the server

extends Node

remote func kicked_by_server(reason: String):
	Logger.print_server(reason)
