extends Node3D

@export var player : Node3D
@export var url : String
@onready var adapter: Adapter = $Adapter
@export var data_to_save : Array[Dictionary]
@onready var level: StaticBody3D = $Level
@onready var json_request: HTTPRequest = $JsonRequest

const PATH: String = "user://"
var file_name: String = "level.res"

func _ready() -> void:
	json_request.request_completed.connect(on_request_completed)

func on_request_completed(result, _response_code, _header, body) -> void:
	print("Request completed")
	if result != 0:
		print("Error")
	else:
		print(body.get_string_from_utf8())
		load_level(body.get_string_from_utf8())

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		save_level()
	if event.is_action_pressed("ui_cancel"):
		json_request.request(url)

func load_level(json_string : String) -> void:
	clear_level()
	var save_file = FileAccess.open("user://savegame.json", FileAccess.READ)
	json_string = save_file.get_line()
	
	
	var data_array = decode_json(json_string)
	
	for d in data_array:
		var element = d.get("element")
		if not element:
			print("Not element")
			continue
		if element == "Block":
			level.add_child(adapter.data_to_block(d))
		elif element == "Coin":
			level.add_child(adapter.data_to_coin(d))
		elif element == "Player":
			player.position = adapter.data_to_player(d)
		elif element == "Tree":
			level.add_child(adapter.data_to_tree(d))

func decode_json(json_string : String):
	var json = JSON.new()
	var error = json.parse(json_string)
	if error == OK:
		var data_received = json.data
		return data_received
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return []

func save_level() -> void:
	data_to_save = []
	var level_elements := level.get_children()
	for e in level_elements:
		if e is Block:
			data_to_save.append(adapter.block_to_data(e))
		elif e is Coin:
			data_to_save.append(adapter.coin_to_data(e))
		elif e is TreeBlock:
			data_to_save.append(adapter.tree_to_data(e))
	data_to_save.append(adapter.player_to_data(player))
	var json = JSON.stringify(data_to_save)
	var save_file = FileAccess.open("user://savegame.json", FileAccess.WRITE)
	save_file.store_string(json)

func clear_level() -> void:
	var level_elements := level.get_children()
	for e in level_elements:
		if e is Block or e is Coin or e is TreeBlock:
			e.queue_free()

func create_block():
	pass
