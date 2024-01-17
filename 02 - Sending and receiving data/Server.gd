extends Node

const PORT: int = 9999

@export var database_file_path = "res://FakeDatabase.json"

var server: UDPServer = UDPServer.new()
var fake_database: Dictionary
var logged_users: Dictionary = {}


func _ready() -> void:
	load_database()
	server.listen(PORT)


func _process(delta: float) -> void:
	server.poll()
	if server.is_connection_available():
		var peer: PacketPeerUDP = server.take_connection()
		var message = JSON.parse_string(peer.get_var())
		if "authenticate_credentials" in message:
			authenticate_player(peer, message)
		elif "get_authentication_token" in message:
			get_authentication_token(peer, message)
		elif "get_avatar" in message:
			get_avatar(peer, message)


func load_database() -> void:
	var file = FileAccess.open(database_file_path, FileAccess.READ)
	var file_contents: String = file.get_as_text()
	fake_database = JSON.parse_string(file_contents)


func authenticate_player(peer: PacketPeerUDP, message: Dictionary) -> void:
	var credentials: Dictionary = message["authenticate_credentials"]
	if "user" in credentials and "password" in credentials:
		var user: String = credentials["user"]
		var password: String = credentials["password"]
		if user in fake_database and fake_database[user] == password:
			var token = randi()
			logged_users[user] = token
			var response: Dictionary = {"token": token}
			peer.put_var(JSON.stringify(response))
		else:
			peer.put_var("")


func get_authentication_token(peer: PacketPeerUDP, message: Dictionary) -> void:
	var credentials: Dictionary = message
	if "user" in credentials:
		if credentials["token"] == logged_users[credentials["user"]]:
			var token = logged_users[credentials["user"]]
			peer.put_var(JSON.stringify(token))


func get_avatar(peer: PacketPeerUDP, message: Dictionary) -> void:
	var dictionary: Dictionary = message
	if "user" in dictionary:
		var user = dictionary["user"]
		if dictionary["token"] == logged_users[user]:
			var avatar: String = fake_database[dictionary['user']]['avatar']
			var nickname: String = fake_database[dictionary['user']]['nickname']
			var response: Dictionary = {
				"avatar": avatar, "nickname": nickname
			}
			peer.put_var(JSON.stringify(response))
