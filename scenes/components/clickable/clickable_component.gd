class_name ClickableComponent
extends Node

signal clicked
signal mouse_enter
signal mouse_leave

@onready var parent: Node3D = $".."

var is_hovering_over_parent := false
var camera_3d: Camera3DRaycast


func _ready() -> void:
	camera_3d = get_viewport().get_camera_3d()
	if not camera_3d or camera_3d is not Camera3DRaycast:
		push_error("Unable to find camera usable for clickable component.")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("select") and is_hovering_over_parent:
		clicked.emit()


func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventMouseMotion:
		return

	var result = camera_3d.raycast_areas()
	var currently_hovering = result and result.collider.get_parent() == parent

	if currently_hovering and not is_hovering_over_parent:
		mouse_enter.emit()
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

	elif not currently_hovering and is_hovering_over_parent:
		mouse_leave.emit()
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

	is_hovering_over_parent = currently_hovering
