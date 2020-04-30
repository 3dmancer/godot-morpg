extends Node

onready var log_ui = get_node("/root/Main/DebugUI/DebugLog")

export var show_log_level = true

func print(message: String):
	var logLevel = "info"
	print(rewrite_message(message, logLevel))
	log_ui.print_ui(rewrite_message(message, logLevel), logLevel)
	
func printwarn(message: String):
	var logLevel = "warn"
	print(rewrite_message(message, logLevel))
	log_ui.print_ui(rewrite_message(message, logLevel), logLevel)
	
func printerr(message: String):
	var logLevel = "err"
	printerr(rewrite_message(message, logLevel))
	log_ui.print_ui(rewrite_message(message, logLevel), logLevel)
	
func print_server(message: String):
	print_color(message, "warn", "[SERVER] ")
	
func print_color(message: String, color, prefix = ""):
	print(prefix + message)
	log_ui.print_ui_color(prefix + message, color)
	
func rewrite_message(message: String, log_level):
	return "[%s] %s" % [log_level.to_upper(), message] if show_log_level else message
