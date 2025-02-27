class_name IdleState
extends State

@export var camera_manager: CameraManager
@export var dauber: Dauber


func _ready() -> void:
	dauber.get_node("ClickableComponent").clicked.connect(_to_viewing_state)
	

func enter() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	dauber.get_node("Decal").visible = false
	dauber.get_node("HoverComponent").active = false
	await camera_manager.to_idle()
	dauber.get_node("HoverComponent").active = true
	HoverComponent.restore_all()
	

func exit() -> void:
	HoverComponent.disable_all()
	

func _to_viewing_state() -> void:
	if is_active_state:
		transition.emit("Viewing")
