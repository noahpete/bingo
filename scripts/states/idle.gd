class_name IdleState
extends State

@onready var camera_manager: CameraManager = $"../../CameraManager"


func _ready() -> void:
	$"../../Level/Board/ClickableComponent".clicked.connect(_to_daubing_state)

func enter() -> void:
	camera_manager.to_idle()


func _to_daubing_state() -> void:
	transition.emit("Daubing")
