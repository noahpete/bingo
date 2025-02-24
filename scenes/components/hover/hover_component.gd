class_name HoverComponent
extends Node

@export var height: float = 0.04
@export var animation_length_sec: float = 0.1

@onready var parent: Node3D = $".."

var camera_3d: Camera3DRaycast
var original_position: Vector3
var active: bool = true

func _ready() -> void:
	original_position = parent.position
	camera_3d = get_viewport().get_camera_3d()
	if not camera_3d or camera_3d is not Camera3DRaycast:
		push_error("Unable to find camera usable for hover component.")
	
func _unhandled_input(event: InputEvent) -> void:
	if not active:
		return
	if event is not InputEventMouseMotion:
		return
	var result = camera_3d.raycast_areas()
	if result and result.collider.get_parent() == parent:
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
