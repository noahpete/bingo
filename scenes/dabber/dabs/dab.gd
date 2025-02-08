extends Node3D
class_name Dab

@export var dab_color: Color = "3576ff"
@export var dabs: Array[Texture2D]

@onready var decal: Decal = $Decal


func _ready() -> void:
	decal.texture_albedo = dabs.pick_random()
	decal.modulate = dab_color
