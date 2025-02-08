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
	
	# Get the collision point from the raycast
	var intersection_point = ray_cast_3d.get_collision_point()
	
	# Instantiate the dab object and set its position to the intersection point
	var dab = dab_scene.instantiate()
	dab.global_transform.origin = intersection_point
	await util.wait(0.1)
	dab_manager.add_child(dab)
