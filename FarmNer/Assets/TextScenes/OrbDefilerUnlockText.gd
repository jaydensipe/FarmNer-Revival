extends Node2D

var canShowText = true

# Plays animations
func _process(delta):
	showOrbUnlockText()
	
func showOrbUnlockText():
	if (GLOBAL.orbDestroyerUnlocked == true && canShowText == true):
		$AnimationPlayer.play("ShowText")
		$Timer.start()
		canShowText = false


func _on_Timer_timeout():
	$AnimationPlayer.play_backwards("ShowText")
