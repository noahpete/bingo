extends Node
class_name InputManager

@onready var camera_3d: Camera3D = %Camera3D
@onready var camera_ray_cast_3d: RayCast3D = %CameraRayCast3D


func raycast(include_areas: bool = false, collision_mask: int = 1):
	var mouse_position = get_viewport().get_mouse_position()
	
	var ray_origin = camera_3d.project_ray_origin(mouse_position)
	var ray_direction = camera_3d.project_ray_normal(mouse_position)
	
	var ray_length = 10.0
	var ray_end = ray_origin + ray_direction * ray_length
	
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = ray_origin
	ray_query.to = ray_end
	ray_query.collide_with_areas = include_areas
	ray_query.collision_mask = collision_mask

	var result = camera_3d.get_world_3d().direct_space_state.intersect_ray(ray_query)
	
	if result:
		return result
	return null
