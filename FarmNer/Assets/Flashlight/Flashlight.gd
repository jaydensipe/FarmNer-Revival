extends Node2D

var mousePos
var flashlightOn = false

func _physics_process(delta):
	
	if Input.is_action_just_pressed("RightClick") && !flashlightOn:
		flashlightOn = true
		$FlashLightSound/Off.play()
		$Sprite/Beam.enabled = 0
		
	elif Input.is_action_just_pressed("RightClick") && flashlightOn:
		flashlightOn = false
		$FlashLightSound/On.play()
		$Sprite/Beam.enabled = 1
	
	mousePos = get_local_mouse_position()
	rotation += mousePos.angle() * 0.5
