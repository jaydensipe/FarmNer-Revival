extends Node

# GLOBAL SCRIPT

# Level Changing Signals

signal onPlayerEnterLVL1TO2
signal onPlayerEnterLVL2TO1
signal onPlayerEnterLVL1TO3
signal onPlayerEnterLVL3TO1

# Does the player have the orb killer unlocked

var orbDestroyerUnlocked = false

# Hurt Player

signal hurtPlayer

# Bandage Count

var bandageCount = 0


# Adds 1 bandage to the player
func addBandage():
	bandageCount += 1

# Removes 1 bandage from the player	
func removeBandage():
	bandageCount -= 1
