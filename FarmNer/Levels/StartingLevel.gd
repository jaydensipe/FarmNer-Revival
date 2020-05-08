extends Node2D

signal onPlayerEnterBlack
signal levelLoadStartingLevel

func _on_Zone1_body_entered(body):
	var groups = body.get_groups()
	if (groups.has("Player")):
		emit_signal("onPlayerEnterBlack")


func _on_StartingLevel_tree_entered():
	emit_signal ("levelLoadStartingLevel")
