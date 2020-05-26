extends Node2D

# Set current level
func _enter_tree():
	GLOBAL.currentLevelPlayer = 4

# Area portal from Lvl 4 -> 3
func _on_Zone1_body_entered(body):
	GLOBAL.emit_signal("onPlayerEnterLVL4TO3")
