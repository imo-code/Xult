extends Node3D

var le_battle
var enemy_ahead : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_ahead = true
	le_battle = load("res://tscn/battle.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		print("ui_cancel pressed")
		queue_free()
	if event.is_action_pressed("ui_up") and enemy_ahead:
		var battle_instance = le_battle.instantiate()
		add_child(battle_instance)
		
