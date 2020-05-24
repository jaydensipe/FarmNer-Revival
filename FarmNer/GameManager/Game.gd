extends Node2D


# Preloading levels
var startingLevel = preload("res://FarmNer/Levels/StartingLevel.tscn")
var level2 = preload("res://FarmNer/Levels/Level2.tscn")
var level3 = preload("res://FarmNer/Levels/Level3.tscn")

# Level Instances
var startingLevelInstance = startingLevel.instance()
var level2Instance = level2.instance()
var level3Instance = level3.instance()

# Changes from Lvl 1 -> 2
func _on_PlayerEnter_LVL1TO2():
	call_deferred("remove_child", $StartingLevel)
	call_deferred("add_child", level2Instance)
	$Player.set_deferred("position", Vector2(47, 454))
	call_deferred("levelChangeBlackFade")
	
# Changes from Lvl 1 -> 3
func _on_PlayerEnter_LVL1TO3():
	call_deferred("remove_child", $StartingLevel)
	call_deferred("add_child", level3Instance)
	$Player.set_deferred("position", Vector2(762, 83))
	call_deferred("levelChangeBlackFade")

# Changes from Lvl 2 -> 1
func _on_PlayerEnter_LVL2TO1():
	call_deferred("remove_child", $Level2)
	call_deferred("add_child", startingLevelInstance)
	$Player.set_deferred("position", Vector2(986, 448))
	call_deferred("levelChangeBlackFade")
	
# Changes from Lvl 3 -> 1
func _on_PlayerEnter_LVL3TO1():
	call_deferred("remove_child", $Level3)
	call_deferred("add_child", startingLevelInstance)
	$Player.set_deferred("position", Vector2(439, 474))
	call_deferred("levelChangeBlackFade")


func _ready():
	
	# Loads starting level
	
	call_deferred("add_child", startingLevelInstance)
	
	# Global connections for signals
	GLOBAL.connect("onPlayerEnterLVL1TO2", self, "_on_PlayerEnter_LVL1TO2")
	GLOBAL.connect("onPlayerEnterLVL1TO3", self, "_on_PlayerEnter_LVL1TO3")
	GLOBAL.connect("onPlayerEnterLVL2TO1", self, "_on_PlayerEnter_LVL2TO1")
	GLOBAL.connect("onPlayerEnterLVL3TO1", self, "_on_PlayerEnter_LVL3TO1")
	
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
	
