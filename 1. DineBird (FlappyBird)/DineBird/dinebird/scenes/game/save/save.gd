extends Node
class_name SaveSystem

const SAVE_PATH = "user://dineBird.save" 

func save_game():
	var saves = {
		"score": Score.get_highscore()
	}
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var json = JSON.stringify(saves)
	save_file.store_line(json)


func load_save() -> Dictionary:
	if !FileAccess.file_exists(SAVE_PATH):
		return {}
	
	var data = FileAccess.open(SAVE_PATH, FileAccess.READ).get_line()
	var json_data = JSON.parse_string(data)

	return json_data
