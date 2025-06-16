extends CharacterBody2D

var gravity   := 1200.0
var max_speed := 450.0

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity.y = clamp(velocity.y, -max_speed, max_speed)
	move_and_slide()

func initialize(pos):
	global_position = pos
