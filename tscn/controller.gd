extends Node2D

#var le_battle
var le_dungeon
var my_party : Party
var focused : bool



# Called when the node enters the scene tree for the first time.
func _ready():
#	le_battle = load("res://tscn/battle.tscn")
	le_dungeon = load("res://tscn/dungeon.tscn")
	my_party = load("res://resources/my_party.tres")
	focused = true
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_to_dungeon_pressed():
	var dungeon_instance = le_dungeon.instantiate()
	dungeon_instance.setParty(my_party)
	add_child(dungeon_instance)
	focused = false
	#get_tree().root.add_child(dungeon_instance)
	#visible = false


func _on_button_to_battle_pressed():
#	var battle_instance = le_battle.instantiate()
#	add_child(battle_instance)
	pass	


func _on_button_to_party_pressed():
	var texL = my_party.left.tex
	var texM = my_party.mid.tex
	var texR = my_party.right.tex
	var trl = get_node("Node2DMenu/TabContainer/TabBar/TextureRect_Left")
	trl.set_texture(texL)
	var trm = get_node("Node2DMenu/TabContainer/TabBar2/TextureRect_Mid")
	trm.set_texture(texM)
	var trr = get_node("Node2DMenu/TabContainer/TabBar3/TextureRect_Right")
	trr.set_texture(texR)
	
	
	get_node("Node2DMenu/TabContainer").visible = !get_node("Node2DMenu/TabContainer").visible
	
	pass # Replace with function body.
