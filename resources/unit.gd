extends Resource
class_name Unit

@export var title:  String
@export var max_hp: int
@export var c_hp:   int
@export var manah:  int
@export var tags: 	Array
@export var spells: Array
@export var actions: Array
@export var tex : CompressedTexture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	
func get_tags():
	return tags
	
func get_spells():
	return spells
	
func get_max_hp():
	return max_hp

func get_current_hp():
	return c_hp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	


