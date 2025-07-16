@tool
extends Node3D
class_name MapItem

@export var item_resource: ItemResource : set = set_item_resource
var model_instance: Node3D

func set_item_resource(value: ItemResource):
	item_resource = value
	if item_resource and item_resource.model_scene:
		_create_model()

func _create_model():
	# 清除现有模型
	if model_instance:
		model_instance.queue_free()
	
	# 创建新模型
	if item_resource.model_scene:
		model_instance = item_resource.model_scene.instantiate()
		add_child(model_instance)
		
		# 设置碰撞
		if not item_resource.collision_enabled:
			_disable_collision(model_instance)

func _disable_collision(node: Node):
	if node is CollisionShape3D or node is CollisionObject3D:
		node.set_collision_layer_value(1, false)
		node.set_collision_mask_value(1, false)
	
	for child in node.get_children():
		_disable_collision(child)

func get_item_name() -> String:
	return item_resource.item_name if item_resource else "" 