extends Node2D

var velocity = 0
var force = 0
var height = 0
var resting_hight = 0

var index = 0

var motion_factor = 0.02

signal splash

@onready var collision = $"Area2D/CollisionShape2D"  # Pfad korrigiert

func _ready():
	if collision == null:
		push_error("CollisionShape2D konnte nicht gefunden werden!")
	# optional: else: print("CollisionShape2D gefunden")

func spring_update(spring_constant, dampening):
	height = position.y
	var x = height - resting_hight
	var loss = -dampening * velocity
	force = -spring_constant * x + loss
	velocity += force
	position.y += velocity

func initialize(x_position,id):
	height = position.y
	resting_hight = position.y
	velocity = 0
	position.x = x_position
	index = id

func set_collision_width(value):
# stelle sicher, dass collision nicht null ist
	if collision == null:
		push_error("set_collision_width: CollisionShape2D ist null!")
	return

	var extents = collision.shape.get_extents()
	var new_extents = Vector2(value/2, extents.y)
	collision.shape.set_extents(new_extents)
	
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	var speed = body.velocity.y * motion_factor
	emit_signal("splash",index,speed)
	
	pass # Replace with function body.
