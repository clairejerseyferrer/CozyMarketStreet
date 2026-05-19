extends Node

var cursor_normal = preload("res://art/cursors/cursor_normal.png")
var cursor_hover = preload("res://art/cursors/cursor_hover.png")
var cursor_click = preload("res://art/cursors/cursor_click.png")
var hovered_button = null

func _ready():
	set_normal_cursor()

func set_normal_cursor():
	Input.set_custom_mouse_cursor(
		cursor_normal,
		Input.CURSOR_ARROW,
		Vector2(0, 0)
	)

func set_hover_cursor():
	Input.set_custom_mouse_cursor(
		cursor_hover,
		Input.CURSOR_ARROW,
		Vector2(0, 0)
	)

func set_click_cursor():
	Input.set_custom_mouse_cursor(
		cursor_click,
		Input.CURSOR_ARROW,
		Vector2(0, 0)
	)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if hovered_button != null:
			hovered_button.emit_signal("pressed")
