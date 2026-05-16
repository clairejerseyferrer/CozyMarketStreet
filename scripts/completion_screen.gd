extends TextureRect

func show_completion():
	visible = true


func _on_restart_button_pressed():
	DirAccess.remove_absolute("user://save.json")
	get_tree().reload_current_scene()


func _on_title_button_pressed():
	get_tree().change_scene_to_file("res://scenes/TitleScreen.tscn")
