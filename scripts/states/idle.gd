extends State
class_name IdleState

# State where player sees table and items on the table, can hover over 
# and select items in this state.

const ITEM_HOVER_HEIGHT = 0.04
const ITEM_HOVER_ANIMATION_DURATION = 0.1

@onready var input_manager: InputManager = $"../../InputManager"
@onready var items: Node3D = %Items

var current_hovered_item: Item = null
var item_is_tweening: bool = false


func enter() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	for item in items.get_children():
			item.original_position = item.global_transform.origin
			
			
func exit() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	
			
func update(delta: float) -> void:
	pass


func input_update(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var result = input_manager.raycast(true)
		if result and result.collider.get_parent() is Item:
			var item = result.collider.get_parent() as Item
			if current_hovered_item != item:
				_reset_hovered_item() 
				current_hovered_item = item
				_hover_item(item)
		else:
			_reset_hovered_item()
			
	elif event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if current_hovered_item is Dabber:
				transition.emit("Marking")
	

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
