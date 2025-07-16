extends Node2D

@export var move_speed: int = 20
@export var turn_speed: float = 20.0 # 转向速度，数值越大转得越快
@onready var label: Label = $Label

const BULLET = preload("uid://dr67br7n7128t")

func _ready() -> void:
	position = Vector2i(randi() % 500, randi() % 500)
	label.text=name

func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	if input.length() > 0:
		# 计算目标角度
		var target_angle = input.angle()+PI/2.0
		syn_pos_rot.rpc(position+input * move_speed,lerp_angle(rotation, target_angle, turn_speed * delta))

func _unhandled_key_input(event: InputEvent) -> void:
	if not is_multiplayer_authority():
		return
	if event.is_action_pressed("move_sprint"):
		play_effect.rpc(Color(randf(), randf(), randf()),true)
		prints("sprint:",multiplayer.get_unique_id())

@rpc("authority","call_local")
func syn_pos_rot(pos:Vector2,rot:float):
	position=pos
	rotation=rot

@rpc("authority","call_local")
func play_effect(c:Color,shoot:bool=false):
	prints("effect=====")
	modulate = c
	var bullet=BULLET.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position=global_position
