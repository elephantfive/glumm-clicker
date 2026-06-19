extends Node
var savefile: int
var save_selected = false

#These values need to be loaded/saved
var global = {
	"Score" = 0,
	"Cursor Size" = 1,
	"White Projectile Pierce" = 0,
	"White Glumm Unlocked" = 0,
	"Brown Glumm Unlocked" = 0,
	"Pink Glumm Unlocked" = 0,
	"Dark Blue Glumm Unlocked" = 0,
	"Yellow Glumm Unlocked" = 0,
	"Orange Glumm Unlocked" = 0,
	"Orange Projectile Bounce" = 1,
	"Yellow Projectiles" = 1,
}
@onready var main_menu = %MainMenu
@onready var save_select = %SaveSelect
@onready var play = %Play
@onready var shop = %Shop
@onready var pause_menu = %PauseMenu
@onready var score_label = $ScoreLabel

func _process(_delta):
	score_label.text = "Current Points: " + str(global["Score"])
	
	#All scene changing takes place in the Game Manager
	if main_menu.process_mode == PROCESS_MODE_INHERIT:
		pass
	elif save_select.process_mode == PROCESS_MODE_INHERIT:
		if Input.is_action_just_pressed("esc"):
			pause(save_select)
			unpause(main_menu)
			$"../MainMenu/PlayButton".grab_focus()
		elif save_selected:
			pause(save_select)
			unpause(play)
			score_label.visible = true
			save_selected = false
	elif play.process_mode == PROCESS_MODE_INHERIT:
		if Input.is_action_just_pressed("shop"):
			pause(play)
			unpause(shop)
		elif Input.is_action_just_pressed("esc"):
			pause(play)
			unpause(pause_menu)
			$"../PauseMenu/ResumeButton".grab_focus()
	elif shop.process_mode == PROCESS_MODE_INHERIT:
		if Input.is_action_just_pressed("shop") or Input.is_action_just_pressed("esc"):
			pause(shop)
			unpause(play)
	elif pause_menu.process_mode == PROCESS_MODE_INHERIT:
		if Input.is_action_just_pressed("esc"):
			pause(pause_menu)
			unpause(play)
	
func pause(scene):
	scene.visible = false
	scene.process_mode = PROCESS_MODE_DISABLED

func unpause(scene):
	scene.process_mode = PROCESS_MODE_INHERIT
	scene.visible = true

func save_game():
	var file = FileAccess.open("user://savegame" + str(savefile) + ".json", FileAccess.WRITE)
	var saved_data ={}
	for key in global:
		saved_data[key] = global[key]
	var json = JSON.stringify(saved_data)
	file.store_string(json)
	file.close()

func _on_play_button_pressed():
	pause(main_menu)
	unpause(save_select)

func _on_resume_button_pressed():
	pause(pause_menu)
	unpause(play)

func _on_game_quit_pressed() -> void:
	save_game()
	get_tree().quit()

func _on_menu_quit_pressed() -> void:
	save_game()
	savefile = 0
	get_tree().reload_current_scene()
