extends State
class_name PlayerTurnState

@onready var player_turn_ui: Control = %PlayerTurnUI


func _ready() -> void:
	var end_turn_button = player_turn_ui.get_node("EndTurnButton") as Button
	end_turn_button.pressed.connect(_on_end_turn_button_pressed)
	
	
func _on_end_turn_button_pressed() -> void:
	transition.emit("OpponentTurn")
