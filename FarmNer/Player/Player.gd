extends KinematicBody2D


# Movement speeds and directions
export (int) var speed = 75
var sprintSpeed = 1

var directions = ["Right", "RightDown", "Down", "LeftDown", "Left", "LeftUp", "Up", "RightUp"]
var velocity = Vector2()
var facing = Vector2()

# Controls if the player can take damage or not 
var canTakeDamage = true

# Player health
var playerHealth = 120

# Makes enemies target player
func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("Enemy", "setPlayer", self)
	GLOBAL.connect("hurtPlayer", self, "_player_Take_Damage")

func _physics_process(delta):
	get_input()
	torchDetection()
	attack()
	bandageHeal()
	healthBar()
	velocity = move_and_slide(velocity, Vector2(0, 0))

func get_input():
	velocity = Vector2(0, 0)
	
	# Movement & Animation
	var left = Input.is_action_pressed("Left")
	var right = Input.is_action_pressed("Right")
	var up = Input.is_action_pressed("Up")
	var down = Input.is_action_pressed("Down")
	
	velocity.x = -int(left) + int(right)
	velocity.y = (-int(up) + int(down)) / float(2)
	facing = velocity
	var animation = direction2str(facing)
	
	if left || right || up || down:
		$Sprite.play(animation)
		
		if not $FootstepSound/AudioStreamPlayer2D.playing:
			$FootstepSound/AudioStreamPlayer2D.play()
		
	elif !left || !right || !up || !down:
		$Sprite.play("IdleUp")
		$FootstepSound/AudioStreamPlayer2D.stop()
	
	# Sprinting
	if (Input.is_action_pressed('Shift')):
		sprintSpeed = 1.15
		$Sprite.speed_scale = 3
	elif (Input.is_action_just_released('Shift')):
		sprintSpeed = 1.0
		$Sprite.speed_scale = 2
	
	velocity = velocity.normalized() * speed * sprintSpeed
	
# Converts direction to string
func direction2str(direction):
	var angle = direction.angle()
	if angle < 0:
		angle += 2 * PI
	var index = round(angle / PI * 4)
	return directions[index]
	
# Camera and speed tween for attack move
func attack():
	if ($Flashlight.flashlightOn == false):
		if (Input.is_action_pressed("Attack")):
			$Camera2D/CameraShake.shake = $Camera2D/CameraShake.shake_magnitude*0.5
			$Tween.remove_all()
			$Tween.interpolate_property($Camera2D, "zoom", $Camera2D.zoom, Vector2(0.12, 0.12), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
			speed = 25
			$Sprite.speed_scale = 0.8
			$Tween.start()
			$FootstepSound/AudioStreamPlayer2D.pitch_scale = 0.6
		else:
			$Tween.stop($Camera2D)
			$Tween.interpolate_property($Camera2D, "zoom", $Camera2D.zoom, Vector2(0.14, 0.14), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
			speed = 75
			$FootstepSound/AudioStreamPlayer2D.pitch_scale = 0.85
			$Sprite.speed_scale = 2
		
# Detects if player is standing in torch light range
func torchDetection():
	if ($TorchCollision.get_overlapping_areas().empty() == true):
		$Light2D.enabled = true
	elif ($TorchCollision.get_overlapping_areas().empty() == false):
		$Light2D.enabled = false
		
# Controls what happens when the player takes damage
func _player_Take_Damage():
	if(canTakeDamage == true):
		$BloodScreen/Sprite.visible = true
		$BloodScreen/Tween.remove_all()
		$BloodScreen/Tween.interpolate_property($BloodScreen/Sprite, "modulate", Color(1.0, 1.0, 1.0, 1.0), Color(1.0, 1.0, 1.0, 0.0), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$BloodScreen/Tween.start()
		$Camera2D/CameraShake.shake = $Camera2D/CameraShake.shake_magnitude*5
		playerHealth -= 30
		if (playerHealth <= 0):
			get_tree().reload_current_scene()
		$AttackDelayTimer.start()
		canTakeDamage = false

func _on_AttackDelayTimer_timeout():
	if (playerHealth <= 30):
		$BloodScreen/Tween.interpolate_property($BloodScreen/Sprite, "modulate", Color(1.0, 1.0, 1.0, 1.0), Color(1.0, 1.0, 1.0, 0.0), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$BloodScreen/Tween.start()
	else:
		$BloodScreen/Sprite.visible = false
	canTakeDamage = true

# Changes health bar when player is hit
func healthBar():
	match playerHealth:
		30:
			$HealthBar/heart1.visible = true
			$HealthBar/heart2.visible = false
			$HealthBar/heart3.visible = false
			$HealthBar/heart4.visible = false
		60:
			$HealthBar/heart1.visible = true
			$HealthBar/heart2.visible = true
			$HealthBar/heart3.visible = false
			$HealthBar/heart4.visible = false
		90:
			$HealthBar/heart1.visible = true
			$HealthBar/heart2.visible = true
			$HealthBar/heart3.visible = true
			$HealthBar/heart4.visible = false
		120:
			$HealthBar/heart1.visible = true
			$HealthBar/heart2.visible = true
			$HealthBar/heart3.visible = true
			$HealthBar/heart4.visible = true

# Heals the player to a max health of 120
func bandageHeal():
	if(Input.is_action_just_pressed("Heal")):
		playerHealth += 60
		
	if (playerHealth > 120):
		playerHealth = 120
