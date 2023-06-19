extends Node2D

var le_battle
var le_dungeon

# Called when the node enters the scene tree for the first time.
func _ready():
	le_battle = load("res://tscn/battle.tscn")
	le_dungeon = load("res://tscn/dungeon.tscn")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_to_dungeon_pressed():
	var dungeon_instance = le_dungeon.instantiate()
	add_child(dungeon_instance)
	#get_tree().root.add_child(dungeon_instance)
	#visible = false


func _on_button_to_battle_pressed():
	var battle_instance = le_battle.instantiate()
	add_child(battle_instance)
	
