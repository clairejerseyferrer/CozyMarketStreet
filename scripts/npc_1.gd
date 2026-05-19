extends Node2D

@export var speed := 40.0

var direction := Vector2.ZERO

func _ready():
	randomize()

	# Randomly choose left or right
	if randi() % 2 == 0:
		direction = Vector2.RIGHT
		$AnimatedSprite2D.flip_h = true
	else:
		direction = Vector2.LEFT
		$AnimatedSprite2D.flip_h = false

func _process(delta):
	position += direction * speed * delta
