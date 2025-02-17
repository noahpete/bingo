class_name GameManager
extends Node

@export var camera_manager: CameraManager


func _ready() -> void:
	camera_manager.to_idle()
