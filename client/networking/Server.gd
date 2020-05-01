# Singleton for general RPCs sent by /root/Server

extends Node

remote func kicked_by_server(reason: String):
	Logger.print_server(reason)
