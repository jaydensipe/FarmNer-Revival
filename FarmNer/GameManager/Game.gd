extends Node2D

# Preloading levels
var startingLevel = preload("res://FarmNer/Levels/StartingLevel.tscn")
var level2 = preload("res://FarmNer/Levels/Level2.tscn")

# Changes from Lvl 1 -> 2
func _on_PlayerEnter_LVL1TO2():
	remove_child($StartingLevel)
	var level2Instance = level2.instance()
	add_child(level2Instance)
	$Player.call_deferred("set", "position", Vector2(74, 454))


# Changes from Lvl 2 -> 1
func _on_PlayerEnter_LVL2TO1():
	remove_child($Level2)
	var startingLevelInstance = startingLevel.instance()
	add_child(startingLevelInstance)
	$Player.call_deferred("set", "position", Vector2(936, 472))

func _ready():
	
	# Global connections for signals
	GLOBAL.connect("onPlayerEnterLVL1TO2", self, "_on_PlayerEnter_LVL1TO2")
	GLOBAL.connect("onPlayerEnterLVL2TO1", self, "_on_PlayerEnter_LVL2TO1")
	
	# Fades audio and screen in at beginning
	$Player/BlackFade/AnimationPlayer.play("FadeIn")
	$AmbianceAudio/Tween.interpolate_property($AmbianceAudio/AudioStreamPlayer, "volume_db", -50.0, $AmbianceAudio/AudioStreamPlayer.volume_db, 4.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$AmbianceAudio/Tween.start()
	
