extends Node2D

var mousePos
var flashlightOn = true

func _process(delta):
	mousePos = get_local_mouse_position()
	turnOnOffFlashlight()
	attackBeam()
	
# Turns flashlight on & off
func turnOnOffFlashlight():
	
	if Input.is_action_just_pressed("RightClick") && !flashlightOn:
		flashlightOn = true
		$FlashLightSound/Off.play()
		$Sprite/Beam.enabled = 0
		
	elif Input.is_action_just_pressed("RightClick") && flashlightOn:
		flashlightOn = false
		$FlashLightSound/On.play()
		$Sprite/Beam.enabled = 1

# Focus' flashlight's beam
func attackBeam():
	if (Input.is_action_pressed("Attack")):
		$Tween.remove_all()
		$Tween.interpolate_property($Sprite/Beam, "scale", $Sprite/Beam.scale, Vector2(4.941, 3.0), 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
		$Tween.interpolate_property($Sprite/Beam, "energy", $Sprite/Beam.energy, 2.5, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
		$Tween.start()
		rotation += mousePos.angle() * 0.09
	else:
		$Tween.stop($Sprite/Beam)
		$Tween.interpolate_property($Sprite/Beam, "scale", $Sprite/Beam.scale, Vector2(4.941, 7.682), 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
		$Tween.interpolate_property($Sprite/Beam, "energy", $Sprite/Beam.energy, 1.5, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
		rotation += mousePos.angle() * 0.5
