extends StaticBody3D

@export var cube : PackedScene
@export var coin : PackedScene


func _on_input_event(_camera: Node, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var instance
		if event.button_index == 1:
			instance = cube.instantiate()
			instance.name = "Block"
		elif event.button_index == 2:
			instance = coin.instantiate()
			instance.name = "Coin"
		else:
			return
		var pos = event_position
		pos.x = round(pos.x)
		pos.y = round(0)
		pos.z = round(pos.z)
		add_child(instance)
		instance.position = pos
