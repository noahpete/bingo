class_name ClickableComponent
extends Component

signal clicked
signal mouse_enter
signal mouse_leave

var is_hovering_over_parent := false
var camera_3d: Camera3DRaycast

static var global_disable: bool = false


func _ready() -> void:
	component_ready()
	assert(parent.find_child("CollisionShape3D"), "Cannot locate CollisionShape3D for ClickableComponent.")
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
	

func set_active(state: bool) -> void:
	is_active = state
	was_active = state
	

static func disable_all() -> void:
	for clickable in get_active_clickable_components():
		clickable.was_active = clickable.is_active
		clickable.is_active = false
	global_disable = true


static func restore_all() -> void:
	for clickable in get_active_clickable_components():
		clickable.active = clickable.persistent_active_state
	global_disable = false


static func get_active_clickable_components() -> Array:
	var hover_components: Array = []
	var scene_tree = Engine.get_main_loop()
	if scene_tree:
		var root = scene_tree.current_scene
		if root:
			_collect_clickable_components(root, hover_components)
	return hover_components


static func _collect_clickable_components(node: Node, result: Array) -> void:
	if node is HoverComponent:
		result.append(node)
	for child in node.get_children():
		_collect_clickable_components(child, result)
