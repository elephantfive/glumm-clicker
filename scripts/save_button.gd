extends Button
@export var savefile: int
@onready var game_manager = %GameManager
@onready var save_select = %SaveSelect
@onready var play = %Play
@onready var save_data: Label = $"../SaveData"

func _ready():
	position.x = 50
	position.y = savefile * 100
	text = "select save " + str(savefile)

func _on_pressed():
	game_manager.save_selected = true
	load_game()
	game_manager.savefile = savefile

#Taken from Godotneers
func load_game():
	var file = FileAccess.open("user://savegame" + str(savefile) + ".json", FileAccess.READ)
	var saved_data = {}
	if file:
		var json = file.get_as_text()
		saved_data = JSON.parse_string(json)
	for key in game_manager.global:
		game_manager.global[key] = int(saved_data[key]) if saved_data.has(key) else 0
		if "Unlocked" not in key and game_manager.global[key] < 1 and key != "Score":
			game_manager.global[key] = 1
		
	if file:
		file.close()

func _on_mouse_entered():
	grab_focus()

func _on_focus_exited():
	save_data.text = ""
	modulate = Color(0.74, 1, 0.74)
	%MenuSelect.play()

func _on_focus_entered() -> void:
	load_game()
	modulate = Color(0, 1, 0.75, 1)
	game_manager.savefile = savefile
	for key in game_manager.global:
		var color: String
		if 'Score' in key:
			save_data.text += key + ': ' + str(game_manager.global[key]) + '\n'
		elif 'Unlocked' in key:
			color = key.trim_suffix(" Glumm Unlocked")
			if game_manager.global[key] == 1:
				save_data.text += key + "\n"
				for subkey in game_manager.global:
					if "Unlocked" not in subkey and color in subkey:
						save_data.text += subkey + ": " + str(game_manager.global[subkey]) + "\n"
			
