class_name DebugPanel
extends PanelContainer

@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer


func _ready() -> void:
	Global.debug = self
	
	
func add_property(title: String, value: Variant, order: int) -> void:
	var target = v_box_container.find_child(title, true, false)
	if not target:
		target = Label.new()
		v_box_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible:
		target.text = title + ": " + str(value)
		v_box_container.move_child(target, order)
