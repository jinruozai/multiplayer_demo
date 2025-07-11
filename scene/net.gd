class_name Com_Scene_Net
extends Node

@export var net_scene:Node=null
var net_peer:ENetMultiplayerPeer;
const ACTOR = preload("uid://b6q7ehw4n6sul")

func _ready() -> void:
	g_event.eve_scene_create_server.connect(create_server)
	g_event.eve_scene_join_server.connect(join_server)

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
	add_player(multiplayer.get_unique_id())

func join_server():
	if not net_peer:
		net_peer=ENetMultiplayerPeer.new()
	net_peer.create_client("127.0.0.1",2025)
	multiplayer.multiplayer_peer=net_peer

func _on_peer_connected(id:int):
	prints("peer connected:%d"%id)
	add_player(id)
	
func add_player(id:int):
	var scene=get_scene()
	var actor=ACTOR.instantiate()
	actor.name="%d"%id
	scene.add_child(actor)

func get_scene():
	if net_scene:
		return net_scene
	return get_parent()
