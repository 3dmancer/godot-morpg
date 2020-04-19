extends Node

var username : String
var password : String

onready var _networkClient = get_node("/root/NetworkClient")
func _ready():
	# Set focus to the username input
	$Container/Wrap/Login/Username/inputUsername.grab_focus()
	

func _on_btnLogin_button_up():
	if username.length() < 1 or password.length() < 1: 
		printerr("Username or password can't be empty")
		return
	print("Loggin in...")
	_networkClient.NetworkConnection.send_login_request(username, password)


func _on_inputUsername_text_changed(new_text):
	username = new_text


func _on_inputPassword_text_changed(new_text):
	password = new_text
