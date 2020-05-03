# This is the representation of a client that is remotely connected, i e another 
# player's client. This client is only connected to the server, so it's up to it 
# to tell us when to instance one.
extends Node

onready var Player = preload("res://player/remote_player/RemotePlayer.tscn")
var player : Node2D

func spawn_player(player_name: String, player_position: Vector2):
	player = Player.instance()
	player.name = player_name
	player.position = player_position
	add_child(player)
