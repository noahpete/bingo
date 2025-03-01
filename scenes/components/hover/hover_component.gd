class_name HoverComponent
extends Component

@export var height: float = 0.04
@export var animation_length_sec: float = 0.1

var camera_3d: Camera3DRaycast
var original_position: Vector3


func _ready() -> void:
	super()
	original_position = parent.position
	camera_3d = get_viewport().get_camera_3d()
	if not camera_3d or camera_3d is not Camera3DRaycast:
		push_error("Unable to find camera usable for hover component.")


func _exit_tree() -> void:
	super()
	

func _unhandled_input(event: InputEvent) -> void:
	if not is_active:
		return
	if event is not InputEventMouseMotion:
		return
	var result = camera_3d.raycast_bodies_and_areas()
	if result and (result.collider.get_owner() == parent):
		_hover()
	else:
		_unhover()


func _hover() -> void:
	var tween = create_tween()
	tween.tween_property(parent, "position", original_position + Vector3.UP * height, animation_length_sec)
	await tween.finished


func _unhover() -> void:
	var tween = create_tween()
	tween.tween_property(parent, "position", original_position, animation_length_sec)
	await tween.finished
