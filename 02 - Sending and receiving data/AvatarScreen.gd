extends Control

const ADDRESS = "127.0.0.1"
const PORT = 9999

@onready var texture_rect = $AvatarCard/TextureRect
@onready var label = $AvatarCard/Label


func request_authentication(packet: PacketPeerUDP):
	var request = {
		"get_authentication_token": true,
		"user": AuthenticationCredentials.user,
		"token": AuthenticationCredentials.session_token
	}
	packet.put_var(JSON.stringify(request))

	while packet.wait() == OK:
		var data: Dictionary = JSON.parse_string(packet.get_var())
		if data == AuthenticationCredentials.session_token:
			request_avatar(packet)
			break

func request_avatar(packet: PacketPeerUDP):
	var request = {
		"get_avatar": true,
		"user": AuthenticationCredentials.user,
		"token": AuthenticationCredentials.session_token
	}
	packet.put_var(JSON.stringify(request))

	while packet.wait() == OK:
		var data: Dictionary = JSON.parse_string(packet.get_var())
		# Do something with the avatar data
