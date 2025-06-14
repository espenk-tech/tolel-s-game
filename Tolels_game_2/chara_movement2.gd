extends CharacterBody2D

var yspeed = 0
var xspeed = 0
@export var maxspeed = 200

func get_input():
	if (is_on_floor() or is_on_ceiling()):
		yspeed = 0
		if not (Input.is_action_pressed("Left") or Input.is_action_pressed("Right")):
			xspeed /= 1.15
	else:
		xspeed /= 1.03
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		yspeed = -300
	elif is_on_ceiling():
		if Input.is_action_pressed("Jump"):
			yspeed = -300
		else:
			yspeed += 10
		if Input.is_action_just_released("Jump"):
			yspeed = 0
	else:
			yspeed += 10
		
	if Input.is_action_pressed("Left"):
		xspeed -= 10
	if Input.is_action_pressed("Right"):
		xspeed += 10
		
	if is_on_wall():
		xspeed = 0
	
	if xspeed >= maxspeed:
		xspeed = maxspeed
	elif xspeed <= -maxspeed:
		xspeed = -maxspeed
	print(xspeed)
	if xspeed > -1 and xspeed < 1:
		xspeed = 0
	velocity = Vector2(xspeed, yspeed)

func _physics_process(delta):
	get_input()
	move_and_slide()
