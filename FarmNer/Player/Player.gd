extends KinematicBody2D

export (int) var speed = 75
var sprintSpeed = 1

var directions = ["Right", "RightDown", "Down", "LeftDown", "Left", "LeftUp", "Up", "RightUp"]
var velocity = Vector2()
var facing = Vector2()


func get_input():
	velocity = Vector2(0, 0)
	
	# Movement & Animation
	
	var left = Input.is_action_pressed("Left")
	var right = Input.is_action_pressed("Right")
	var up = Input.is_action_pressed("Up")
	var down = Input.is_action_pressed("Down")
	
	velocity.x = -int(left) + int(right)
	velocity.y = (-int(up) + int(down)) / float(2)
	facing = velocity
	var animation = direction2str(facing)
	
	if left || right || up || down:
		$Sprite.play(animation)
	elif !left || !right || !up || !down:
		$Sprite.play("IdleUp")
	
	
	# Sprinting
	
	if (Input.is_action_pressed('Shift')):
		sprintSpeed = 1.25
		$Sprite.speed_scale = 3
	elif (Input.is_action_just_released('Shift')):
		sprintSpeed = 1.0
		$Sprite.speed_scale = 2
	
	velocity = velocity.normalized() * speed * sprintSpeed
	
	

func direction2str(direction):
	var angle = direction.angle()
	if angle < 0:
		angle += 2 * PI
	var index = round(angle / PI * 4)
	return directions[index]



func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, 0))
	