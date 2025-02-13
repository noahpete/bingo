extends Node3D
class_name Item

var original_position: Vector3
var original_rotation: Vector3


func _ready() -> void:
	original_position = transform.origin
	original_rotation = rotation
