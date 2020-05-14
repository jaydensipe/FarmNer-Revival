extends Node2D

signal Lvl1to2
var lvl = 0

func _on_StartingLevel_onPlayerEnterLvl2():
	$AnimationPlayer.play("FadeOut")
	lvl = 2
	$Timer.start()

func _on_StartingLevel_onPlayerEnterLvl3():
	$AnimationPlayer.play("FadeOut")
	lvl = 3
	$Timer.start()
	
func _on_StartingLevel_levelLoadStartingLevel():
	$AnimationPlayer.play("FadeIn")
	$Timer.start()

func _on_Timer_timeout():
	match lvl:
		2:
			emit_signal("Lvl1to2")
			$AnimationPlayer.play("FadeIn")
		3:
			print(3)
		
	



