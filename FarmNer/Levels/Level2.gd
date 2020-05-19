extends Node2D

signal LVL2onPlayerEnterLvl1

# Area portal from Lvl 2 -> 1
func _on_Zone1_body_entered(body):
	emit_signal("LVL2onPlayerEnterLvl1")
