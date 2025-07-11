extends Node2D

@export var move_speed: int = 20
@export var turn_speed: float = 20.0 # 转向速度，数值越大转得越快
@onready var label: Label = $Label

func _ready() -> void:
	set_multiplayer_authority(name.to_int())
	position = Vector2i(randi() % 500, randi() % 500)
	label.text=name
	if is_multiplayer_authority():
		play_effect.rpc(Color(randf(), randf(), randf()))

func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	if input.length() > 0:
		# 计算目标角度
		var target_angle = input.angle()+PI/2.0
		# 平滑转向
		rotation = lerp_angle(rotation, target_angle, turn_speed * delta)
		position += input * move_speed

func _unhandled_key_input(event: InputEvent) -> void:
	if not is_multiplayer_authority():
		return
	if event.is_action_pressed("move_sprint"):
		play_effect.rpc(Color(randf(), randf(), randf()))
		prints("sprint:",multiplayer.get_unique_id())

@rpc("authority","call_local")
func play_effect(c:Color):
	prints("effect=====")
	modulate = c
