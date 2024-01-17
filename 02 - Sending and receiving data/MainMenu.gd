extends Control

@export_file("*.tscn") var server_scene
@export_file("*.tscn") var client_scene

@onready var server_button: Button = %ServerButton
@onready var client_button: Button = %ClientButton


func _ready():
	server_button.grab_focus()


func _on_server_button_pressed() -> void:
	get_tree().change_scene_to_file(server_scene)


func _on_client_button_pressed() -> void:
	get_tree().change_scene_to_file(client_scene)
