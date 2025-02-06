extends Camera3D
		
@export var look_sensitivity := 0.006
@export var x_clamp_min := -90.0
@export var x_clamp_max := 90.0
@export var y_clamp_min := -INF
@export var y_clamp_max := INF

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation.y -= event.relative.x * look_sensitivity
		rotation.y = clamp(rotation.y, deg_to_rad(y_clamp_min), deg_to_rad(y_clamp_max))
		rotation.x = clamp(rotation.x - event.relative.y * look_sensitivity, deg_to_rad(x_clamp_min), deg_to_rad(x_clamp_max))
