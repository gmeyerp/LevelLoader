extends Resource
class_name PlayerData

@export var position: Vector3

func _init(p_position = Vector3.ZERO) -> void:
	position = p_position
