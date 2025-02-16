extends Node
class_name GameManager

signal ball_retrieved

@onready var opponent_turn_ui: Control = %OpponentTurnUI


func take_ai_turn() -> void:
	await %Util.wait(1.0)
	var ball_number = GameData.draw_ball_number()
	(opponent_turn_ui.get_node("CenterContainer/Label") as Label).text = str(ball_number)
	

func end_ai_turn() -> void:
	(opponent_turn_ui.get_node("CenterContainer/Label") as Label).text = ""
