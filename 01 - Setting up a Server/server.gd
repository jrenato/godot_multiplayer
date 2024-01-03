extends Node2D

const PORT: int = 9999

var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()


func _ready() -> void:
	var error: Error = peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connect)


func _on_peer_connect(peer_id) -> void:
	print(peer_id)
