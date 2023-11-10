extends Resource
class_name UnitData

@export var name : String
@export_range(1, 100) var health : int
@export_range(1, 100) var attack : int
@export_range(1, 5) var tier : int
@export_range(1, 100) var buy : int
@export_range(1, 100) var sell : int
@export var texture : Texture2D
