extends Node2D

var level2 = preload ("res://FarmNer/Levels/Level2.tscn")

#Changes from Lvl 1 -> 2
func _on_BlackFade_Lvl1to2():
	remove_child($StartingLevel)
	var level2Instance = level2.instance()
	add_child(level2Instance)
	$Player.position = Vector2(141, 64)
	
	
func _ready():
	$AmbianceAudio/Tween.interpolate_property($AmbianceAudio/AudioStreamPlayer, "volume_db", -50.0, $AmbianceAudio/AudioStreamPlayer.volume_db, 4.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$AmbianceAudio/Tween.start()

