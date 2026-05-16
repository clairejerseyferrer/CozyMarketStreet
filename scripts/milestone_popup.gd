extends Panel

@onready var title_label = $VBoxContainer/TitleLabel
@onready var message_text = $VBoxContainer/MessageText


func show_milestone(title, message):
	title_label.text = title
	message_text.text = message

	visible = true


func _on_close_button_pressed():
	visible = false
