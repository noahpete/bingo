extends Node
class_name ItemManager

const ITEM_HOVER_HEIGHT = 0.04
const ITEM_HOVER_ANIMATION_DURATION = 0.1

@onready var input_manager: InputManager = $"../InputManager"
@onready var items: Node3D = %Items

var current_hovered_item: Item = null
var item_is_tweening: bool = false


func handle_item_hovering() -> void:
	var result = input_manager.raycast(true)
	if result and result.collider.get_parent() is Item:
		var item = result.collider.get_parent() as Item
		if current_hovered_item != item:
			_reset_hovered_item()
			current_hovered_item = item
			_hover_item(item)
	else:
		_reset_hovered_item()


func _hover_item(item: Item) -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	var target_position = item.original_position + Vector3(0, ITEM_HOVER_HEIGHT, 0)
	var tween = create_tween()
	tween.tween_property(item, "global_transform:origin", target_position, ITEM_HOVER_ANIMATION_DURATION)
	
	
func _reset_hovered_item() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	if current_hovered_item:
		var tween = create_tween()
		tween.tween_property(current_hovered_item, "global_transform:origin", current_hovered_item.original_position, ITEM_HOVER_ANIMATION_DURATION)
		current_hovered_item = null
