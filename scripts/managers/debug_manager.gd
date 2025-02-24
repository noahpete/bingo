class_name DebugManager
extends Node

@onready var debug_panel: DebugPanel = $"../UI/DebugPanel"
@onready var line_edit: LineEdit = %LineEdit
@onready var game_manager: GameManager = $"../GameManager"
@onready var game_state_machine: StateMachine = $"../GameStateMachine"
@onready var button: Button = $"../UI/DebugPanel/MarginContainer/VBoxContainer/Button"


func _ready() -> void:
	line_edit.text_submitted.connect(_on_text_submitted)
	button.pressed.connect(_on_button_press)
	

func _process(delta: float) -> void:
	debug_panel.add_property("Game State", game_state_machine.current_state.name, 1)
	debug_panel.add_property("Drawn balls", game_manager.drawn_balls, 2)
	debug_panel.add_property("Player bingo?", game_manager.has_bingo("Player"), 3)
	
	
func _on_text_submitted(input_text: String):
	var number = input_text.to_int()
	if number != null:
		game_manager.debug_draw_ball(number)


func _on_button_press() -> void:
	GameManager.remove_spot_from_play(0, 1)
