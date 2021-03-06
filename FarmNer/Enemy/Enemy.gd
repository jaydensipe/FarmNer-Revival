extends KinematicBody2D
 
# Movement speeds, directions, health, and shader variable
const cSPEED = 60
var speed = cSPEED
var health = 500

# Signal to hurt the player
signal hurtPlayer

var directions = ["Right", "RightDown", "Down", "LeftDown", "Left", "LeftUp", "Up", "RightUp"]
var vec_to_player = Vector2()
var facing = Vector2()

# Sets player
var player = null
func setPlayer(play):
	player = play
 
func _ready():
	add_to_group("Enemy")
 
func _physics_process(delta):
	
	# Checks if the enemy should be taking damage
	checkToTakeDamage()

	# Controls animations
	vec_to_player = Vector2(0, 0)
	if player == null:
		return
	
	vec_to_player = player.global_position - global_position
	move_and_collide(vec_to_player.normalized() * speed * delta)
	facing = vec_to_player
	
	var animation = direction2str(facing)
	$Sprite.play(animation)
	
	# Plays footsteps
	if not $FootstepSound/enemyRun.playing:
		$FootstepSound/enemyRun.play()
		
	# Hurts player if raycast collides
	if $RayCast2D.is_colliding():
		GLOBAL.emit_signal("hurtPlayer")

# Checks to see if enemy should take damage and also slows, and kills them if their health goes below 0 
func checkToTakeDamage():
	if ($LightAttackDetection.get_overlapping_areas().empty() == true):
		$EnemyScream/AudioStreamPlayer2D.stop()
		$Sprite.speed_scale = 2
		speed = cSPEED
		$DeathParticles.visible = false
	elif ($LightAttackDetection.get_overlapping_areas().empty() == false):
		
		$Sprite.speed_scale = 0.5
		speed = 15
		
		# Damages the enemy
		health -= 3
		
		# Changes sprite color based on health, and eventually makes sprite invisible
		$Sprite.modulate = Color(0.18, 0.11, 0.03) * Color (health/100, health/100, health/100)
		$DeathParticles.visible = true
		
		# Plays run audio
		if not $EnemyScream/AudioStreamPlayer2D.playing:
			$EnemyScream/AudioStreamPlayer2D.play()
		
		# Kills enemy if health goes below 0 
		if (health < 0):
			queue_free()
# Converts direction to string and controls raycast direction
func direction2str(direction):
	var angle = direction.angle()
	if angle < 0:
		angle += 2 * PI
	var index = round(angle / PI * 4)
	if (index == 0):
		$RayCast2D.rotation_degrees = -90
	elif (index == 1):
		$RayCast2D.rotation_degrees = -45
	elif (index == 2):
		$RayCast2D.rotation_degrees = 0
	elif (index == 3):
		$RayCast2D.rotation_degrees = 45
	elif (index == 4):
		$RayCast2D.rotation_degrees = 90
	elif (index == 5):
		$RayCast2D.rotation_degrees = 135
	elif (index == 6):
		$RayCast2D.rotation_degrees = 180
	elif (index == 7):
		$RayCast2D.rotation_degrees = -135
		
		
	if index == 8: 
		return directions[0]
	else:
		return directions[index]
