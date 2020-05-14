extends Node2D

var playerEntered = false 

# Detects if player enters chest range
func _on_PlayerDetection_body_entered(body):
	var groups = body.get_groups()
	if(groups.has("Player")):
		playerEntered = true
		
# Detects if player leaves chest range
func _on_PlayerDetection_body_exited(body):
	var groups = body.get_groups()
	if(groups.has("Player")):
		playerEntered = false
		
# Detects if mouse enters chest range
func _on_Area2D_mouse_entered():
	if (playerEntered == true):
		$Sprite.material.set_shader_param("turnOn", 1.0)

# Detects if mouse leaves chest range
func _on_Area2D_mouse_exited():
	$Sprite.material.set_shader_param("turnOn", 0.0)
	



