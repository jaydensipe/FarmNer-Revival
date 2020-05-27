extends Node2D

var playerEntered = false
var tntPutDown = false

# Detects if player enters dynamite sequence range
func _on_PlayerDetection_body_entered(body):
		playerEntered = true
		
# Detects if player leaves dynamite sequence range
func _on_PlayerDetection_body_exited(body):
		playerEntered = false
		
# Detects if mouse enters dynamite sequence range
func _on_Area2D_mouse_entered():
	if (tntPutDown == false):
		$Outline.show()

# Detects if mouse leaves dynamite sequence range
func _on_Area2D_mouse_exited():
	$Outline.hide()

# Detects if mouse is clicked, puts dynamite down
func _on_Area2D_input_event(viewport, event, shape_idx):
	if (playerEntered == true && GLOBAL.dynamiteAquired == true):
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				
				tntPutDown = true
				$FuseSound.play()
				$Outline.hide()
				$Sprite.show()
				$CPUParticles2D.emitting = true
				$Light2D.enabled = true


func _on_FuseSound_finished():
	$Explosion/Particles2D.emitting = true
	$Explosion/Particles2D/Particles2D.emitting = true
	$Explosion/Particles2D/Particles2D2.emitting = true
	$Sprite.hide()
	$Explosion2.play()
	$CPUParticles2D.emitting = false
	$Light2D.enabled = false
	GLOBAL.boomHappened = true
