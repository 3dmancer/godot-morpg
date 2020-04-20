extends KinematicBody2D

export var MoveSpeed = 80
export var Acceleration = 3000

var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("player_moveRight") - Input.get_action_strength("player_moveLeft")
	inputVector.y = Input.get_action_strength("player_moveDown") - Input.get_action_strength("player_moveUp")
	inputVector = inputVector.normalized()
	
	if inputVector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", inputVector)
		animationTree.set("parameters/Walk/blend_position", inputVector)
		animationState.travel("Walk")
		velocity = velocity.move_toward(inputVector * MoveSpeed, Acceleration * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, Acceleration * delta)
	
	velocity = move_and_slide(velocity)
		
