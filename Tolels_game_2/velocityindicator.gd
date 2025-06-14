extends Line2D

func _physics_process(delta):
	set_point_position(1, Vector2(get_parent().xspeed, get_parent().yspeed)*0.2)
