extends Node
class_name Adapter

@export var block_scene : PackedScene
@export var player : PackedScene
@export var coin_scene : PackedScene

func data_to_block(data : Dictionary) -> Block:
	var block = block_scene.instantiate()
	block.position.x = data.get("position.x")
	block.position.y = data.get("position.y")
	block.position.z = data.get("position.z")
	return block

func block_to_data(block : Block) -> Dictionary:
	var data = {
		"element" : "Block",
		"position.x": block.position.x,
		"position.y": block.position.y,
		"position.z": block.position.z,
	}
	return data

func data_to_coin(data : Dictionary) -> Coin:
	var coin = coin_scene.instantiate()
	print(data)
	return coin

func coin_to_data(coin : Coin) -> Dictionary:
	var data = {
		"element" : "Coin",
		"position.x": coin.position.x,
		"position.y": coin.position.y,
		"position.z": coin.position.z,
	}
	return data

func data_to_player(data : Dictionary) -> Vector3:
	var pos = Vector3.ZERO
	pos.x = data.get("position.x")
	pos.y = data.get("position.y")
	pos.z = data.get("position.z")
	return pos

func player_to_data(player : Node3D) -> Dictionary:
	var data = {
		"element" : "Player",
		"position.x": player.position.x,
		"position.y": player.position.y,
		"position.z": player.position.z,
	}
	return data
