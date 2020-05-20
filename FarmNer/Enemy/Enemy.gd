extends KinematicBody2D

const speed = 80

var player = null

func _ready():
	add_to_group("Enemy")
	
func _physics_process(delta):
	if player == null:
		return
		
	var vecToPlayer = player.global_position - global_position
	vecToPlayer = vecToPlayer.normalized()
	move_and_collide(vecToPlayer * speed * delta)

func set_player(p):
	player = p
