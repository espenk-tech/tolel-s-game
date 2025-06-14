extends CharacterBody2D

var yspeed = 0
var xspeed = 0

func get_input():
	if is_on_floor():
		yspeed = 0
		xspeed /= 1.2
	else:
		xspeed /= 1.01
	if Input.is_action_just_pressed("Jump"):
		yspeed = -300
	else:
		yspeed += 10
	if Input.is_action_pressed("Left"):
		xspeed -= 10
	if Input.is_action_pressed("Right"):
		xspeed += 10
	velocity = Vector2(xspeed, yspeed)

func _physics_process(delta):
	get_input()
	move_and_slide()
