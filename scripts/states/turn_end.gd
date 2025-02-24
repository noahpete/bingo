class_name TurnEndState
extends State

@export var game_manager: GameManager
@export var ai_manager: AIManager

func enter() -> void:
	# perform end of turn tasks...
	if GameManager.has_bingo("Opponent"):
		transition.emit("GameLose")
		
	game_manager.turn_number += 1
	
	await get_tree().create_timer(1.0).timeout
	
	transition.emit("TurnStart")
