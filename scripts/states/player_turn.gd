class_name PlayerTurnState
extends State

@export var player_state_machine: StateMachine
@export var game_state_machine: StateMachine
@export var button: Button3D

@onready var machine: Machine = %Machine


func _ready() -> void:
	pass
	#button.get_node("ClickableComponent").clicked.connect(_player_turn_end)
	
	
func enter() -> void:
	await machine.dispense_ball()


func _player_turn_end() -> void:
	if is_active_state:
		transition.emit("TurnEnd")
