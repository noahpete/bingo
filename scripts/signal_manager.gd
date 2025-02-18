class_name SignalManager
extends Node

@onready var camera_manager: CameraManager = $"../CameraManager"
@onready var state_machine: StateMachine = $"../StateMachine"


func _ready() -> void:
	var transition_signal := state_machine.current_state.transition
	
	#$"../Level/Board/ClickableComponent".clicked.connect(transition_signal.emit)
