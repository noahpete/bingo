class_name GameManager
extends Node

@export var camera_manager: CameraManager


func _ready() -> void:
	await camera_manager.to_idle()
	await camera_manager.to_dabbing()
	await camera_manager.to_idle()
