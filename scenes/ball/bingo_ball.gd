extends RigidBody3D
class_name BingoBall


func _process(delta: float) -> void:
	pass

func set_velocity(vector: Vector3) -> void:
	linear_velocity = vector
