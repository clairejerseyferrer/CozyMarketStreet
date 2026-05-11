extends Label

var speed = 60

func start(new_text, color):
	text = new_text
	modulate = color

	await get_tree().create_timer(0.8).timeout
	queue_free()

func _process(delta):
	position.y -= speed * delta
	modulate.a -= delta * 1.5
