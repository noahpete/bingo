extends State
class_name OpponentTurnState

@onready var opponent_turn_ui: Control = %OpponentTurnUI
@onready var item_manager: ItemManager = $"../../ItemManager"
@onready var game_manager: GameManager = $"../../GameManager"


func enter() -> void:
	opponent_turn_ui.visible = true
	
	#if opponent is ai
	game_manager.take_ai_turn()


func exit() -> void:
	opponent_turn_ui.visible = false
	
	game_manager.end_ai_turn()

func input_update(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		item_manager.handle_item_hovering()
	
	elif event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if item_manager.current_hovered_item is Dabber:
				transition.emit("Marking")
