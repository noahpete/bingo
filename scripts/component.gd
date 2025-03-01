class_name Component
extends Node

var parent: Node

var is_active: bool = true:
	set(value):
		was_active = is_active
		is_active = value
var was_active: bool = false


func _ready() -> void:
	parent = get_parent()
	ComponentManager.register(self)
		
		
func _exit_tree() -> void:
	ComponentManager.unregister(self)
