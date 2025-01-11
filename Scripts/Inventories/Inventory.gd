extends Control

class_name Inventory

var inventory_data = [0,1,1,0,-1,-1,0,1,1]
@export var slots_parent : Control
var mouse_is_holding = false
var holded_item_slot = 0 # [(item data),(slot index)]
var item_sprite
func _ready() -> void:
	update()
	item_sprite = AtlasTexture.new()
	item_sprite.atlas = load("res://Sprites/Items.png")
	item_sprite.region.size = Vector2(16,16)

func update():
	var index = 0
	var item_datas = GameManager.item_data_base
	for slot in slots_parent.get_children():
		if inventory_data[index] != -1:
			slot.get_child(1).texture.region.position = item_datas[inventory_data[index]].item_sprite * 16
			slot.index = index
			slot.linked_inventory = self
			index += 1
		else:
			slot.get_child(1).texture.region.position = Vector2(-1,-1) * 16
			slot.index = index
			slot.linked_inventory = self
			index += 1

func _physics_process(delta: float) -> void:
	if mouse_is_holding and inventory_data[holded_item_slot] != -1 and Input.is_action_pressed("click0"):
		$CursorImage.visible = true
		$CursorImage.texture.region.position = GameManager.item_data_base[inventory_data[holded_item_slot]].item_sprite * 16
		$CursorImage.position = get_local_mouse_position() - Vector2(25,25)
	else:
		$CursorImage.visible = false
