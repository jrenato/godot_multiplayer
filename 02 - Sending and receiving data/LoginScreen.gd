extends Control

const ADDRESS: String = "127.0.0.1"
const PORT: int = 9999

@onready var user_line_edit: LineEdit = %UserLineEdit
@onready var password_line_edit: LineEdit = %PasswordLineEdit
@onready var error_label: Label = %ErrorLabel


func send_credentials() -> void:
	var message: Dictionary = {
		"authenticate_credentials": {
			"user": user_line_edit.text,
			"password": password_line_edit.text
		}
	}

	var packet: PacketPeerUDP = PacketPeerUDP.new()
	packet.connect_to_host(ADDRESS, PORT)
	packet.put_var(JSON.stringify(message))

	while packet.wait() == OK:
		var response: Dictionary = JSON.parse_string(packet.get_var())
		if "token" in response:
			AuthenticationCredentials.session_token = response["token"]
			AuthenticationCredentials.user = response["authentication_credentials"]["user"]
			error_label.text = "Logged!"
			get_tree().change_scene_to_file("res://02 - Sending and receiving data/AvatarScreen.tscn")
			break
		else:
			error_label.text = "Login failed"
			break


func _on_user_line_edit_text_submitted(new_text: String) -> void:
	pass # Replace with function body.


func _on_password_line_edit_text_submitted(new_text: String) -> void:
	pass # Replace with function body.


func _on_login_button_pressed() -> void:
	pass # Replace with function body.
