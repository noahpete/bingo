extends State
class_name OpponentTurnState

@onready var opponent_turn_ui: Control = %OpponentTurnUI


func enter() -> void:
	opponent_turn_ui.visible = true


func exit() -> void:
	opponent_turn_ui.visible = false
