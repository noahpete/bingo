extends State
class_name IdleState

# State where player sees table and items on the table, can hover over 
# and select items in this state.



@onready var input_manager: InputManager = $"../../InputManager"
@onready var item_manager: ItemManager = $"../../ItemManager"
@onready var main: Main = $"../.."




func enter() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	
			
func exit() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)



	


	
