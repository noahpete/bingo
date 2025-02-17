class_name CameraManager
extends Node

const CAMERA_MOVE_SPEED = 0.8

const IDLE_POSITION = Vector3(0.0, 1.1, 1.0)
const IDLE_ROTATION = Vector3(-20.0, 0.0, 0.0)

@export var camera: Camera3D


func move_to(position: Vector3, rotation: Vector3) -> void:
	var tween = create_tween()
	var radians = Vector3(deg_to_rad(rotation.x), deg_to_rad(rotation.y), deg_to_rad(rotation.z))
	tween.tween_property(camera, "position", position, CAMERA_MOVE_SPEED)
	tween.tween_property(camera, "rotation", radians, CAMERA_MOVE_SPEED)
	await tween.finished


func to_idle() -> void:
	await move_to(IDLE_POSITION, IDLE_ROTATION)
