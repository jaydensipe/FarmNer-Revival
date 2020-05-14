extends Node2D

signal Lvl1to2
var lvl

func _on_StartingLevel_onPlayerEnterLvl2():
	$AnimationPlayer.play("FadeOut")
	$Timer.start()
	var lvl = 2

func _on_StartingLevel_onPlayerEnterLvl3():
	$AnimationPlayer.play("FadeOut")
	$Timer.start()
	var lvl = 3
	
func _on_StartingLevel_levelLoadStartingLevel():
	$AnimationPlayer.play("FadeIn")
	$Timer.start()

func _on_Timer_timeout():
	match lvl:
		2:
			emit_signal("Lvl1to2")
			$AnimationPlayer.play("FadeOut")
		3:
			print(3)
	



