extends Node2D

signal onPlayerEnterLvl2
signal onPlayerEnterLvl3

# Area Portal from Lvl 1 -> 2
func _on_Zone1_body_entered(body):
	GLOBAL.emit_signal("onPlayerEnterLvl2")
		
# Area Portal from Lvl 1 -> 3
func _on_Zone2_body_entered(body):
		emit_signal("onPlayerEnterLvl3")
