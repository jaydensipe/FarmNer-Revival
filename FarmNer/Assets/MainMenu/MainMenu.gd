extends Node2D

var flashlightOn = false
var gameStarted = false

func _ready():
	$BlackFade/AnimationPlayer.play("FadeIn")

func _process(delta):
	$Light2D.position = get_local_mouse_position()
	
		# Turns flashlight on & off
	if Input.is_action_just_pressed("RightClick") && !flashlightOn:
		flashlightOn = true
		$FlashLightSound/Off.play()
		$Light2D.enabled = 0
		
	elif Input.is_action_just_pressed("RightClick") && flashlightOn:
		flashlightOn = false
		$FlashLightSound/On.play()
		$Light2D.enabled = 1

# Exits game
func _on_Exit_pressed():
	get_tree().quit()
	
# Switches to game scene and tweens audio
func _on_Play_pressed():
	if gameStarted == false:
		gameStarted = true
		if not 	$HeartbeatSound/AudioStreamPlayer.playing:
			$HeartbeatSound/AudioStreamPlayer.play()
			$Tween.interpolate_property($HeartbeatSound/AudioStreamPlayer, "pitch_scale", $HeartbeatSound/AudioStreamPlayer.pitch_scale, 0.6, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($HeartbeatSound/AudioStreamPlayer, "volume_db", $HeartbeatSound/AudioStreamPlayer.volume_db, -25.0, 6.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.interpolate_property($MainMenuAmbiance/AudioStreamPlayer, "volume_db", $MainMenuAmbiance/AudioStreamPlayer.volume_db, -50.0, 5.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		$BlackFade/Timer.start()
		$BlackFade/AnimationPlayer.play("FadeOut")
	

func _on_Timer_timeout():
	queue_free()
	get_tree().change_scene("res://FarmNer/GameManager/Game.tscn")
	
# Turns on/off fullscreen
func _on_Fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
