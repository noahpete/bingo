class_name ItemManager
extends Node

@export var cig_pack: PackedScene
@export var cig_spawn: Node3D

@onready var item_use_position: Node3D = %ItemUsePosition


func spawn_cigs() -> void:
	var cig_pack_inst = cig_pack.instantiate() as CigarettePack
	cig_pack_inst.rotation_degrees = Vector3(-90.0, 0, 0)
	cig_pack_inst.position.y += 0.004
	cig_pack_inst.use_position = item_use_position
	cig_spawn.add_child(cig_pack_inst)


func _on_button_pressed() -> void:
	spawn_cigs()
