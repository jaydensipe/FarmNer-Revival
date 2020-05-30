extends Node2D

var canShowText = true
var timeStarted = false

func _ready():
	$Label4.disabled = true

# Plays animations
func _process(delta):
	showDeathUnlock()
	
	if (GLOBAL.playerDead == true && GLOBAL.endGame == true && timeStarted == false):
		$Timer.start()
		timeStarted = true
	
func showDeathUnlock():
	if (GLOBAL.playerDead == true && canShowText == true && GLOBAL.endGame == false):
		$AnimationPlayer.play("ShowText")
		$Label4.disabled = false
		$Label4.mouse_filter = 0
		canShowText = false


func _on_Label4_pressed():
	GLOBAL.resetAllGlobalValues()
	get_tree().reload_current_scene()


func _on_Timer_timeout():
	get_tree().quit()
