extends Node2D

signal SoundFinished

# Tells player sound is finished
func _on_AudioStreamPlayer_finished():
	emit_signal("SoundFinished")
