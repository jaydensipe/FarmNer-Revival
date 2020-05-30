extends Node2D

var playerEntered = false 
var chestOpen = false

# Detects if player enters chest range
func _on_PlayerDetection_body_entered(body):
		playerEntered = true
		
# Detects if player leaves chest range
func _on_PlayerDetection_body_exited(body):
		playerEntered = false
		
# Detects if mouse enters chest range
func _on_Area2D_mouse_entered():
	$Sprite.material.set_shader_param("turnOn", 1.0)

# Detects if mouse leaves chest range
func _on_Area2D_mouse_exited():
	$Sprite.material.set_shader_param("turnOn", 0.0)

# Detects if mouse is clicked, opens chest, and puts items in chest
func _on_Area2D_input_event(viewport, event, shape_idx):
	if (playerEntered == true && chestOpen == false):
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				# Plays chest open sound
				$ChestOpenSound/AudioStreamPlayer2D.play()
				


func _on_AudioStreamPlayer2D_finished():
	GLOBAL.endGame = true
