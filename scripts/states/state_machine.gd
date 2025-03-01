class_name StateMachine
extends Node

@export var current_state: State

static var state_machines: Dictionary = {}

var states: Dictionary = {}
var previous_state: State = null


func _ready() -> void:
	state_machines[self.name] = self
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transition.connect(_on_child_transition)
		else:
			push_warning("State machine contains incomptible child node!")
	_on_initial_enter.call_deferred()
	
	
func _process(delta: float) -> void:
	current_state.update(delta)


func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)
	
	
func _input(event: InputEvent) -> void:
	current_state.input(event)
	
	
func _on_initial_enter() -> void:
	current_state.is_active_state = true
	current_state.enter()
	
	
func _on_child_transition(new_state_name: StringName) -> void:
	var new_state = states.get(new_state_name)
	if new_state:
		if new_state != current_state:
			print("[" + self.name + "]: " + "Transitioning from [" + current_state.name + "] to [" + new_state.name + "]")
			current_state.exit()
			current_state.is_active_state = false
			new_state.is_active_state = true
			new_state.enter()
			previous_state = current_state
			current_state = new_state
	else:
		push_warning("State [" + new_state_name + "] does not exist")


static func get_state_machine(state_machine_name: String) -> StateMachine:
	return state_machines[state_machine_name]
