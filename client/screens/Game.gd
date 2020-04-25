# Manages the game scenes
extends Node2D
const WORLD_SCREEN_PATH = "res://screens/world/WorldScreen.tscn"

var world_screen : PackedScene

func _ready():
	var _r = ClientState.connect(
		"client_state_changed", self, "_on_client_state_changed")
	
# Change to the world scene
func load_world_scene():
	Logger.print("Entering world...")
	# Load the scene but await server acknowledgement before adding it
	# Not a safety measure, just client side "validation". The server will
	# always be right anyway
	world_screen = load(WORLD_SCREEN_PATH)
	NetworkManager.local_client.request_enter_world()

func _on_client_state_changed(_old_state, new_state):
	if new_state == ClientState.ClientState.LOGGED_IN:
		load_world_scene()
