extends Node2D


const ACTOR = preload("uid://b6q7ehw4n6sul")

func _ready() -> void:
	prints("multiplayer.is_server():",multiplayer.is_server())
	var peers=multiplayer.get_peers()
	peers.insert(0,multiplayer.get_unique_id())
	for peer in peers:
		add_player(peer)
	multiplayer.peer_connected.connect(add_player)
		
func add_player(id:int):
	var pactor=ACTOR.instantiate()
	pactor.name="player_%d"%id
	pactor.set_multiplayer_authority(id)
	add_child(pactor)
	pactor.position=Vector2(randf_range(100,500),randf_range(100,500))
	prints(pactor.position)
