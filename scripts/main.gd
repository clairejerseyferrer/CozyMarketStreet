extends Control

var money = 0
var income_per_second = 0

@onready var money_label = get_node_or_null("TopBar/MoneyLabel")
@onready var income_label = get_node_or_null("TopBar/IncomeLabel")

@onready var stands = $ScrollContainer/GridContainer.get_children()

@onready var popup_scene = preload("res://scenes/popup_text.tscn")
@onready var settings_popup = $SettingsPopup

func spawn_popup(text, pos, color):
	var popup = popup_scene.instantiate()
	add_child(popup)

	popup.global_position = pos
	popup.start(text, color)

func _ready():
	load_game()
	await get_tree().process_frame
	update_total_income()
	update_ui()
	start_income_loop()

func start_income_loop():
	while true:
		await get_tree().create_timer(1.0).timeout
		for stand in $ScrollContainer/GridContainer.get_children():
			if stand.has_method("get_income"):
				var income = stand.get_income()
				if income > 0:
					money += income
					spawn_popup(
						"+" + format_money(income),
						stand.global_position + Vector2(100, 40),
						Color.GREEN
					)

		update_ui()
		for stand in $ScrollContainer/GridContainer.get_children():
			if stand.has_method("update_ui"):
				stand.update_ui()
		save_game()

func update_total_income():
	income_per_second = 0

	for stand in $ScrollContainer/GridContainer.get_children():
		if stand.has_method("get_income"):
			income_per_second += stand.get_income()

func format_money(value):
	if value >= 1000000000:
		return str(snapped(value / 1000000000.0, 0.1)) + "B"
	elif value >= 1000000:
		return str(snapped(value / 1000000.0, 0.1)) + "M"
	elif value >= 1000:
		return str(snapped(value / 1000.0, 0.1)) + "K"
	else:
		return str(int(value))

func update_ui():
	money_label.text = "Money: $" + format_money(money)
	income_label.text = "Income/sec: $" + format_money(income_per_second)

func _on_settings_button_pressed():
	settings_popup.visible = true

func save_game():
	var stand_data = {}
	for stand in stands:
		stand_data[stand.name] = stand.get_save_data()
	var data = {
		"money": money,
		"stands": stand_data
	}

	SaveManager.save_game(data)

func load_game():
	var data = SaveManager.load_game()
	if data == null or data == {}:
		return

	if "money" in data:
		money = data["money"]

	if "stands" in data:
		for stand in stands:
			if stand.name in data["stands"]:
				stand.load_data(data["stands"][stand.name])
