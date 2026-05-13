extends Panel

func _ready():
	$MenuContainer/MusicToggle.button_pressed = AudioManager.music_enabled
	$MenuContainer/SfxToggle.button_pressed = AudioManager.sfx_enabled

func _on_music_toggle_toggled(button_pressed):
	AudioManager.toggle_music(button_pressed)

func _on_sfx_toggle_toggled(button_pressed):
	AudioManager.toggle_sfx(button_pressed)

func _on_close_button_pressed():
	visible = false

func _on_reset_button_pressed():
	$ConfirmPopup.visible = true

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/TitleScreen.tscn")
