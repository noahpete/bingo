class_name DaubingState
extends State

@onready var camera_manager: CameraManager = $"../../CameraManager"
@onready var board_hover_component: HoverComponent = $"../../Level/Board/HoverComponent"
@onready var dauber_hover_component: HoverComponent = $"../../Level/Dauber/HoverComponent"


func enter() -> void:
	camera_manager.to_dabbing()
	board_hover_component.active = false
	dauber_hover_component.active = false
