extends Node

var gameOver = false

var save_path = "user://savegame.json"

func save_score(new_score):
	var data = {
		"score" : new_score,
	}
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var json = JSON.new()
	var json_string = json.stringify(data)
	file.store_line(json_string)
	file.close()
	
func load_score():
	var file = FileAccess.open(save_path, FileAccess.READ)
	if FileAccess.file_exists(save_path):
		file = FileAccess.open(save_path,FileAccess.READ)
		var json = JSON.new()
		var data = JSON.parse_string(file.get_as_text())
		return data.score
	else:
		return 0
	

