class_name Camera3DRaycast
extends Camera3D

@onready var ray_cast_3d: RayCast3D = $RayCast3D


func raycast_bodies(collision_mask: int = 1):
	var mouse_position = get_viewport().get_mouse_position()
	
	var ray_origin = project_ray_origin(mouse_position)
	var ray_direction = project_ray_normal(mouse_position)
	
	var ray_length = 10.0
	var ray_end = ray_origin + ray_direction * ray_length
	
	var query = PhysicsRayQueryParameters3D.new()
	query.from = ray_origin
	query.to = ray_end
	query.collision_mask = collision_mask
	
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	
	if result:
		return result
	else:
		return null


func raycast_areas(collision_mask: int = 1):
	var mouse_position = get_viewport().get_mouse_position()
	
	var ray_origin = project_ray_origin(mouse_position)
	var ray_direction = project_ray_normal(mouse_position)
	
	var ray_length = 10.0
	var ray_end = ray_origin + ray_direction * ray_length
	
	var query = PhysicsRayQueryParameters3D.new()
	query.from = ray_origin
	query.to = ray_end
	query.collision_mask = collision_mask
	
	query.collide_with_areas = true
	query.collide_with_bodies = false
	
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	
	if result:
		return result
	else:
		return null


func raycast_bodies_and_areas(collision_mask: int = 1):
	var mouse_position = get_viewport().get_mouse_position()
	
	var ray_origin = project_ray_origin(mouse_position)
	var ray_direction = project_ray_normal(mouse_position)
	
	var ray_length = 10.0
	var ray_end = ray_origin + ray_direction * ray_length
	
	var query = PhysicsRayQueryParameters3D.new()
	query.from = ray_origin
	query.to = ray_end
	query.collision_mask = collision_mask
	
	query.collide_with_areas = true
	query.collide_with_bodies = true
	
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	
	if result:
		return result
	else:
		return null
