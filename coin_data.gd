extends Resource
class_name CoinData

@export var position: Vector3
@export var value: int

func _init(p_position = Vector3.ZERO, p_value = 5) -> void:
	position = p_position
	value = p_value
