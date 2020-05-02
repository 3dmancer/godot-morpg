extends Node

# Presets
const LOG_LEVEL = {
	"INFO": Color.white,
	"WARNING": Color("#ffe15a"),
	"ERROR": Color("#e61c1c"),
	"DEBUG": Color("#adadad"),
	"SUCCESS": Color("#1ae565")
	}

onready var log_ui = get_node("/root/Main/ServerUI/Log")

func print(text : String, log_level : Color = LOG_LEVEL.INFO):
	var h = OS.get_time().hour
	var m = OS.get_time().minute
	var s = OS.get_time().second
	
	var time = "[%02d:%02d:%02d] " % [h,m,s]
	
	print(time + text)
	log_ui.print(time + text, log_level)
