class_name Component
extends Node

var parent: Node

var is_active: bool:
	set(value):
		was_active = is_active
		is_active = value
var was_active: bool


func component_ready() -> void:
	parent = get_parent()
	ComponentManager.register(self)
		
		
func component_exit_tree() -> void:
	ComponentManager.unregister(self)
