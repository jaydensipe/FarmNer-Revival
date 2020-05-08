extends Node2D

func _on_StartingLevel_onPlayerEnterBlack():
	$AnimationPlayer.play("FadeOut")


func _on_StartingLevel_levelLoadStartingLevel():
	$AnimationPlayer.play("FadeIn")
