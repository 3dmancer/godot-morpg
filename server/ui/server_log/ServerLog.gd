extends PanelContainer

onready var LogLabel = preload("res://ui/server_log/LogLabel.tscn")
onready var log_box : VBoxContainer = $Margin/Scroll/VBox
onready var scroll_container : ScrollContainer = $Margin/Scroll

const MAX_BUFFER = 1000
var num_lines : int

func _ready():
	scroll_down()
	
func print(text: String, color: Color):
	create_label(text, color)

func create_label(text: String, color: Color):
	var label = LogLabel.instance()
	label.add_color_override("font_color", color)
	label.text = text
	log_box.add_child(label)
	num_lines += 1
	update_list()
	
func update_list():
	yield(get_tree().create_timer(0.01), "timeout") # Ugly hack that seems to work perfectly
	scroll_down()
	
	if num_lines > MAX_BUFFER:
		log_box.get_child(0).free()

func scroll_down():
	scroll_container.scroll_vertical = scroll_container.get_v_scrollbar().max_value as int
