extends Node2D

var canShowText = true

func _ready():
	$Label4.disabled = true

# Plays animations
func _process(delta):
	showDeathUnlock()
	
func showDeathUnlock():
	if (GLOBAL.playerDead == true && canShowText == true):
		$AnimationPlayer.play("ShowText")
		$Label4.disabled = false
		canShowText = false


func _on_Label4_pressed():
	GLOBAL.resetAllGlobalValues()
	get_tree().reload_current_scene()
