extends "res://FarmNer/Assets/TheNasty/TheNasty.gd"

func _process(delta):
	if(GLOBAL.orbKills == 7):
		queue_free()
