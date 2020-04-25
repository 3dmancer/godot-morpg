# This is where it begins
extends Node

var splashScreen = preload("res://screens/splash/SplashScreen.tscn").instance()
var lobby: Node

const SPLASH_DURATION = 2.5 #seconds

func _ready():
	Logger.print("Booting up...")
	
	# Show splash screen for SPLASH_DURATION seconds
	$Splash.add_child(splashScreen)
	
	# Load Lobby
	lobby = load("res://screens/login/Lobby.tscn").instance()
	
	# Wait before fading out
	yield(get_tree().create_timer(SPLASH_DURATION), "timeout")
	
	# Add lobby to tree
	$Game.add_child(lobby)
	
	


	# Fade out and remove the Splash node
	splashScreen.fade_out()
