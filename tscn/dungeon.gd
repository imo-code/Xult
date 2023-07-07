extends Node3D

var my_party: Party
var enemy_party : Party
var le_battle
var enemy_ahead : bool
var focused : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	focused = true
	enemy_ahead = true
	le_battle = load("res://tscn/battle.tscn")
	#enemies = Party
	pass # Replace with function body.

func setParty(playerparty:Party):
	my_party = playerparty

func setEnemyParty(enemies : Party):
	enemy_party = enemies

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel") and focused:
		print("ui_cancel pressed")
		queue_free()
	if event.is_action_pressed("ui_up") and enemy_ahead:
		var battle_instance = le_battle.instantiate()
		battle_instance.setParty(my_party)
		battle_instance.setEnemyParty(enemy_party)
		battle_instance.loadGUI()
		focused = false
		add_child(battle_instance)
		
