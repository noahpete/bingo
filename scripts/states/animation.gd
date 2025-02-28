class_name AnimationState
extends State


func enter() -> void:
	ComponentManager.disable_components_of_type("HoverComponent")
	ComponentManager.disable_components_of_type("ClickableComponent")


func exit() -> void:
	ComponentManager.restore_components_of_type("HoverComponent")
	ComponentManager.restore_components_of_type("ClickableComponent")


func to_idle() -> void:
	transition.emit("Idle")
