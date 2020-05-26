extends Node2D


# Sets HUD text to current number of bandages
func _process(delta):
	$Label.set_text(str(GLOBAL.orbKills))
