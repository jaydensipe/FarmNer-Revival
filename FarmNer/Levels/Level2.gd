extends Node2D

# Set current level
func _enter_tree():
	GLOBAL.currentLevelPlayer = 2

# Area portal from Lvl 2 -> 1
func _on_Zone1_body_entered(body):
	GLOBAL.emit_signal("onPlayerEnterLVL2TO1")
