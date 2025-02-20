class_name Dab
extends Node3D


@export var dab_color: Color = "3576ff"
@export var dabs: Array[Texture2D]

@onready var decal: Decal = $Decal


func _ready() -> void:
	decal.texture_albedo = dabs.pick_random()
	decal.modulate = dab_color
	
	var tween = create_tween()
	tween.tween_property(decal, "scale", Vector3.ONE, 0.02)
