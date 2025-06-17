extends Camera2D

@export var return_speed: float = 5.0

var freeze_camera = false
var frozen_position = Vector2.ZERO

func find_node_recursive(node: Node, name: String) -> Node:
	if node.name == name:
		return node
	for child in node.get_children():
		var found = find_node_recursive(child, name)
		if found:
			return found
	return null

@onready var player = find_node_recursive(get_tree().get_current_scene(), "CharacterBody2D")

func _process(delta):
	if player == null:
		push_warning("CharacterBody2D node not found!")
		return
	if freeze_camera:
		global_position = global_position.lerp(frozen_position, delta * return_speed)
	else:
		global_position = global_position.lerp(player.global_position, delta * return_speed)

func _input(event):
	if event.is_action_pressed("follow_stop"):
		if not freeze_camera:
			freeze_camera = true
			frozen_position = player.global_position
	elif event.is_action_released("follow_stop"):
		freeze_camera = false
		
	var win := get_window()
	var parent_win := get_parent().get_window()
	var current_size := win.size
