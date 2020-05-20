extends Node2D

# Area Portal from Lvl 1 -> 2
func _on_Zone1_body_entered(body):
	GLOBAL.emit_signal("onPlayerEnterLVL1TO2")
		
# Area Portal from Lvl 1 -> 3
func _on_Zone2_body_entered(body):
	GLOBAL.emit_signal("onPlayerEnterLVL1TO3")
