class_name TurnStartState
extends State

@onready var game_manager: GameManager = $"../../GameManager"
@onready var camera_manager: CameraManager = $"../../CameraManager"
@onready var machine: Machine = $"../../Level/Machine"


func enter() -> void:
	await machine.spin_cage()
	
	if game_manager.turn_number % 2 == 0:
		transition.emit("PlayerTurn")
	else:
		transition.emit("OpponentTurn")
