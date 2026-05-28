extends Button

func _ready():
	mouse_entered.connect(_on_hover)
	mouse_exited.connect(_on_exit)
	button_down.connect(_on_down)
	button_up.connect(_on_up)

func _on_hover():
	CursorManager.hovered_button = self
	CursorManager.set_hover_cursor()

	AudioManager.play_sfx(AudioManager.hover_sound)

func _on_exit():
	if CursorManager.hovered_button == self:
		CursorManager.hovered_button = null
	
	CursorManager.set_normal_cursor()

func _on_down():
	CursorManager.set_click_cursor()
	AudioManager.play_sfx(AudioManager.click_sound)

func _on_up():
	CursorManager.set_hover_cursor()
