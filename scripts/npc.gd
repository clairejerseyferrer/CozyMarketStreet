extends CharacterBody2D

@export var move_speed := 60.0
@export var stop_chance := 0.3
@export var stop_duration_min := 2.0
@export var stop_duration_max := 5.0

var speed = 100
var direction := 1
var is_waiting := false
var road_y

@onready var timer = $Timer
@onready var notifier = $VisibleOnScreenNotifier2D
@onready var sprite = $AnimatedSprite2D

var npc_type = ""
var current_state = ""


func _ready():
	add_to_group("npc")
	var npc_types = [
	"blue",
	"red",
	"purple",
	"pink",
	"green",
	"yellow",
	"mj",
	"juice",
	"lemon",
	"cafe",
	"snackdo"
	]

	npc_type = npc_types.pick_random()
	
	randomize()
	
	road_y = global_position.y
	
	if direction == -1:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
	# Random wait behavior
	start_random_stop()

	# Delete when off screen
	notifier.screen_exited.connect(queue_free)

func _physics_process(delta):
	if is_waiting:
		velocity.x = 0
		play_animation("idle")
	else:
		velocity.x = move_speed * direction
		play_animation("walk")

	move_and_slide()

func start_random_stop():
	while true:
		await get_tree().create_timer(randf_range(3, 7)).timeout

		if randf() < stop_chance:
			is_waiting = true

			var wait_time = randf_range(
				stop_duration_min,
				stop_duration_max
			)

			await get_tree().create_timer(wait_time).timeout

			is_waiting = false

func play_animation(state):
	if current_state == state:
		return

	current_state = state
	sprite.play(npc_type + "_" + state)
