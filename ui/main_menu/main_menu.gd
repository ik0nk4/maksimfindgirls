extends Control


@onready var buttons_container: VBoxContainer = $buttons_container
@onready var new_game_title: Label = $buttons_container/new_game_button/new_game_title
@onready var continue_title: Label = $buttons_container/continue_button/continue_title
@onready var exit_title: Label = $buttons_container/exit_button/exit_title
@onready var settings_button: Button = $settings_button
@onready var panel_container: PanelContainer = $settings_menu

@onready var GameManager = get_node("/root/GameManager")

func _on_new_game_button_down() -> void:
	new_game_title.position.y += 5

func _on_new_game_button_up() -> void:
	new_game_title.position.y -= 5
	GameManager.change_scene_with_fade("res://scenes/locations/3d_maksik_home.tscn")


func _on_continue_button_down() -> void:
	continue_title.position.y += 5

func _on_continue_button_up() -> void:
	continue_title.position.y -= 5


func _on_exit_button_down() -> void:
	exit_title.position.y += 5

func _on_exit_button_up() -> void:
	exit_title.position.y -= 5
	get_tree().quit()


func _on_settings_button_pressed() -> void:
	buttons_container.visible = false
	settings_button.visible = false
	panel_container.visible = true
