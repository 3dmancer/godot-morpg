extends Node

enum ClientState { DISCONNECTED, CONNECTED, LOGGED_IN, IN_WORLD }
var state = ClientState.DISCONNECTED setget use_set_state

signal state_changed(old_state, new_state)

func use_set_state(new_state):
	push_error(
		"Can't set the state directly. " +
		"Use set_state(client_id, new_state) instead"
		)

func set_state(client_id: int, new_state):
	emit_signal("state_changed", state, new_state)
	state = new_state
