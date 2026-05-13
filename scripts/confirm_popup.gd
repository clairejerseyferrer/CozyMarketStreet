extends Panel

@onready var warning_label = $VBoxContainer/WarningLabel

func _on_cancel_button_pressed():
	visible = false

func _on_yes_button_pressed():
	_delete_save()
	get_tree().change_scene_to_file("res://scenes/TitleScreen.tscn")

func _delete_save():
	var file_path = "user://save.json"

	if FileAccess.file_exists(file_path):
		var dir = DirAccess.open("user://")
		dir.remove("save.json")
