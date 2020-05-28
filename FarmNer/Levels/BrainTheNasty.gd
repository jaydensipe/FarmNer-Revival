extends Node2D

var rng = RandomNumberGenerator.new()
var colorRand1
var colorRand2
var colorRand3
var playerEntered = false
var orbIsDead = false

# Sets lights and particles to random colors
func _ready():
	randomizeColor()
	if (orbIsDead == false):
		$TheNastySound/AudioStreamPlayer2D.play()
	
func randomizeColor():
	rng.randomize()
	colorRand1 = rng.randf_range(0, 1.0)
	colorRand2 = rng.randf_range(0, 1.0)
	colorRand3 = rng.randf_range(0, 1.0)
	
	$Light2D.color = Color(colorRand1, colorRand2, colorRand3, 1)
	$CPUParticles2D.color = Color(colorRand1, colorRand2, colorRand3, 1)

# Detects if mouse enters orb range
func _on_Area2D_mouse_entered():
	if (GLOBAL.orbDestroyerUnlocked == true && orbIsDead == false):
		$Sprite.material.set_shader_param("turnOn", 1.0)

# Detects if mouse leaves orb range
func _on_Area2D_mouse_exited():
	if (GLOBAL.orbDestroyerUnlocked == true && orbIsDead == false):
		$Sprite.material.set_shader_param("turnOn", 0.0)

# Detects if mouse is clicked
func _on_Area2D_input_event(viewport, event, shape_idx):
	if (playerEntered == true && GLOBAL.orbDestroyerUnlocked == true && orbIsDead == false):
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				
				# Effects when orb is destroyed
				$CPUParticles2D.one_shot = true
				$CPUParticles2D.initial_velocity = 750
				$CPUParticles2D.speed_scale = 1.0
				$Sprite.material.set_shader_param("turnOn", 0.0)
				$Light2D.hide()
				$TheNastySound/Explosion.play()
				$TheNastySound/zombieSound.play()
				$TheNastySound/AudioStreamPlayer2D.stop()
				orbIsDead = true
				$Sprite.material.set_shader_param("isOrbDead", orbIsDead)
				$Sprite.material.set_shader_param("value", 1.0)
				$Tween.remove_all()
				$Tween.interpolate_property($Sprite.get_material(), "shader_param/value", 1, 0, 2.4, Tween.TRANS_LINEAR, Tween.EASE_IN)
				$Tween.start()	


# Detects if player enters orb range
func _on_PlayerCollisionNasty_body_entered(body):
	playerEntered = true

# Detects if player leaves orb range
func _on_PlayerCollisionNasty_body_exited(body):
	playerEntered = false
	
# Removes orb after tween
func _on_Tween_tween_completed(object, key):
	GLOBAL.brainOrbIsDead = true
	$StaticBody2D/CollisionShape2D.disabled = true
	$TheNastySound/AudioStreamPlayer2D.stop()
