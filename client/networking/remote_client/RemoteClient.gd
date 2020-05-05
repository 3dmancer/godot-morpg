# This is the representation of a client that is remotely connected, i e another 
# player's client. This client is only connected to the server, so it's up to it 
# to tell us when to instance one.
extends Node

onready var Player = preload("res://player/remote_player/RemotePlayer.tscn")
var player : Node2D

var peer_id : int


func spawn_player(player_dict: Dictionary):
	Logger.print("Spawning " + player_dict.name)
	
	player = Player.instance()
	player.name = player_dict.name
	player.position = player_dict.position
	add_child(player)


# Used to check that the node is indeed a client with has_method(). 
# Haven't figured out a better way yet.
func i_am_a_client():
	pass
