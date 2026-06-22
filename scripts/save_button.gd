extends Button
@export var savefile: int
@onready var game_manager: GameManager = %GameManager
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
		
	if saved_data.has("score"):
		game_manager.score = saved_data["score"]
		
	for upgrade in game_manager.global:
		if saved_data.has(upgrade.parameter_name):
			for element in upgrade.saved_vals:
				upgrade.set(element, saved_data[upgrade.parameter_name][element])
		else:
			upgrade.current_value = upgrade.default_value
			upgrade.price = upgrade.default_price
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
	save_data.text += 'Score: ' + str(game_manager.score) + '\n'
	for upgrade:Upgrade in game_manager.global:
		if "Unlocked" in upgrade.parameter_name:
			if upgrade.current_value > upgrade.default_value:
				save_data.text += upgrade.parameter_name + "\n"
				var color = upgrade.parameter_name.trim_suffix(" Glumm Unlocked")
				for attribute_upgrade: Upgrade in game_manager.global:
					if attribute_upgrade.unlocked and color in attribute_upgrade.parameter_name and "Unlocked" not in upgrade.parameter_name:
						save_data.text +=  attribute_upgrade.parameter_name + ": " + str(attribute_upgrade.current_value) + "\n"
