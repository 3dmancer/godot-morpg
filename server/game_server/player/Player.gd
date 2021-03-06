extends Node2D


func _ready():
	var width = get_viewport().size.x as int
	var height = get_viewport().size.y as int
	
	randomize()
	
	var posX = randi() % width + 1
	var posY = randi() % height + 1
	
	position = Vector2(posX, posY)

func to_dictionary() -> Dictionary:
	return {
		"name": name,
		"position": position
	}
