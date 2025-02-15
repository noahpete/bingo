extends State
class_name OpponentTurnState

@onready var opponent_turn_ui: Control = %OpponentTurnUI
@onready var item_manager: ItemManager = $"../../ItemManager"


func enter() -> void:
	opponent_turn_ui.visible = true


func exit() -> void:
	opponent_turn_ui.visible = false


func input_update(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		item_manager.handle_item_hovering()
	
	elif event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if item_manager.current_hovered_item is Dabber:
				transition.emit("Marking")
