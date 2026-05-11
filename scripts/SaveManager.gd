extends Node

func save_game(data):
	
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	
	var json_text = JSON.stringify(data)
	
	file.store_string(json_text)

func load_game():
	if !FileAccess.file_exists("user://save.json"):
		return {}

	var file = FileAccess.open("user://save.json", FileAccess.READ)
	var json_text = file.get_as_text()

	var result = JSON.parse_string(json_text)

	if typeof(result) != TYPE_DICTIONARY:
		return {}

	return result
