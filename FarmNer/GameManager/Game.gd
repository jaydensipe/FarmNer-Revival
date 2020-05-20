extends Node2D

# Preloading levels
var startingLevel = preload("res://FarmNer/Levels/StartingLevel.tscn")
var level2 = preload("res://FarmNer/Levels/Level2.tscn")
	

# Changes from Lvl 1 -> 2
func _on_PlayerEnter_LVL1TO2():
	call_deferred("remove_child", $StartingLevel)
	var level2Instance = level2.instance()
	call_deferred("add_child", level2Instance)
	$Player.set_deferred("position", Vector2(47, 454))
	call_deferred("levelChangeBlackFade")


# Changes from Lvl 2 -> 1
func _on_PlayerEnter_LVL2TO1():
	call_deferred("remove_child", $Level2)
	var startingLevelInstance = startingLevel.instance()
	call_deferred("add_child", startingLevelInstance)
	$Player.set_deferred("position", Vector2(986, 448))
	call_deferred("levelChangeBlackFade")

func _ready():
	
	# Global connections for signals
	GLOBAL.connect("onPlayerEnterLVL1TO2", self, "_on_PlayerEnter_LVL1TO2")
	GLOBAL.connect("onPlayerEnterLVL2TO1", self, "_on_PlayerEnter_LVL2TO1")
	
	# Fades audio and screen in at beginning
	$Player/BlackFade/AnimationPlayer.play("FadeIn")
	$AmbianceAudio/Tween.interpolate_property($AmbianceAudio/AudioStreamPlayer, "volume_db", -50.0, $AmbianceAudio/AudioStreamPlayer.volume_db, 4.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$AmbianceAudio/Tween.start()
	

# Controls black screen fade on scene change
func levelChangeBlackFade():
	if $Player/BlackFade/AnimationPlayer.is_playing() == true:
		$Player/BlackFade/AnimationPlayer.stop()
		$Player/BlackFade/AnimationPlayer.play("FadeIn")
	else:
		$Player/BlackFade/AnimationPlayer.play("FadeIn")
	
