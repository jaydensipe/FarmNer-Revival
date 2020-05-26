extends Node2D

var playerEntered = false

# Detects if player enters dynamite range
func _on_PlayerCollision_body_entered(body):
	playerEntered = true

# Detects if player leaves dynamite range
func _on_PlayerCollision_body_exited(body):
	playerEntered = false

# Detects if mouse enters dynamite range
func _on_Area2D_mouse_entered():
	$Sprite.material.set_shader_param("turnOn", 1.0)

# Detects if mouse leaves dynamite range
func _on_Area2D_mouse_exited():
	$Sprite.material.set_shader_param("turnOn", 0.0)

# Detects if mouse is clicked, then unlocks dynamite
func _on_Area2D_input_event(viewport, event, shape_idx):
	if (playerEntered == true):
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				GLOBAL.dynamiteAquired = true
				queue_free()
