extends Node2D

const tiles = { WALL = Vector2i(1,0), FLOOR = Vector2i(0,1), SIDE_WALL = Vector2i(0,0)}
var room_list = []
var origin_room : Room

@export var road_width = 0
@export var barrier_size = 0
@export var map_size :Vector2i
@export var divide_count = 0
@export var debug = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Make_TileMap():
	
	Make_Rect(origin_room.rect,tiles.WALL)
	
	var index = 0
	for room in room_list:
		Make_Rect(room.rect,tiles.FLOOR)
		if index < room_list.size() - 1:
			Link_Line(Vector2i(room.get_center()),Vector2i(room_list[index + 1].get_center()),road_width)
			
		index += 1
	Make_Wall()
	#limit_right
	GameManager.player.get_node("Camera2D").limit_right = map_size.x * 16
	GameManager.player.get_node("Camera2D").limit_bottom = map_size.y * 16

func _draw() -> void:
	if debug:
		for room in room_list:
			draw_rect(room.rect,Color.WEB_MAROON)
			
func Make_New():
	
	origin_room = Room.new(Rect2(Vector2.ZERO,map_size),true)
	var first_room = Room.new(Rect2(Vector2.ZERO,Vector2.ZERO),true)
	first_room.rect.size = origin_room.rect.size - Vector2(barrier_size,barrier_size) * 2
	first_room.rect.position = origin_room.rect.position + Vector2(barrier_size,barrier_size)
	room_list = first_room.Divide_Repeat(divide_count)
func Link_Line(start:Vector2i,finish:Vector2i,width:int):
	
	var offset = start
	while not offset == finish:
		for x in range(-width,width):
			for y in range(-width,width):
				GameManager.tilemap_main.set_cell(offset + Vector2i(x,y),2,tiles.FLOOR)
		offset.x += (1 if offset.x < finish.x else (0 if offset.x == finish.x else -1))
		offset.y += (1 if offset.y < finish.y else (0 if offset.y == finish.y else -1))
func Make_Rect(rect:Rect2,tile:Vector2i):
	var size_i = Vector2i(rect.size)
	var position_i = Vector2i(rect.position)
	
	for x in range(size_i.x):
		for y in range(size_i.y):
			
			GameManager.tilemap_main.set_cell(position_i + Vector2i(x,y),2,tile)
	
func Find_Spawn():
	return room_list[0].get_center() * 16

func Make_Wall():

	for x in range(origin_room.rect.size.x):
		for y in range(origin_room.rect.size.y):
			var tile_atlas = GameManager.tilemap_main.get_cell_atlas_coords(Vector2i(x,y))
			if tile_atlas == tiles.WALL:
				var near_tile = GameManager.tilemap_main.get_cell_atlas_coords(Vector2i(x,y+1))
				if near_tile == tiles.FLOOR:
					GameManager.tilemap_main.set_cell(Vector2i(x,y),2,tiles.SIDE_WALL)
