class_name ComponentManager
extends Node

static var components: Dictionary = {} ## Maps type names to arrays of Components.


static func register(component: Component) -> void:
	var type = component.name
	if not components.has(type):
		components[type] = []
	if component not in components[type]:
		components[type].append(component)
		
		
static func unregister(component: Component) -> void:
	var type = component.name
	if components.has(type):
		components[type].erase(component)
		if components[type].is_empty():
			components.erase(type)


static func get_components_of_type(type: String) -> Array[Component]:
	if components.has(type):
		return components[type]
	return []
	

static func disable_components_of_type(type: String) -> void:
	if not components.has(type):
		return
	for component in components[type]:
		component.is_active = false


static func enable_components_of_type(type: String) -> void:
	if not components.has(type):
		return
	for component in components[type]:
		component.is_active = true
	

static func restore_components_of_type(type: String) -> void:
	if not components.has(type):
		return
	for component in components[type]:
		component.is_active = component.was_active
