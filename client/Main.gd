# This is where it begins
extends Node

var splashScreen = preload("res://screens/splash/SplashScreen.tscn").instance()

func _ready():
	Logger.print("Booting up...")
	# Show splash screen for X seconds
	$Game.add_child(splashScreen)
	# Load next screen and wait before adding it
	var lobby = load("res://screens/login/Lobby.tscn").instance()
	yield(get_tree().create_timer(3.0), "timeout")
	# TODO: Crossfade
	# Change to Lobby
	$Game.add_child(lobby)
	# Remove splash
	$Game.get_child(0).free()
	
