class_name State
extends Node

signal transition(new_state_name: StringName)

var is_active_state: bool = false


## Called just after a state transition to this state.
func enter() -> void:
	pass
	
	
## Called just before a state transition to another state.
func exit() -> void:
	pass
	
	
## Called in _process loop.
func update(delta: float) -> void:
	pass
	
	
## Called in physics_process loop.
func physics_update(delta: float) -> void:
	pass
		
	
## Called in _input.
func input(event: InputEvent) -> void:
	pass
