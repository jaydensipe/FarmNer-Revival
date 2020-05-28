extends Node2D

# Set current level
func _enter_tree():
	GLOBAL.currentLevelPlayer = 5

# Area portal from Lvl 5 -> 3
func _on_Zone1_body_entered(body):
	GLOBAL.emit_signal("onPlayerEnterLVL5TO3")
