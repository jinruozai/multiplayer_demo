extends Node

var net_peer:ENetMultiplayerPeer;

func create_server():
	prints("create server")
	if not net_peer:
		net_peer=ENetMultiplayerPeer.new()
	var err=net_peer.create_server(2025)
	if err!=OK:
		printerr("create server err:",err)
		return
	multiplayer.multiplayer_peer=net_peer
	multiplayer.peer_connected.connect(_on_peer_connected)

func join_server():
	if not net_peer:
		net_peer=ENetMultiplayerPeer.new()
	net_peer.create_client("127.0.0.1",2025)
	multiplayer.multiplayer_peer=net_peer

func _on_peer_connected(id:int):
	prints("peer connected:%d"%id)

@rpc("authority","call_local")
func start_game():
	prints("start")
	get_tree().change_scene_to_file("res://scene/scene.tscn")
