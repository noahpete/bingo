class_name ViewingState
extends State

@export var camera_manager: CameraManager

var is_in_viewing_state: bool = false


func enter() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	await camera_manager.to_viewing()
	is_in_viewing_state = true
	
	
func exit() -> void:
	is_in_viewing_state = false


func input(event: InputEvent) -> void:
	if is_in_viewing_state and event.is_action_pressed("select"):
		transition.emit("Idle")
