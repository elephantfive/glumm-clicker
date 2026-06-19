extends Button

func _process(_delta):
	if has_focus():
		modulate = Color(0, 1, 0.75, 1)
	else:
		modulate = Color(0.74, 1, 0.74)

func _on_mouse_entered():
	grab_focus() # Replace with function body.


func _on_focus_exited():
	%MenuSelect.play()
