extends Node3D

@onready var dEnemy := $DungeonEnemy
@onready var dPlayer := $DungeonPlayer

var my_party: Party
#var enemy_party : Party
var le_battle
var enemy_ahead : bool
var focused : bool
var my_parent #red flag. todo signal up whatever that means


# Called when the node enters the scene tree for the first time.
func _ready():
	focused = true
	enemy_ahead = false
	dPlayer.set_dungeon(self)
	le_battle = load("res://tscn/battle.tscn")
	#enemies = Party


func _physics_process(delta):
	if dEnemy.position != dPlayer.position: 
		dEnemy.look_at(dPlayer.position)
	pass

func _process(delta):
	pass

func set_parent(p):
	my_parent = p
	
func set_party(playerparty:Party):
	my_party = playerparty

#func set_enemy_party(enemies : Party):
#	enemy_party = enemies

func start_battle(enemyParty):
	var battle_instance = le_battle.instantiate()
	battle_instance.setParty(my_party)
	battle_instance.setEnemyParty(enemyParty)
	battle_instance.loadGUI()
	focused = false
	add_child(battle_instance)

func _input(event):
	if event.is_action_released("my_esc") and focused:
		print("my_esc pressed")
		my_parent.set_focused()
		queue_free()
	#if event.is_action_pressed("ui_up") and enemy_ahead:
	#	start_battle()
		
