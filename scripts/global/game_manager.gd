extends Node

var current_scene = null
var previous_scene = null
var scene_history = []

func _ready():
	print("Game starting...")
	
	current_scene = get_tree().current_scene
	
	await get_tree().process_frame
	
	if current_scene:
		scene_history.append(current_scene.scene_file_path)
		print("Игра запущена со сцены: " + current_scene.scene_file_path)

func change_scene(path):
	call_deferred("_deferred_change_scene", path)
	
func _deferred_change_scene(path):
	if current_scene:
		previous_scene = current_scene
		scene_history.append(current_scene.scene_file_path)
	
	var error = get_tree().change_scene_to_file(path)
	if error == OK:
		await get_tree().process_frame
		current_scene = get_tree().current_scene
		print("Сцена изменена на: " + path)
	else:
		print("Ошибка при смене сцены на: " + path)

func go_back():
	if scene_history.size() > 1:
		scene_history.pop_back()
		var prev_path = scene_history.pop_back()
		change_scene(prev_path)
	else:
		print("Нет предыдущей сцены для возврата")

func reload_current_scene():
	if current_scene:
		var current_path = current_scene.scene_file_path
		change_scene(current_path)
	else:
		print("Нет текущей сцены для перезагрузки")

func change_scene_with_fade(path, fade_time = 0.5):
	var transition = CanvasLayer.new()
	add_child(transition)
	
	var fade_rect = ColorRect.new()
	fade_rect.color = Color(0, 0, 0, 0)
	fade_rect.size = Vector2(1920, 1080)
	fade_rect.anchors_preset = Control.PRESET_FULL_RECT
	transition.add_child(fade_rect)
	
	var tween = create_tween()
	tween.tween_property(fade_rect, "color", Color(0, 0, 0, 1), fade_time)
	await tween.finished
	
	change_scene(path)
	
	await get_tree().process_frame
	
	tween = create_tween()
	tween.tween_property(fade_rect, "color", Color(0, 0, 0, 0), fade_time)
	await tween.finished
	
	transition.queue_free()
