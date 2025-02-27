class_name DaubingState
extends State

const DAUBER_HOVER_HEIGHT := 0.06
const DAUBER_MOVE_SPEED := 0.02
const DAUBER_ROTATE_SPEED := 0.4
const DAUBER_RETURN_SPEED := 0.1

@export var camera_3d: Camera3DRaycast
@export var camera_manager: CameraManager
@export var dauber: Dauber
@export var dauber_return_area: Area3D

var dauber_original_rotation: Vector3

var is_animating: bool = false
var is_hovering_over_return: bool = false


func _ready() -> void:
	dauber_original_rotation = dauber.rotation
	
	
func enter() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	_rotate_dauber_upright()
	
	is_animating = true
	camera_manager.to_viewing()
	dauber.position.y = dauber.original_position.y + DAUBER_HOVER_HEIGHT
	is_animating = false
	
	dauber_return_area.get_node("CollisionShape3D").disabled = false


func exit() -> void:
	_reset_flags()
	_rotate_dauber_down()
	dauber_return_area.get_node("CollisionShape3D").disabled = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func update(delta: float) -> void:
	_move_dauber_to_mouse()
	_handle_dauber_return()
	

func input(event: InputEvent) -> void:
	if is_animating:
		return
	if event.is_action_pressed("select"):
		if is_hovering_over_return:
			transition.emit("Idle")
		else:
			dauber.dab()
			
			
func _reset_flags() -> void:
	is_animating = false
	is_hovering_over_return = false


func _move_dauber_to_mouse() -> void:
	var result = camera_3d.raycast_bodies()
	if result:
		var target_position = Vector3(
			result.position.x,
			0.0,
			result.position.z
		)
		var position_tween = create_tween()
		position_tween.tween_property(dauber, "position:x", target_position.x, DAUBER_MOVE_SPEED)
		position_tween.tween_property(dauber, "position:z", target_position.z, DAUBER_MOVE_SPEED)
		
		
func _rotate_dauber_upright() -> void:
	dauber.get_node("Decal").visible = true
	is_animating = true
	var tween = create_tween()
	tween.tween_property(dauber, "rotation", Vector3(0.0, deg_to_rad(51.8), deg_to_rad(180.0)), DAUBER_ROTATE_SPEED)
	await tween.finished
	is_animating = false


func _rotate_dauber_down() -> void:
	dauber.get_node("Decal").visible = false
	is_animating = true
	var tween = create_tween()
	tween.tween_property(dauber, "rotation", dauber_original_rotation, DAUBER_ROTATE_SPEED)
	await tween.finished
	is_animating = false
	


func _handle_dauber_return() -> void:
	var result = camera_3d.raycast_areas(2)
	is_hovering_over_return = result and result.collider == dauber_return_area
	if result and result.collider == dauber_return_area:
		var tween = create_tween()
		tween.tween_property(dauber, "position", dauber.original_position, DAUBER_RETURN_SPEED)
		_rotate_dauber_down()
	else:
		dauber.position.y = dauber.original_position.y + DAUBER_HOVER_HEIGHT
		_rotate_dauber_upright()
