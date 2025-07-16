@tool
extends Resource
class_name ItemResource

@export var item_name: String = ""
@export var icon: Texture2D
@export var model_scene: PackedScene  # 3D模型场景
@export var description: String = ""
@export var item_type: String = ""
@export var properties: Dictionary = {}

@export var is_placeable: bool = true
@export var collision_enabled: bool = true
@export var interaction_enabled: bool = false 
