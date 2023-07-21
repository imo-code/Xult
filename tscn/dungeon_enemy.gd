extends Node3D

@export var enemy_party : Party
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func is_enemy():
	return true
	
func get_party():
	return enemy_party


