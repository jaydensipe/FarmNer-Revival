extends Node2D

var playerEntered = false 
var chestOpen = false

# Instance Orb Defiler
var orbInstance = preload("res://FarmNer/Assets/OrbDefiler/OrbDefiler.tscn")
var orbDefilerInstance = orbInstance.instance()

# RandomNumberGenerator for placing items
var random = RandomNumberGenerator.new()

# Detects if player enters chest range
func _on_PlayerDetection_body_entered(body):
		playerEntered = true
		
# Detects if player leaves chest range
func _on_PlayerDetection_body_exited(body):
		playerEntered = false
		
# Detects if mouse enters chest range
func _on_Area2D_mouse_entered():
	$Sprite.material.set_shader_param("turnOn", 1.0)
	if (chestOpen == true):
		$Sprite.material.set_shader_param("turnOn", 0.0)

# Detects if mouse leaves chest range
func _on_Area2D_mouse_exited():
	$Sprite.material.set_shader_param("turnOn", 0.0)

# Detects if mouse is clicked, opens chest, and puts orbDefiler in chest
func _on_Area2D_input_event(viewport, event, shape_idx):
	if (playerEntered == true && chestOpen == false):
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				
				# Opens chest
				chestOpen = true
				$Sprite.hide()
				$ChestOpenFront.show()
				$ChestOpenBack.show()
				
				# Plays chest open sound
				$ChestOpenSound/AudioStreamPlayer2D.play()
				
				# Plays squishy sound
				$PickupSound/OrbDefilerPickup.play()
				
				# Adds item in random positions of box
				random.randomize()
				var randomNumber = random.randf_range(-2.433, 2.84)
				add_child(orbDefilerInstance)
				orbDefilerInstance.position = Vector2(randomNumber, -1.732)
