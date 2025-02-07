extends Node
class_name State

signal transition(new_state_name: StringName)


## Called just after a state transition to this state.
func enter() -> void:
	pass
	

## Called just before a state transition to another state.
func exit() -> void:
	pass
		

## Called in _process loop.
func update(delta: float) -> void:
	pass
	

## Called in _input.
func input_update(event: InputEvent) -> void:
	pass
	

## Called in _physics_process loop.
func physics_update(delta: float) -> void:
	pass
