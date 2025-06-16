# res://StoneSpawner.gd
extends Node2D

# Wichtig: eine *Scene* vorladen, nicht nur ein Skript!
@onready var StoneScene: PackedScene = preload("res://Stone.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var stone := StoneScene.instantiate() as CharacterBody2D
		stone.global_position = get_global_mouse_position()
		get_tree().current_scene.add_child(stone)
