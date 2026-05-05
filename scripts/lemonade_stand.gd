extends Panel

var level = 1
var upgrade_cost = 10
var income_gain = 1

@onready var level_label = $LevelLabel
@onready var cost_label = $UpgradeCostLabel

func _ready():
	update_ui()

func update_ui():
	level_label.text = "Level: " + str(level)
	cost_label.text = "Upgrade Cost: $" + str(upgrade_cost)

func _on_upgrade_button_pressed():
	var main = get_parent()
	if main.money >= upgrade_cost:
		main.money -= upgrade_cost
		level += 1
		main.income_per_second += income_gain
		upgrade_cost = int(upgrade_cost * 1.5)
		update_ui()
		
		main.update_ui()
