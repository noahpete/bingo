class_name DebugManager
extends Node

@onready var debug_panel: DebugPanel = $"../UI/DebugPanel"
@onready var line_edit: LineEdit = %LineEdit
@onready var game_manager: GameManager = $"../GameManager"


func _ready() -> void:
	line_edit.connect("text_submitted", _on_text_submitted)
	

func _process(delta: float) -> void:
	debug_panel.add_property("Drawn balls", game_manager.drawn_balls, 1)
	debug_panel.add_property("Has bingo", game_manager.has_bingo("Player"), 2)
	
	
func _on_text_submitted(input_text: String):
	var number = input_text.to_int()
	if number != null:
		game_manager.debug_draw_ball(number)
