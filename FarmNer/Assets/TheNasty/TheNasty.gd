extends Node2D

var rng = RandomNumberGenerator.new()
var colorRand1
var colorRand2
var colorRand3
var playerEntered = false

func _ready():
	randomizeColor()
	

# Sets lights and particles to random colors
func randomizeColor():
	rng.randomize()
	colorRand1 = rng.randf_range(0, 1.0)
	colorRand2 = rng.randf_range(0, 1.0)
	colorRand3 = rng.randf_range(0, 1.0)
	
	$Light2D.color = Color(colorRand1, colorRand2, colorRand3, 1)
	$CPUParticles2D.color = Color(colorRand1, colorRand2, colorRand3, 1)

# Detects if mouse enters orb range
func _on_Area2D_mouse_entered():
	if (GLOBAL.orbDestroyerUnlocked == true):
		$Sprite.material.set_shader_param("turnOn", 1.0)

# Detects if mouse leaves orb range
func _on_Area2D_mouse_exited():
	if (GLOBAL.orbDestroyerUnlocked == true):
		$Sprite.material.set_shader_param("turnOn", 0.0)

# Detects if mouse is clicked
func _on_Area2D_input_event(viewport, event, shape_idx):
	if (playerEntered == true && GLOBAL.orbDestroyerUnlocked == true):
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				print("orb clicked")

# Detects if player enters orb range
func _on_PlayerCollisionNasty_body_entered(body):
		playerEntered = true

# Detects if player leaves orb range
func _on_PlayerCollisionNasty_body_exited(body):
	playerEntered = false
