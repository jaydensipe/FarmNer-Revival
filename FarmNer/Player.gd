extends KinematicBody2D

export (int) var speed = 75

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('Right'):
		velocity.x += 1
	if Input.is_action_pressed('Left'):
		velocity.x -= 1
	if Input.is_action_pressed('Down'):
		velocity.y += 1
	if Input.is_action_pressed('Up'):
		velocity.y -= 1
	if (Input.is_action_pressed('Shift')):
		speed = 100
	elif (Input.is_action_just_released('Shift')):
		speed = 75
	
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
