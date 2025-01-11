extends Control

var index = 0
var linked_inventory:Inventory

func _physics_process(delta: float) -> void:
	if(Input.is_action_just_released("click0")):
		if Rect2(Vector2(), size).has_point(get_local_mouse_position()) and linked_inventory.mouse_is_holding:
			var inventory_data = linked_inventory.inventory_data
			var this_item = inventory_data[index]
			
			if inventory_data[linked_inventory.holded_item_slot] == inventory_data[index]:
				print("same")
				linked_inventory.update()
			else:
				inventory_data[index] = inventory_data[linked_inventory.holded_item_slot]
				inventory_data[linked_inventory.holded_item_slot] = this_item
				linked_inventory.update()
			linked_inventory.mouse_is_holding = false
		linked_inventory.update()
func _on_button_button_down() -> void:
	if linked_inventory.inventory_data[index] != -1:
		linked_inventory.holded_item_slot = index
		linked_inventory.mouse_is_holding = true
		get_child(1).texture.region.position = Vector2(-16,-16)
func _ready() -> void:
	get_child(1).texture = AtlasTexture.new()
	get_child(1).texture.atlas = load("res://Sprites/Items.png")
	get_child(1).texture.region.size = Vector2(16,16)
