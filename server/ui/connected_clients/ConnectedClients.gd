extends Panel

onready var client_list = $Margin/VBox/ClientList
onready var ClientLabel = preload("res://ui/connected_clients/ClientLabel.tscn")
func _ready():
	var _r = Server.connect("client_connected", self, "_on_client_connected")
	_r = Server.connect("client_disconnected", self, "_on_client_disconnected")
	
func _on_client_connected(peer_id):
	var label = ClientLabel.instance()
	label.name = str(peer_id)
	label.text = str(peer_id)
	client_list.add_child(label)

func _on_client_disconnected(peer_id):
	client_list.get_node(str(peer_id)).free()
