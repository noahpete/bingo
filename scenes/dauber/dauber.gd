class_name Dauber
extends Node3D

const DAUBER_HOVER_HEIGHT := 0.06
const DAUBER_MOVE_SPEED := 0.02
const DAUBER_DAB_SPEED := 0.12
const DAUBER_DAB_TIME := 0.05

@export var dab_scene: PackedScene
@export var dab_parent: Node3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D

var original_position: Vector3


func _ready() -> void:
	original_position = position

func dab() -> void:
	await _dab_animation()
	
	var result = ray_cast_3d.get_collider()
	if not result:
		print("NO RESULT WOMP WOMP")
		return
	print("instantiating dab")
	var dab = dab_scene.instantiate()
	dab_parent.add_child(dab)
	dab.position = ray_cast_3d.get_collision_point()
	
	
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
