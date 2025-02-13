extends CanvasLayer
class_name MainMenu


func _ready() -> void:
	%PlayButton.pressed.connect(_on_play_pressed)
	
	
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
