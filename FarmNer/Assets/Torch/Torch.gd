extends Node2D
   
func _process(delta):
	$Tween.interpolate_property($Light2D, "energy", $Light2D.energy, rand_range(0.3, 2.3), 1.3, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	$Tween.start()
