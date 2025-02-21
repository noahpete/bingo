class_name Machine
extends Node3D

@onready var cage: Node3D = $Cage

func spin_cage() -> void:
	var tween = create_tween()
	tween.tween_property(
		cage, 
		"rotation:y", 
		deg_to_rad(1080), 
		2.0
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
