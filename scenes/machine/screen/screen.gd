class_name Screen
extends MeshInstance3D

@onready var label: Label = %Label


func set_display(text: String) -> void:
	label.text = text
	if int(text) < 10:
		label.position.x += 4
