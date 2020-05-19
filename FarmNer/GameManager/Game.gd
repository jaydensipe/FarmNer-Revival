extends Node2D
## Changes from Lvl 1 -> 2
#func _on_BlackFade_Lvl1to2():
#	remove_child($StartingLevel)
#	var level2Instance = level2.instance()
#	add_child(level2Instance)
#	$Player.position = Vector2(74, 454)

# Changes from Lvl 2 -> 1
#func LVL2onPlayerEnterLvl1():
#	remove_child($Level2)
#	add_child($StartingLevel)
#	$Player.position = Vector2(936, 472)


func _Test_Player():
	print("DSughuuhuh")

func _ready():
	
	GLOBAL.connect("onPlayerEnterLvl2", self, "_Test_Player")
	$AmbianceAudio/Tween.interpolate_property($AmbianceAudio/AudioStreamPlayer, "volume_db", -50.0, $AmbianceAudio/AudioStreamPlayer.volume_db, 4.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$AmbianceAudio/Tween.start()
	
