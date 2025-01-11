extends Object

class_name Room

var rect : Rect2
var result_list = []
var childs = []
var is_horizental = true


const MIN_ROOM_SIZE = 0.3
const ROOM_DECREASE = 0.7

func _init(rect:Rect2,is_horizental:bool) -> void:
	self.rect = rect
	self.is_horizental = is_horizental
	
func Divide_Repeat(count:int):
	
	result_list.append([self])
	print(result_list)
	for level in range(count):
		var new_result = []
		for room in result_list[level]:
			new_result.append_array(room.Divide())
			
		result_list.append(new_result)
	
	for last_room in result_list[-1]:
		last_room.rect.size *= ROOM_DECREASE + randf_range(-0.2,0.2)
	
	return result_list[-1]
	result_list.clear()

func Divide():
	
	var new_result = []
	
	var axis = (Vector2(1,0) if is_horizental else Vector2(0,1))
	
	var axis_size = (rect.size.x if axis.x == 1 else rect.size.y)
	var point = randf_range(axis_size * MIN_ROOM_SIZE,axis_size - axis_size * MIN_ROOM_SIZE)
	
	var first_room = Room.new(Rect2(rect.position,rect.size - (axis * (axis_size - point))),not is_horizental)
	var second_room = Room.new(Rect2(rect.position + (axis * point),rect.size - (axis * point)),not is_horizental)
	
	new_result.append(first_room)
	new_result.append(second_room)
	
	return new_result
func get_center():
	return rect.position + (rect.size / 2)
