extends PanelContainer

onready var log_box = $ScrollContainer/LogBox
onready var scroll_container = $ScrollContainer

const MAX_BUFFER = 100
var num_lines : int

func _ready():
	# Needed for the first entry to show up
	scroll_down()

func print_ui(message: String, log_level : String):
	var message_label = create_label(message)
	
	var color : Color
	
	match log_level.to_lower():
		"info": color = Color.white
		"warn": color = Color("#ffe15a")
		"err": color = Color("#e61c1c")
		"debug": color = Color("#adadad")
		"success": color = Color("#1ae565")
		_: printerr("Unknown log level passed to print")
		
	set_label_color(message_label, color)
	add_label_node(message_label)
	
func print_ui_color(message: String, color):
	var textColor = Color.white
	
	if color as String:
		match color:
			"success": textColor = Color("#1ae565")
	elif color as Color:
		textColor = color
	
	var message_label = create_label(message)
	set_label_color(message_label, textColor)
	add_label_node(message_label)
	

func create_label(message: String):
	var message_label = Label.new()
	message_label.text = message
	return message_label
	
func set_label_color(message_label: Label, color: Color):
	message_label.add_color_override("font_color", color)
	
func add_label_node(message_label: Label):
	log_box.add_child(message_label)
	num_lines += 1
	update_list()
		

# Scroll down to the end after each entry 
# and delete the first one if MAX_BUFFER is reached
func update_list():
	yield(get_tree(), "idle_frame")
	scroll_down()
	
	if num_lines > MAX_BUFFER:
		log_box.get_child(0).free()

func scroll_down():
	scroll_container.scroll_vertical = scroll_container.get_v_scrollbar().max_value
