# Client side representation that holds the overall state of the game.
# Server holds the canonical value which this only reflects.
# The server version sits under the RemoteClient node, whereas on the local client, it's
# a singleton

extends Node

enum ClientState { DISCONNECTED, CONNECTED, LOGGED_IN, IN_WORLD }
var state = ClientState.DISCONNECTED setget set_state

signal client_state_changed(old_state, new_state)

# Set by the server, through LocalClient
func set_state(new_state):
	Logger.print("Setting new state: " + ClientState.keys()[new_state])
	emit_signal("client_state_changed", state, new_state)
	state = new_state

