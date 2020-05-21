extends Node2D

var bandageCount = 0

# Adds 1 bandage to the player
func addBandage():
	bandageCount += 1
	$Label.set_text(str(bandageCount))

# Removes 1 bandage from the player
func removeBandage():
	bandageCount -= 1
	$Label.set_text(str(bandageCount))

