extends CharacterBody2D

@export var speed = 400
@export var gravity = Vector2(0, 200)
var jumpheight = 30

func get_input():
	if jumpheight > 0:
		var input_direction = Input.get_vector("Left", "Right", "Jump", "Down")
		#velocity = input_direction * speed + gravity
		velocity = velocity.move_toward(input_direction * speed + gravity, 150)
			
	else:
		var input_direction = Input.get_vector("Left", "Right", "", "")
		#velocity = input_direction * speed + gravity
		velocity = velocity.move_toward(input_direction * speed + gravity, 100)
	if is_on_floor():
		jumpheight = 30
	else:
		jumpheight -= 1
	

func _physics_process(delta):
	get_input()
	move_and_slide()
