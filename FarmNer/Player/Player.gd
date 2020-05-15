extends KinematicBody2D

export (int) var speed = 75
var sprintSpeed = 1

var directions = ["Right", "RightDown", "Down", "LeftDown", "Left", "LeftUp", "Up", "RightUp"]
var velocity = Vector2()
var facing = Vector2()

func _physics_process(delta):
	get_input()
	torchDetection()
	attack()
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

	
