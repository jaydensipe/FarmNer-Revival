extends Node2D

var canShowText = true

# Plays animations
func _process(delta):
	showPathUnlockText()
	
func showPathUnlockText():
	if (GLOBAL.orbKills == 7 && canShowText == true):
		$AnimationPlayer.play("ShowText")
		$Timer.start()
		canShowText = false


func _on_Timer_timeout():
	$AnimationPlayer.play_backwards("ShowText")
