extends Node2D

#var le_battle
var le_dungeon
var my_party : Party
var enemy_party : Party 
var focused : bool



# Called when the node enters the scene tree for the first time.
func _ready():
#	le_battle = load("res://tscn/battle.tscn")
	le_dungeon = load("res://tscn/dungeon.tscn")
	my_party = load("res://resources/my_party.tres")
	enemy_party = load("res://resources/enemies_example.tres")
	focused = true
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#check here if dungeon is done
	if not le_dungeon:
		focused = true
	pass
	
func spawn_dungeon():
	var dungeon_instance = le_dungeon.instantiate()
	dungeon_instance.set_party(my_party)
	#dungeon_instance.set_enemy_party(enemy_party)
	dungeon_instance.set_parent(self) #red flag. todo signal up whatever that means
	add_child(dungeon_instance)
	focused = false
	#visible = false

func _input(event):
	if event.is_action_pressed("my_up") or event.is_action_pressed("my_w"):
		if focused:
			spawn_dungeon()
	if event.is_action_pressed("my_esc") and focused:
		print("my_esc pressed")
		get_tree().quit()

func set_focused():
	focused = true
	print("set focused")

func _on_button_to_dungeon_pressed():
	spawn_dungeon()
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
