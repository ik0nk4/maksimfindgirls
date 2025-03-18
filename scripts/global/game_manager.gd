extends Node

var current_scene = null

func _ready():
	print("Game starting...")
	
	change_scene("res://ui/main_menu/main_menu.tscn")

func change_scene(path):
	call_deferred("_deferred_change_scene", path)
	
func _deferred_change_scene(path):
	if current_scene:
		current_scene.free()
	
	var new_scene = load(path).instantiate()
	
	add_child(new_scene)
	current_scene = new_scene
