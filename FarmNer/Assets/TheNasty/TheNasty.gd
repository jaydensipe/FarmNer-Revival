extends Node2D

var rng = RandomNumberGenerator.new()
var colorRand1
var colorRand2
var colorRand3
var playerEntered = false
var orbIsDead = false

# Instantiates enemy
var enemyLoad = load("res://FarmNer/Enemy/Enemy.tscn")

# Spawn locations for each map 
var level2SpawnPositionArray = [Vector2(52, 404), Vector2(88, 404), Vector2(128 , 404), Vector2(72, 443), Vector2(32, 480), Vector2(344, 320), Vector2(392, 320), 
Vector2(440, 344), Vector2(328, 372), Vector2(444 , 384)]

# Sets lights and particles to random colors
func _ready():
	randomizeColor()
	
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
				
				# Turns off flashlight
				GLOBAL.emit_signal("turnOffFlashlight")
				
				rng.randomize()
				var randomAmountOfEnemies = rng.randi_range(2, 5)
				spawnEnemies(randomAmountOfEnemies)


# Detects if player enters orb range
func _on_PlayerCollisionNasty_body_entered(body):
	playerEntered = true

# Detects if player leaves orb range
func _on_PlayerCollisionNasty_body_exited(body):
	playerEntered = false
	
# Spawns enemies based on random values, and uses an array for make sure random function doesnt use the same number so enemies don't spawn in eachother
func spawnEnemies(howMany):
	var arrayForPrevention = []
	arrayForPrevention.clear()
	
	for i in range(howMany):
		var randomArrayForEnemySpawn = rng.randi_range(0, 9)
		while(arrayForPrevention.has(randomArrayForEnemySpawn)):
			randomArrayForEnemySpawn = rng.randi_range(0, 9)
		var enemyInstance = enemyLoad.instance()
		add_child(enemyInstance)
		arrayForPrevention.insert(i, randomArrayForEnemySpawn)
		enemyInstance.global_position = level2SpawnPositionArray[arrayForPrevention[i]]

# Removes orb after tween
func _on_Tween_tween_completed(object, key):
	$StaticBody2D/CollisionShape2D.disabled = true
