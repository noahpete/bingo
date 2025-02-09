extends Item
class_name Dabber

@export var dab_scene: PackedScene
@export var dab_manager: Node3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var util: Util = $"../../../Util"


func dab() -> void:
	var result = ray_cast_3d.get_collider()
	if not result:
		return
	
	var intersection_point = ray_cast_3d.get_collision_point()
	
	var dab = dab_scene.instantiate()
	await util.wait(0.1)
	dab_manager.add_child(dab)
	dab.global_transform.origin = intersection_point
