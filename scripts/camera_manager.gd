class_name CameraManager
extends Node

const CAMERA_MOVE_SPEED = 0.4

const IDLE_POSITION = Vector3(0.0, 1.1, 1.05)
const IDLE_ROTATION = Vector3(-20.0, 0.0, 0.0)
const IDLE_FOV = 65.0

const DABBING_POSITION = Vector3(0.0, 0.872, 0.55)
const DABBING_ROTATION = Vector3(-70.0, 0.0, 0.0)
const DABBING_FOV = 45.0

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


func to_dabbing() -> void:
	await move_to(DABBING_POSITION, DABBING_ROTATION, DABBING_FOV)
