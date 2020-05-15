extends Node2D

var cameraMove = Vector2()
var shake = 0
var shake_magnitude = 1
	
func _process(delta):
	
	get_parent().offset = Vector2(rand_range(-shake, shake), rand_range(-shake, shake))
	shake *= 0.9
