extends Node2D

var canShowText = true

# Plays animations
func _process(delta):
	showDeathUnlock()
	
func showDeathUnlock():
	if (GLOBAL.playerDead == true && canShowText == true):
		$AnimationPlayer.play("ShowText")
		canShowText = false


func _on_Timer_timeout():
	$AnimationPlayer.play_backwards("ShowText")
