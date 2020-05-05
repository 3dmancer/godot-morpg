# Manages the game scenes
extends Node2D
const WORLD_SCREEN_PATH = "res://screens/world/WorldScreen.tscn"

var world_scene : Node

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
			move_to_world()
			
			yield(get_tree(), "idle_frame")
			NetworkManager.local_client.send_entered_world()
			NetworkManager.local_client.request_clients_in_world()
			
		ClientState.ClientState.IN_WORLD:
			Logger.print_color("Successfully entered the world.", "success")


# Load up the world scene
func load_world_scene():
	world_scene = load(WORLD_SCREEN_PATH).instance()
	add_child(world_scene)

# Move Client from Lobby to World
func move_to_world():
	var client = NetworkManager.local_client
	var lobby = client.get_parent()
	# Make sure the world scene was added
	yield(get_tree(), "idle_frame")
	
	# Move the client
	client.get_parent().remove_child(client)
	world_scene.add_child(client)
	
	# Remove the lobby
	lobby.queue_free()
