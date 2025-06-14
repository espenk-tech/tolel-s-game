extends CharacterBody2D

var yspeed = 0
var xspeed = 0
var was_on_ceiling = false
var just_looped_x = false
var just_looped_y = false
@export var maxspeed = 200


func find_node_recursive(node: Node, name: String) -> Node:
	if node.name == name:
		return node
	for child in node.get_children():
		var found = find_node_recursive(child, name)
		if found:
			return found
	return null
	
@onready var camera = find_node_recursive(get_tree().get_current_scene(), "Camera2D")


func get_input():
	if (is_on_floor() or is_on_ceiling()):
		yspeed = 0
		if not ((Input.is_action_pressed("Left") and xspeed < 0) or (Input.is_action_pressed("Right") and xspeed > 0)):
			xspeed /= 1.15
	else:
		xspeed /= 1.03
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		yspeed = -300
		
		$JumpSFX.play()
		
	elif is_on_ceiling():
		was_on_ceiling = true
		if Input.is_action_pressed("Jump"):
			yspeed = -300
			if not $SlideSFX.is_playing():
				$SlideSFX.play()
			$SlideSFX.volume_db = -50 + abs(xspeed) * 40/maxspeed
		else:
			yspeed += 10
		if Input.is_action_just_released("Jump"):
			yspeed = 0
	else:
			yspeed += 10
			$SlideSFX.stop()
			if was_on_ceiling and Input.is_action_pressed("Jump"):
				$StopSlideSFX.play()
			was_on_ceiling = false
		
	if is_on_wall():
		xspeed = 0	
	
	if Input.is_action_pressed("Left"):
		xspeed -= 10
	if Input.is_action_pressed("Right"):
		xspeed += 10
		

	
	if xspeed >= maxspeed:
		xspeed = maxspeed
	elif xspeed <= -maxspeed:
		xspeed = -maxspeed
	#print(xspeed)
	if xspeed > -1 and xspeed < 1:
		xspeed = 0
	velocity = Vector2(xspeed, yspeed)
	
func teleport():
	var window_xsize = get_viewport_rect().size[0]
	var window_ysize = get_viewport_rect().size[1]
	if global_position[0] > camera.global_position[0] + window_xsize/4 and just_looped_x == false:
		global_position[0] -= window_xsize/2
		just_looped_x = true
	elif not global_position[0] > camera.global_position[0] + window_xsize/4:
		just_looped_x = false
		
	if global_position[0] < camera.global_position[0] - window_xsize/4 and just_looped_x == false:
		global_position[0] += window_xsize/2
		just_looped_x = true
	elif not global_position[0] < camera.global_position[0] - window_xsize/4:
		just_looped_x = false
		
		
	if global_position[1] > camera.global_position[1] + window_ysize/4 and just_looped_y == false:
		global_position[1] -= window_ysize/2
		just_looped_y = true
	elif not global_position[1] > camera.global_position[1] + window_ysize/4:
		just_looped_y = false
		
	if global_position[1] < camera.global_position[1] - window_ysize/4 and just_looped_y == false:
		global_position[1] += window_ysize/2
		just_looped_y = true
	elif not global_position[1] < camera.global_position[1] - window_ysize/4:
		just_looped_y = false


		

func _physics_process(delta):
	get_input()
	move_and_slide()
	teleport()
	print(yspeed)


		

			
