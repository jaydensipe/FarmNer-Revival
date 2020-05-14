extends Node2D

var level2 = preload ("res://FarmNer/Levels/StartingLevelTEST.tscn")

func _on_BlackFade_Lvl1to2():
	remove_child($StartingLevel)
	var level2Instance = level2.instance()
	add_child(level2Instance)
	$Player.position = Vector2(141, 64)
