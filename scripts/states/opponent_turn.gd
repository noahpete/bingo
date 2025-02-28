class_name OpponentTurnState
extends State

@export var player_state_machine: StateMachine

@onready var machine: Machine = %Machine


func enter() -> void:
	if player_state_machine.current_state is not ViewingState:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	await get_tree().create_timer(1.0).timeout
	var ball_value = GameManager.draw_ball()
	machine.set_display(str(ball_value))
	
	await _take_turn()
	
	transition.emit("TurnEnd")


func _take_turn() -> void:
	await get_tree().create_timer(2.0).timeout
	
