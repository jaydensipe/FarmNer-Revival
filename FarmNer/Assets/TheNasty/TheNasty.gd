extends Node2D

var rng = RandomNumberGenerator.new()
var colorRand1
var colorRand2
var colorRand3

func _ready():
	randomizeColor()
	

# Sets lights and particles to random colors
func randomizeColor():
	rng.randomize()
	colorRand1 = rng.randf_range(0, 1.0)
	colorRand2 = rng.randf_range(0, 1.0)
	colorRand3 = rng.randf_range(0, 1.0)
	
	$Light2D.color = Color(colorRand1, colorRand2, colorRand3, 1)
	$CPUParticles2D.color = Color(colorRand1, colorRand2, colorRand3, 1)
