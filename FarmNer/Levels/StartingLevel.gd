extends Node2D

signal onPlayerEnterLvl2
signal onPlayerEnterLvl3
signal levelLoadStartingLevel

func _on_Zone1_body_entered(body):
	var groups = body.get_groups()
	if (groups.has("Player")):
		emit_signal("onPlayerEnterLvl2")
		
func _on_Zone2_body_entered(body):
	var groups = body.get_groups()
	if (groups.has("Player")):
		emit_signal("onPlayerEnterLvl3")


func _on_StartingLevel_tree_entered():
	emit_signal("levelLoadStartingLevel")



