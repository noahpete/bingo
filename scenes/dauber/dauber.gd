class_name Dauber
extends Node3D

const DAUBER_HOVER_HEIGHT := 0.06
const DAUBER_MOVE_SPEED := 0.02
const DAUBER_DAB_SPEED := 0.12
const DAUBER_DAB_TIME := 0.05

@export var dab_scene: PackedScene
@export var dab_parent: Node3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var dauber_mesh: MeshInstance3D = $Dauber

var original_position: Vector3
var opacity_tween: Tween


func _ready() -> void:
	original_position = position


func _process(delta: float) -> void:
	_handle_dimming()


func dab() -> void:
	await _dab_animation()
	if not ray_cast_3d.get_collider():
		return
	var dab_instance = dab_scene.instantiate()
	dab_parent.add_child(dab_instance)
	dab_instance.position = ray_cast_3d.get_collision_point()
	
	
func _dab_animation() -> void:
	var position_tween = create_tween()
	position_tween.tween_property(
		self,
		"position:y",
		original_position.y + 0.02,
		DAUBER_DAB_SPEED
	)
	await position_tween.finished
	await get_tree().create_timer(DAUBER_DAB_TIME).timeout
	position_tween = create_tween()
	position_tween.tween_property(
		self,
		"position:y",
		original_position.y + DAUBER_HOVER_HEIGHT,
		DAUBER_DAB_SPEED
	)


func _handle_dimming() -> void:
	var result = ray_cast_3d.get_collider()
	var material = dauber_mesh.get_active_material(0)
	
	if not material:
		return
	
	if opacity_tween and opacity_tween.is_running():
		opacity_tween.kill()

	opacity_tween = create_tween()

	if result and result.get_parent().get_parent() is Board:
		opacity_tween.tween_property(material, "albedo_color:a", 0.2, 0.1)
	else:
		opacity_tween.tween_property(material, "albedo_color:a", 1.0, 0.1)
	
	
