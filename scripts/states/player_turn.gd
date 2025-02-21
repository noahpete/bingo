class_name PlayerTurnState
extends State

@onready var player_state_machine: StateMachine = $"../../PlayerStateMachine"
@onready var game_state_machine: StateMachine = $".."
@onready var button: Button3D = $"../../Level/Button"


func _ready() -> void:
	button.get_node("ClickableComponent").clicked.connect(_player_turn_end)
	
	
func enter() -> void:
	pass


func _player_turn_end() -> void:
	if is_active_state:
		transition.emit("TurnEnd")
