class_name DebugManager
extends Node

@onready var debug_panel: DebugPanel = %DebugPanel
@onready var line_edit: LineEdit = %LineEdit
@onready var game_manager: GameManager = $"../GameManager"
@onready var game_state_machine: StateMachine = %GameStateMachine


func _ready() -> void:
	line_edit.text_submitted.connect(_on_text_submitted)
	

func _process(delta: float) -> void:
	debug_panel.add_property("Game State", game_state_machine.current_state.name, 1)
	debug_panel.add_property("Drawn balls", game_manager.drawn_balls, 2)
	debug_panel.add_property("Player bingo?", GameManager.has_bingo("Player"), 3)
	debug_panel.add_property("Comps", ComponentManager.components, 4)
	
	
func _on_text_submitted(input_text: String):
	var number = input_text.to_int()
	if number != null:
		GameManager.debug_draw_ball(number)
