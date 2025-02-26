class_name TurnStartState
extends State

@export var game_manager: GameManager
@export var camera_manager: CameraManager
@onready var machine: Machine = %Machine


func enter() -> void:
	if game_manager.turn_number % 2 == 0:
		await _player_turn()
	else:
		await _opponent_turn()


func _player_turn() -> void:
	await machine.spin_cage()
	transition.emit("PlayerTurn")


func _opponent_turn() -> void:
	await machine.spin_cage()
	transition.emit("OpponentTurn")
