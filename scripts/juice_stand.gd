extends Panel

var level = 1
var upgrade_cost = 100
var income_gain = 5

var unlocked = false
var unlock_cost = 100

@onready var level_label = $LevelLabel
@onready var cost_label = $UpgradeCostLabel
@onready var upgrade_button = $UpgradeButton
@onready var unlock_button = $UnlockButton

func _ready():
	update_visibility()
	update_ui()

func update_visibility():
	level_label.visible = unlocked
	cost_label.visible = unlocked
	upgrade_button.visible = unlocked
	unlock_button.visible = !unlocked

func update_ui():
	level_label.text = "Level: " + str(level)
	cost_label.text = "Upgrade Cost: $" + str(upgrade_cost)
	unlock_button.text = "Unlock For $" + str(unlock_cost)

func _on_unlock_button_pressed():
	var main = get_parent()
	if main.money >= unlock_cost:
		main.money -= unlock_cost
		unlocked = true
		main.income_per_second += income_gain
		update_visibility()
		
		main.update_ui()

func _on_upgrade_button_pressed():
	if !unlocked:
		return
		
	var main = get_parent()
	if main.money >= upgrade_cost:
		main.money -= upgrade_cost
		level += 1
		main.income_per_second += income_gain
		upgrade_cost = int(upgrade_cost * 1.5)
		update_ui()
		
		main.update_ui()
