extends Node

var tilemap_main : Node
var player :Node
var item_data_base = []

func _enter_tree() -> void:
	register_item()

func register_item():
	item_data_base.append(ItemData.new("apple",Vector2i(1,0)))
	item_data_base.append(ItemData.new("mushiroom",Vector2i(1,1)))
