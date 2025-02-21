class_name PlayerTurnState
extends State

@onready var game_state_machine: StateMachine = $".."
@onready var button: Button3D = $"../../Level/Button"


func _ready() -> void:
	button.get_node("ClickableComponent").clicked.connect(_player_turn_end)
	
	
func enter() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _player_turn_end() -> void:
	if is_active_state:
		transition.emit("TurnEnd")
