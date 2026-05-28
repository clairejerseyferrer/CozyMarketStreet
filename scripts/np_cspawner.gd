extends Node2D

@export var npc_scene : PackedScene
@export var spawn_interval := 2.0
@export var spawn_distance := 80
@export var max_npcs := 8
@export var lane_positions = [
	340,
	590
]

var screen_size

func _ready():
	screen_size = get_viewport_rect().size

	spawn_loop()

func spawn_loop():
	while true:
		spawn_npc()

		await get_tree().create_timer(spawn_interval).timeout

func get_npc_count():
	var count = 0

	for child in get_children():
		if child.is_in_group("npc"):
			count += 1

	return count
	
func spawn_npc():
	if get_npc_count() >= max_npcs:
		return
	var npc = npc_scene.instantiate()

	# Random left or right spawn
	var spawn_left = randf() < 0.5

	var base_y = lane_positions.pick_random()
	var y_pos = base_y + randf_range(-10, 10)

	if spawn_left:
		npc.position = Vector2(-spawn_distance, y_pos)
	else:
		npc.position = Vector2(screen_size.x + spawn_distance, y_pos)

	# Force direction
	npc.direction = 1 if spawn_left else -1

	add_child(npc)
