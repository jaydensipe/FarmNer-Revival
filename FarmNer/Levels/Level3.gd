extends Node2D

# Area portal from Lvl 3 -> 1
func _on_Zone3_body_entered(body):
	GLOBAL.emit_signal("onPlayerEnterLVL3TO1")
