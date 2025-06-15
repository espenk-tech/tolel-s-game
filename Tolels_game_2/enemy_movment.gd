extends CharacterBody2D

@export var enemy_speed: float = 2.0

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
	if player != null:
		global_position = global_position.lerp(player.global_position, delta * enemy_speed)

func _physics_process(delta):
	move_and_slide()
