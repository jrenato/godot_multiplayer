extends Control


func _on_client_button_pressed() -> void:
	get_tree().change_scene_to_file("res://01 - Setting up a Server/client.tscn")


func _on_server_button_pressed() -> void:
	get_tree().change_scene_to_file("res://01 - Setting up a Server/server.tscn")
