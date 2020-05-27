extends Node2D

var canShowText = true

# Sets HUD text to current number of bandages
func _process(delta):
	$Label.set_text(str(GLOBAL.orbKills))
	showOrbBarUnlockText()

	
func showOrbBarUnlockText():
	if (GLOBAL.orbDestroyerUnlocked == true && canShowText == true):
		$AnimationPlayer.play("ShowOrbBar")
		canShowText = false
