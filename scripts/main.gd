extends Control

var money = 0
var income_per_second = 1

@onready var money_label = $MoneyLabel
@onready var income_label = $IncomeLabel

func _ready():
	update_ui()
	start_income_loop()

func start_income_loop():
	while true:
		await get_tree().create_timer(1.0).timeout
		money += income_per_second
		
		update_ui()

func update_ui():
	money_label.text = "Money: $" + str(money)
	income_label.text = "Income/sec: $" + str(income_per_second)
