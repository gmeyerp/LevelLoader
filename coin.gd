extends CollisionObject3D
class_name Coin

@export var value : int

func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		queue_free()
