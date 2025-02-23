class_name TurnEndState
extends State

@export var game_manager: GameManager


func enter() -> void:
	# perform end of turn tasks...
	game_manager.turn_number += 1
	
	transition.emit("TurnStart")
