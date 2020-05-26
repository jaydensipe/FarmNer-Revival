extends Node2D

var mousePos
var flashlightOn = false

func _ready():
	GLOBAL.connect("turnOffFlashlight", self, "_turn_Off_Flashlight")

func _physics_process(delta):
	mousePos = get_local_mouse_position()
	turnOnOffFlashlight()
	attackBeam()
	
# Turns flashlight on & off
func turnOnOffFlashlight():
	
	if Input.is_action_just_pressed("RightClick") && !flashlightOn && !Input.is_action_pressed("Attack"):
		flashlightOn = true
		$FlashLightSound/Off.play()
		$Sprite/Beam.enabled = 0
		
	elif Input.is_action_just_pressed("RightClick") && flashlightOn:
		flashlightOn = false
		$FlashLightSound/On.play()
		$Sprite/Beam.enabled = 1

# Focus' flashlight's beam and plays and stops sound
func attackBeam():
	rotation += mousePos.angle() * 0.5
	if (flashlightOn == false):
		
		if (Input.is_action_pressed("Attack")):
			if not $FlashLightBeamSound/AudioStreamPlayer2D.playing:
				$FlashLightBeamSound/AudioStreamPlayer2D.volume_db = -20.0
				$FlashLightBeamSound/AudioStreamPlayer2D.play()
			$Attack.monitorable = true
		
			# Interpolates flashlight beam
			$Tween.remove_all()
			$Tween.interpolate_property($Sprite/Beam, "scale", $Sprite/Beam.scale, Vector2(4.941, 3.0), 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
			$Tween.interpolate_property($Sprite/Beam, "energy", $Sprite/Beam.energy, 2.5, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
			$Tween.start()
			rotation += mousePos.angle() * 0.09
		else:
			if $FlashLightBeamSound/AudioStreamPlayer2D.playing == true:
				$Tween.interpolate_property($FlashLightBeamSound/AudioStreamPlayer2D, "volume_db", $FlashLightBeamSound/AudioStreamPlayer2D.volume_db, -80.0, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				$Tween.start()
			$Attack.monitorable = false
		
			# Reverse interpolates flashlight beam
			$Tween.stop($Sprite/Beam)
			$Tween.interpolate_property($Sprite/Beam, "scale", $Sprite/Beam.scale, Vector2(4.941, 9.0), 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
			$Tween.interpolate_property($Sprite/Beam, "energy", $Sprite/Beam.energy, 1.5, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)

func _on_Tween_tween_completed(object, key):
	$FlashLightBeamSound/AudioStreamPlayer2D.stop()
	
# Turns off flashlight from global
func _turn_Off_Flashlight():
	flashlightOn = true
	$Sprite/Beam.enabled = 0
