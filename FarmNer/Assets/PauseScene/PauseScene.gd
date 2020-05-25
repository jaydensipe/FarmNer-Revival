extends Node2D

# Detects if the game is paused
var notPaused = true

func _process(delta):
	
	# Pauses the game
	if Input.is_action_just_pressed("Pause"):
		if notPaused:
			get_tree().paused = true
			notPaused = false
			visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			get_tree().paused = false
			notPaused = true
			visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
