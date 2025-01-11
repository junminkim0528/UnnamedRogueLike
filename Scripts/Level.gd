extends Node

func _ready() -> void:
	GameManager.tilemap_main = $TileMapLayer_Main
	$DungeonMaker.Make_New()
	$DungeonMaker.Make_TileMap()
	$Player.position = $DungeonMaker.Find_Spawn()
	$Goblin.position = $DungeonMaker.Find_Spawn()
