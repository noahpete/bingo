class_name TurnStartState
extends State

@export var game_manager: GameManager
@export var camera_manager: CameraManager
@export var machine: Machine


func enter() -> void:
	await machine.spin_cage()
	
	if game_manager.turn_number % 2 == 0:
		transition.emit("PlayerTurn")
	else:
		transition.emit("OpponentTurn")
