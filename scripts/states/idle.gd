class_name IdleState
extends State

@export var camera_manager: CameraManager
@export var dauber: Dauber

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var pack: CigarettePack = %CigarettePack


func _ready() -> void:
	dauber.get_node("ClickableComponent").clicked.connect(_to_viewing)
	pack.get_node("ClickableComponent").clicked.connect(_to_animation)
	

func enter() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	dauber.get_node("Decal").visible = false
	ComponentManager.disable_components_of_type("HoverComponent")
	await camera_manager.to_idle()
	ComponentManager.enable_components_of_type("HoverComponent")
	

func exit() -> void:
	ComponentManager.disable_components_of_type("HoverComponent")
	

func _to_viewing() -> void:
	if is_active_state:
		transition.emit("Viewing")


func _to_animation() -> void:
	if is_active_state:
		transition.emit("Animation")
