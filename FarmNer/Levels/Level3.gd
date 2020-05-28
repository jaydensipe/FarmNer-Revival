extends Node2D

# Set current level
func _enter_tree():
	GLOBAL.currentLevelPlayer = 3

# Area portal from Lvl 3 -> 1
func _on_Zone3_body_entered(body):
	GLOBAL.emit_signal("onPlayerEnterLVL3TO1")

# Area portal from Lvl 3 -> 4 
func _on_Zone2_body_entered(body):
	GLOBAL.emit_signal("onPlayerEnterLVL3TO4")
	
# Area portal from Lvl 3 -> 5
func _on_Zone1_body_entered(body):
	GLOBAL.emit_signal("onPlayerEnterLVL3TO5")

# Deletes fence tiles when explosion goes off
func _physics_process(delta):
	if(GLOBAL.boomHappened == true):
		$Tiles/BlockFence.clear()


