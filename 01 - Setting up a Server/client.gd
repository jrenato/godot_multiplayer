extends Node2D

const SERVER_ADDRESS: String = "localhost"
const SERVER_PORT: int = 9999

var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()


func _ready() -> void:
	peer.create_client(SERVER_ADDRESS, SERVER_PORT)
	multiplayer.multiplayer_peer = peer
