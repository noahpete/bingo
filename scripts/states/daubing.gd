class_name DaubingState
extends State

const DAUBER_HOVER_HEIGHT := 0.06
const DAUBER_MOVE_SPEED := 0.02
const DAUBER_ROTATE_SPEED := 0.4
const DAUBER_RETURN_SPEED := 0.1

@export var dab_scene: PackedScene

@onready var camera_3d: Camera3DRaycast = $"../../Camera3D"
@onready var camera_manager: CameraManager = $"../../CameraManager"
@onready var dauber: Dauber = $"../../Level/Dauber"
@onready var dauber_return_area: Area3D = $"../../Level/DauberReturnArea"

var dauber_original_rotation: Vector3

var is_animating: bool = false
var is_hovering_over_return: bool = false


func _ready() -> void:
	dauber_original_rotation = dauber.rotation
	
func _process(delta: float) -> void:
	Global.debug.add_property("is over return", is_hovering_over_return, 1)
	
func enter() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	dauber.get_node("HoverComponent").active = false
	_rotate_dauber_upright()
	
	is_animating = true
	await camera_manager.to_daubing()
	dauber.position.y = dauber.original_position.y + DAUBER_HOVER_HEIGHT
	is_animating = false
	
	dauber_return_area.get_node("CollisionShape3D").disabled = false


func exit() -> void:
	dauber.get_node("HoverComponent").active = true
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
	var tween = create_tween()
	var target_rotation = Vector3(0.0, deg_to_rad(51.8), deg_to_rad(180.0))
	tween.tween_property(dauber, "rotation", target_rotation, DAUBER_ROTATE_SPEED)
	await tween.finished
	dauber.get_node("Decal").visible = true


func _rotate_dauber_down() -> void:
	dauber.get_node("Decal").visible = false
	var tween = create_tween()
	tween.tween_property(dauber, "rotation", dauber_original_rotation, DAUBER_ROTATE_SPEED)
	await tween.finished


func _handle_dauber_return() -> void:
	var result = camera_3d.raycast_areas()
	
	is_hovering_over_return = result and result.collider == dauber_return_area
	
	if result and result.collider == dauber_return_area:
		var tween = create_tween()
		tween.tween_property(dauber, "position", dauber.original_position, DAUBER_RETURN_SPEED)
		_rotate_dauber_down()
	else:
		dauber.position.y = dauber.original_position.y + DAUBER_HOVER_HEIGHT
		_rotate_dauber_upright()
