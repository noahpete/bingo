class_name CigarettePack
extends Node3D

const USE_MOVE_SPEED = 0.4

@onready var pack: Node3D = $Model/Pack
@onready var lid: Node3D = $Model/Pack/Lid
@onready var middle_cig: Node3D = $Model/MiddleCig

var cig_scene: PackedScene = preload("res://scenes/entities/cigarettes/cig.glb")

var use_position: Node3D
var cig_position: Node3D


func _ready() -> void:
	pass
	#freeze = true
	

func get_cig() -> void:
	var rotation_tween = create_tween()
	rotation_tween.tween_property(lid, "rotation_degrees", Vector3(0.0, 0.0, 90.0), 0.2)
	await rotation_tween.finished
	
	var position_tween = create_tween()
	position_tween.tween_property(middle_cig, "position", Vector3(0.024, 0.16, 0.002), 0.1)
	
	
func throw_out_pack() -> void:
	#freeze = false
	
	var direction = Vector3(-1.0, 0.5, -1.0).normalized()
	var strength = 0.8
	
	#set_angular_velocity(Vector3(0.0, 0.0, 10.0))
	
	#apply_impulse(direction * strength, Vector3(10.0, 10.0, 0.0))
	

func move_to_use_position() -> void:
	if not use_position: return
	
	var position_tween = create_tween()
	position_tween.tween_property(self, "global_position", use_position.global_position, USE_MOVE_SPEED)
	
	var rotation_tween = create_tween()
	rotation_tween.tween_property(self, "rotation_degrees", Vector3.ZERO, USE_MOVE_SPEED)
	
	await position_tween.finished
	

func _on_clickable_component_clicked() -> void:
	var player_state_machine = StateMachine.get_state_machine("PlayerStateMachine")
	player_state_machine.current_state.transition.emit("Animation")
	
	await move_to_use_position()
	await get_tree().create_timer(0.1).timeout
	
	await get_cig()
	await get_tree().create_timer(0.2).timeout
	
	throw_out_pack()
	#await position_cig()
	
	# Move/despawn pack
	
	# Move cig to cig_position
	
	# Light cig
	
	# 
	
	player_state_machine.current_state.transition.emit("Idle")
