extends CanvasLayer

@onready var label: Label = $HBoxContainer/Label

func _ready() -> void:
	update_status()
	multiplayer.peer_connected.connect(_on_peer_connected)
	
func _on_peer_connected(id:int):
	update_status()

func update_status():
	var peers=multiplayer.get_peers()
	peers.insert(0,multiplayer.get_unique_id())
	var s="房间人数:%d"%peers.size()
	for peer in peers:
		s=s+"\r\n"+"player_%d"%peer
	label.text=s

func _on_create_btn_pressed() -> void:
	g_net.create_server()


func _on_join_btn_pressed() -> void:
	g_net.join_server()


func _on_start_btn_pressed() -> void:
	g_net.start_game.rpc()
