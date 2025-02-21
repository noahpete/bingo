class_name IdleState
extends State

@onready var camera_manager: CameraManager = $"../../CameraManager"
@onready var dauber: Dauber = $"../../Level/Dauber"


func _ready() -> void:
	dauber.get_node("ClickableComponent").clicked.connect(_to_daubing_state)


func enter() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	dauber.get_node("Decal").visible = false
	dauber.get_node("HoverComponent").active = false
	camera_manager.to_idle()
	await get_tree().create_timer(0.1).timeout
	dauber.get_node("HoverComponent").active = true
	

func exit() -> void:
	dauber.get_node("HoverComponent").active = false
	dauber.get_node("HoverComponent").active = false
	

func _to_daubing_state() -> void:
	if is_active_state:
		transition.emit("Daubing")
