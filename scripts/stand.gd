extends Panel

@export var stand_name = "Stand"
@export var base_income = 1
@export var unlock_cost = 0
@export var unlocked = true
@export var max_level = 50
@export var base_upgrade_cost = 10
var growth_rate = 1.15
var level = 1

@onready var level_label = $LevelLabel
@onready var cost_label = $UpgradeCostLabel
@onready var upgrade_button = $UpgradeButton
@onready var unlock_button = $UnlockButton

func get_upgrade_cost():
	return int(base_upgrade_cost * pow(growth_rate, level - 1))
	
func _ready():
	update_visibility()
	update_ui()

func get_income():
	if !unlocked:
		return 0
	return level * base_income

func update_visibility():    
	level_label.visible = unlocked   
	cost_label.visible = unlocked
	upgrade_button.visible = unlocked
	unlock_button.visible = !unlocked

func update_ui():
	level_label.text = "Level: " + str(int(level))
	var main = get_tree().current_scene
	var cost = get_upgrade_cost()
	cost_label.text = "Upgrade Cost: $" + main.format_money(cost)

	if level >= max_level:
		upgrade_button.text = "MAX LEVEL"
		upgrade_button.disabled = true
	else:
		upgrade_button.text = "Upgrade"
		upgrade_button.disabled = main.money < cost

	unlock_button.text = "Unlock For $" + main.format_money(unlock_cost)
	unlock_button.disabled = main.money < unlock_cost
	
func _on_upgrade_button_pressed():
	var main = get_tree().current_scene
	if main == null:
		return
	
	if !unlocked:
		return
	
	if level >= max_level:
		return
	
	var cost = get_upgrade_cost()
	
	if main.money >= cost:
		main.money -= cost
		main.spawn_popup(
			"-" + main.format_money(cost), 
			global_position  + Vector2(100, 100), 
			Color.RED)
		level += 1
		main.update_total_income()
		main.save_game()
		
		update_ui()
		main.update_ui()
		
func _on_unlock_button_pressed():
	var main = get_tree().current_scene
	if main == null:
		return
	
	if main.money >= unlock_cost:
		main.money -= unlock_cost
		main.spawn_popup(
			"-" + main.format_money(unlock_cost),
			unlock_button.global_position + Vector2(40, 0),
			Color.RED
		)
		unlocked = true
		update_visibility()
		main.update_total_income()
		main.save_game()
		
		update_ui()
		main.update_ui()

func get_save_data():
	return {
		"level": level,
		"unlocked": unlocked
	}

func load_data(data):
	level = data["level"]
	unlocked = data["unlocked"]
	update_visibility()
	update_ui()
