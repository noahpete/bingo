class_name CameraManager
extends Node

const CAMERA_MOVE_SPEED = 0.25

const IDLE_POSITION = Vector3(0.0, 0.95, 1.05)
const IDLE_ROTATION = Vector3(-15.0, 0.0, 0.0)
const IDLE_FOV = 65.0

const DAUBING_POSITION = Vector3(0.0, 0.95, 0.75)
const DAUBING_ROTATION = Vector3(-45.0, 0.0, 0.0)
const DAUBING_FOV = 40.0

const VIEWING_POSITION = Vector3(0.0, 0.75, 0.36)
const VIEWING_ROTATION = Vector3(-40.0, 0.0, 0.0)
const VIEWING_FOV = 50.0

@export var camera_3d: Camera3D
	

func move_to(position: Vector3, rotation: Vector3, fov: float) -> void:
	var position_tween = create_tween()
	var rotation_tween = create_tween()
	var fov_tween = create_tween()
	
	var radians = Vector3(deg_to_rad(rotation.x), deg_to_rad(rotation.y), deg_to_rad(rotation.z))
	
	position_tween.tween_property(camera_3d, "position", position, CAMERA_MOVE_SPEED)
	rotation_tween.tween_property(camera_3d, "rotation", radians, CAMERA_MOVE_SPEED)
	fov_tween.tween_property(camera_3d, "fov", fov, CAMERA_MOVE_SPEED)
	
	await position_tween.finished


func to_idle() -> void:
	await move_to(IDLE_POSITION, IDLE_ROTATION, IDLE_FOV)


func to_daubing() -> void:
	await move_to(DAUBING_POSITION, DAUBING_ROTATION, DAUBING_FOV)


func to_viewing() -> void:
	await move_to(VIEWING_POSITION, VIEWING_ROTATION, VIEWING_FOV)
