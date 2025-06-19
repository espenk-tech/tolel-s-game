extends Camera2D

@export var return_speed: float = 5.0

@onready var player = find_node_recursive(get_tree().get_current_scene(), "CharacterBody2D")
@onready var area   = find_node_recursive(get_tree().get_current_scene(), "use_cam_area")

var freeze_camera   = false
var frozen_position = Vector2.ZERO
var freeze_timer_running = false

func find_node_recursive(node: Node, name: String) -> Node:
	if node.name == name:
		return node
	for child in node.get_children():
		var found = find_node_recursive(child, name)
		if found:
			return found
	return null

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
		var in_area = area.get_overlapping_bodies().has(player)
		if in_area and not freeze_timer_running:
			start_freeze()
	elif event.is_action_released("follow_stop"):
		pass

func start_freeze():
	freeze_camera = true
	freeze_timer_running = true
	frozen_position = player.global_position
	print("10 Sekunden")

	await get_tree().create_timer(10.0).timeout

	freeze_camera = false
	freeze_timer_running = false
	print("▶️ Kamera folgt wieder")
