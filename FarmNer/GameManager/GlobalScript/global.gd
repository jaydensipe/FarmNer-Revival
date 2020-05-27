extends Node

# GLOBAL SCRIPT

# Level Changing Signals

signal onPlayerEnterLVL1TO2
signal onPlayerEnterLVL2TO1
signal onPlayerEnterLVL1TO3
signal onPlayerEnterLVL3TO1
signal onPlayerEnterLVL3TO4
signal onPlayerEnterLVL4TO3
signal onPlayerEnterLVL1TO6

# Current level of player

var currentLevelPlayer = 1

# Turn off flashlight signal

signal turnOffFlashlight

# Does the player have the orb killer unlocked

var orbDestroyerUnlocked = false

# Does the player have the dynamite

var dynamiteAquired = true

# Hurt Player

signal hurtPlayer

# Bandage Count

var bandageCount = 0

# Orb Kills the player has

var orbKills = 0

# Boom

var boomHappened = false

# Adds 1 bandage to the player
func addBandage():
	bandageCount += 1

# Removes 1 bandage from the player	
func removeBandage():
	bandageCount -= 1
	
# Resets all values (used for death)
func resetAllGlobalValues():
	bandageCount = 0
	currentLevelPlayer = 1
	orbKills = 0
	orbDestroyerUnlocked = false
	dynamiteAquired = false
	boomHappened = false

