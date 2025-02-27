class_name HoverComponent
extends Node

@export var height: float = 0.04
@export var animation_length_sec: float = 0.1

@onready var parent: Node3D = $".."

var camera_3d: Camera3DRaycast
var original_position: Vector3
var active: bool = true
var persistent_active_state: bool = true

static var global_disable: bool = false


func _ready() -> void:
	original_position = parent.position
	camera_3d = get_viewport().get_camera_3d()
	if not camera_3d or camera_3d is not Camera3DRaycast:
		push_error("Unable to find camera usable for hover component.")


func _unhandled_input(event: InputEvent) -> void:
	if not active or global_disable:
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


func set_active(state: bool) -> void:
	active = state
	if state:
		persistent_active_state = true
	else:
		persistent_active_state = false


static func disable_all() -> void:
	for hover in get_active_hover_components():
		hover.persistent_active_state = hover.active
		hover.active = false
	global_disable = true


static func restore_all() -> void:
	for hover in get_active_hover_components():
		hover.active = hover.persistent_active_state
	global_disable = false


static func get_active_hover_components() -> Array:
	var hover_components: Array = []
	var scene_tree = Engine.get_main_loop()
	if scene_tree:
		var root = scene_tree.current_scene
		if root:
			_collect_hover_components(root, hover_components)
	return hover_components


static func _collect_hover_components(node: Node, result: Array) -> void:
	if node is HoverComponent:
		result.append(node)
	for child in node.get_children():
		_collect_hover_components(child, result)
