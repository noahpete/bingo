class_name IdleState
extends State

@onready var camera_manager: CameraManager = $"../../CameraManager"
@onready var dauber_clickable_component: ClickableComponent = $"../../Level/Dauber/ClickableComponent"
@onready var dauber_hover_component: HoverComponent = $"../../Level/Dauber/HoverComponent"


func _ready() -> void:
	dauber_clickable_component.clicked.connect(_to_daubing_state)


func enter() -> void:
	dauber_hover_component.active = false
	camera_manager.to_idle()
	await get_tree().create_timer(0.1).timeout
	dauber_hover_component.active = true
	

func exit() -> void:
	dauber_hover_component.active = false
	

func _to_daubing_state() -> void:
	transition.emit("Daubing")
