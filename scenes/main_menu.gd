extends Node2D

func _ready():
	$PlayButton.grab_focus()

func _process(_delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$"../GameManager/ScoreLabel".visible = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()
