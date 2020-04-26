# Manages the game scenes
extends Node2D
const WORLD_SCREEN_PATH = "res://screens/world/WorldScreen.tscn"

var world_screen : Node

func _ready():
	var _r = ClientState.connect(
		"client_state_changed", self, "_on_client_state_changed")
	


func _on_client_state_changed(_old_state, new_state):
	match new_state:
		ClientState.ClientState.LOGGED_IN:
			Logger.print_color("Login successful", "success")
			NetworkManager.local_client.request_enter_world()
			
		ClientState.ClientState.ENTERING_WORLD:
			Logger.print("Entering world...")
			load_world_scene()
			#move_to_world()
			
		ClientState.ClientState.IN_WORLD:
			add_child(world_screen)
			

# Load up the world scene, but don't add it just yet.
func load_world_scene():
	world_screen = load(WORLD_SCREEN_PATH).instance()
	#NetworkManager.local_client.request_enter_world()
	
func move_to_world():
	var client = NetworkManager.local_client
	client.get_parent()
	#world_screen.add_child()
