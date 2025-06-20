class_name SmoothPath
extends Path2D

@export var spline_length = 8
@export var _smooth: bool: set = smooth
@export var straighten_setget_straighten = true
@export var color = Color(1,1,1,1)
@export var width = 2

func straighten(value):
	if not value: return
	for i in curve.get_point_count():
		curve.set_point_in(i, Vector2())
		curve.set_point_out(i, Vector2())

func smooth(value):
	if not value: return
	
	var point_count = curve.get_point_count()
	for i in point_count:
		var spline = _get_spline(i)
		curve.set_point_in(i, -spline)
		curve.set_point_out(i, spline)

func _get_spline(i):
	var last_point = _get_point(i - 1)
	var next_point = _get_point(i + 1)
	var spline = last_point.direction_to(next_point) * spline_length
	return spline

func _get_point(i):
	var point_count = curve.get_point_count()
	i = wrapi(i, 0, point_count - 1)
	return curve.get_point_position(i)

func _draw():
	var points = curve.get_baked_points()
	if points:
		draw_polyline(points, Color(1,1,1,1), 1, true)
