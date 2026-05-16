extends Control

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_settings_button_pressed():
	$SettingsPopup.visible = true

func _on_quit_button_pressed():
	get_tree().quit()

func _on_credits_button_pressed():
	$CreditsPopup.visible = true
	
func _on_close_button_pressed():
	$CreditsPopup.visible = false
