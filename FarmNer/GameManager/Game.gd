extends Node2D


# Preloading levels
var startingLevel = load("res://FarmNer/Levels/StartingLevel.tscn")
var level2 = load("res://FarmNer/Levels/Level2.tscn")
var level3 = load("res://FarmNer/Levels/Level3.tscn")
var level4 = load("res://FarmNer/Levels/Level4.tscn")
var level5 = load("res://FarmNer/Levels/Level5.tscn")
var level6 = load("res://FarmNer/Levels/EndLevel.tscn")
var level7 = load("res://FarmNer/Levels/EndLevelBright.tscn")
var endLevel = load("res://FarmNer/Levels/EndLevelEND.tscn")

# Level Instances
var startingLevelInstance = startingLevel.instance()
var level2Instance = level2.instance()
var level3Instance = level3.instance()
var level4Instance = level4.instance()
var level5Instance = level5.instance()
var level6Instance = level6.instance()
var level7Instance = level7.instance()
var endLevelInstance = endLevel.instance()

# End animation played

var endAnimationPlayed = false
var endDeathAnimation = false

var alreadyEnded = false

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
	
# Changes from Lvl 1 -> 6
func _on_PlayerEnter_LVL1TO6():
	call_deferred("remove_child", $StartingLevel)
	call_deferred("add_child", level6Instance)
	$Player.set_deferred("position", Vector2(1049, 86))
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

# Changes from Lvl 3 -> 4
func _on_PlayerEnter_LVL3TO4():
	call_deferred("remove_child", $Level3)
	call_deferred("add_child", level4Instance)
	$Player.set_deferred("position", Vector2(1038, 280))
	call_deferred("levelChangeBlackFade")

# Changes from Lvl 3 -> 5	
func _on_PlayerEnter_LVL3TO5():
	call_deferred("remove_child", $Level3)
	call_deferred("add_child", level5Instance)
	$Player.set_deferred("position", Vector2(256, 216))
	call_deferred("levelChangeBlackFade")
	
# Changes from Lvl 4 -> 3
func _on_PlayerEnter_LVL4TO3():
	call_deferred("remove_child", $Level4)
	call_deferred("add_child", level3Instance)
	$Player.set_deferred("position", Vector2(285, 125))
	call_deferred("levelChangeBlackFade")
	
# Changes from Lvl 5 -> 3
func _on_PlayerEnter_LVL5TO3():
	call_deferred("remove_child", $Level5)
	call_deferred("add_child", level3Instance)
	$Player.set_deferred("position", Vector2(1032, 232))
	call_deferred("levelChangeBlackFade")

func _process(delta):
	# Triggers end of game
	if (GLOBAL.brainOrbIsDead == true && endAnimationPlayed == false):
		$Player/BlackFade/AnimationPlayer.play("FadeOutWhite")
		endAnimationPlayed = true
		# YIELD IS THE BEST FUNCTION IN GODOT!!!! WHY DID I MAKE MILLION TIMERS!!!
		yield($Player/BlackFade/AnimationPlayer, "animation_finished")
		$Player/BlackFade/AnimationPlayer.play_backwards("FadeOutWhite")
		call_deferred("remove_child", $EndLevel)
		$Player/Flashlight.set_process(false)
		$Player/Flashlight.hide()
		$Player/BandageBar.set_process(false)
		$Player/BandageBar.hide()
		$Player/HealthBar.set_process(false)
		$Player/HealthBar.hide()
		$Player/OrbKillBar.set_process(false)
		$Player/OrbKillBar.hide()
		$Player/Light2D.hide()
		$Player/Flashlight/FlashLightSound/Off.volume_db = -50
		$Player/Flashlight/FlashLightSound/On.volume_db = -50
		$AmbianceAudioForBright/AudioStreamPlayer.play()
		$AmbianceAudio/AudioStreamPlayer.stop()
		call_deferred("add_child", level7Instance)
		
	if (GLOBAL.playerDead == true && endDeathAnimation == false):
		$Player/BlackFade/AnimationPlayer.play("FadeOutDead")
		get_tree().paused = true
		$Player/BlackFade/AnimationPlayer.playback_speed = 2
		endDeathAnimation = true
		
	if (GLOBAL.endGame == true && alreadyEnded == false):
		call_deferred("remove_child", $EndLevelBright)
		call_deferred("add_child", endLevelInstance)
		$Player/Flashlight.set_process(true)
		$Player/Flashlight.show()
		$Player/BandageBar.set_process(true)
		$Player/BandageBar.show()
		$Player/HealthBar.set_process(true)
		$Player/HealthBar.show()
		$Player/OrbKillBar.set_process(true)
		$Player/OrbKillBar.show()
		$Player/Light2D.show()
		$Player/Flashlight/FlashLightSound/Off.volume_db = 0.0
		$Player/Flashlight/FlashLightSound/On.volume_db = 0.0
		$Player.playerHealth = 30
		$Player/HeartbeatSound/AudioStreamPlayer.play()
		
		alreadyEnded == true
		

func _ready():
	
	get_tree().paused = false
	
	# Loads starting level
	
	call_deferred("add_child", startingLevelInstance)
	
	# Global connections for signals
	GLOBAL.connect("onPlayerEnterLVL1TO2", self, "_on_PlayerEnter_LVL1TO2")
	GLOBAL.connect("onPlayerEnterLVL1TO3", self, "_on_PlayerEnter_LVL1TO3")
	GLOBAL.connect("onPlayerEnterLVL1TO6", self, "_on_PlayerEnter_LVL1TO6")
	GLOBAL.connect("onPlayerEnterLVL2TO1", self, "_on_PlayerEnter_LVL2TO1")
	GLOBAL.connect("onPlayerEnterLVL3TO1", self, "_on_PlayerEnter_LVL3TO1")
	GLOBAL.connect("onPlayerEnterLVL3TO4", self, "_on_PlayerEnter_LVL3TO4")
	GLOBAL.connect("onPlayerEnterLVL3TO5", self, "_on_PlayerEnter_LVL3TO5")
	GLOBAL.connect("onPlayerEnterLVL4TO3", self, "_on_PlayerEnter_LVL4TO3")
	GLOBAL.connect("onPlayerEnterLVL5TO3", self, "_on_PlayerEnter_LVL5TO3")
	
	
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
	
