class_name ViewingState
extends State

@export var camera_manager: CameraManager


func enter() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	camera_manager.to_viewing()


func input(event: InputEvent) -> void:
	if event.is_action_pressed("select"):
		transition.emit("Idle")
