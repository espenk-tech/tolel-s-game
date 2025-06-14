extends Sprite2D

func _physics_process(delta):
	global_position = Vector2(get_parent().global_position[0] + get_viewport_rect().size[0]/2, get_parent().global_position[1])
