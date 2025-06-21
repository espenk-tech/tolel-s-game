extends Camera2D

@export var return_speed: float = 5.0

@onready var player = find_node_recursive(get_tree().get_current_scene(), "Player")
@onready var area   = find_node_recursive(get_tree().get_current_scene(), "use_cam_area")
@onready var freeze_timer: Timer = $freeze_timer

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

func start_freeze():
	freeze_camera = true
	freeze_timer_running = true
	frozen_position = area.find_child("cam_center", false).global_position
	freeze_timer.start(10)
	await freeze_timer.timeout
	freeze_camera = false
	freeze_timer_running = false

func _process(delta):
	if player == null:
		push_warning("Player node not found!")
		return
	if freeze_camera:
		self.global_position = self.global_position.lerp(frozen_position, delta * return_speed)
	else:
		self.global_position = global_position.lerp(player.global_position, delta * return_speed)

func _input(event):
	if event.is_action_pressed("cam_stop"):
		var in_area = area.get_overlapping_bodies().has(player)
		if in_area and not freeze_camera:
			start_freeze()
	elif event.is_action_released("cam_stop"):
		pass
