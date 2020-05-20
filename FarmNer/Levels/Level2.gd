extends Node2D

# Area portal from Lvl 2 -> 1
func _on_Zone1_body_entered(body):
	GLOBAL.emit_signal("onPlayerEnterLVL2TO1")
