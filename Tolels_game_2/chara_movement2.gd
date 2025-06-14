extends CharacterBody2D

var yspeed = 0

func get_input():
	if Input.is_action_just_pressed("Jump"):
		yspeed == 100
	else:
		yspeed += 10
	velocity = Vector2(0, yspeed)


func _physics_process(delta):
	get_input()
	move_and_slide()
