extends Node3D

const TRAVEL_TIME := .2

@onready var frontRay := $FrontRayCast
@onready var backRay := $BackRayCast
@onready var leftRay := $LeftRayCast
@onready var rightRay := $RightRayCast
@onready var body := $RigidBody3D

var my_dungeon
var forward : Vector3 
var tween

func _ready():
	forward = Vector3.FORWARD
	print(frontRay.is_colliding())

func _physics_process(delta):
	if tween:
		if tween.is_running():
			return
	#simple movement
	movement()
	#print("front_collide:" + str(frontRay.is_colliding()))
	
	###collides with objects
	if (Input.is_action_just_pressed("my_up") or Input.is_action_just_pressed("my_w")) and frontRay.is_colliding():
		var obj = frontRay.get_collider() 
		if obj.is_in_group("enemy"):
			var dEnemy = obj.get_parent_node_3d()
			print("found an enemy! enemy party led by " + dEnemy.get_party().mid.title)
			tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			tween.tween_property(self, "transform", transform.translated(forward * 2), TRAVEL_TIME)
			my_dungeon.start_battle(dEnemy.get_party())
		#obj.massprint(obj.mass)
		#if obj.layer:
		#	tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		#	tween.tween_property(self, "transform", transform.translated(forward * 2), TRAVEL_TIME)
	
	
func movement():
	if (Input.is_action_just_pressed("my_up") or Input.is_action_just_pressed("my_w")) and not frontRay.is_colliding():
#		print("up")
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated(forward * 2), TRAVEL_TIME)
	if (Input.is_action_just_pressed("my_down") or Input.is_action_just_pressed("my_s")) and not backRay.is_colliding():
#		print("down")
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated(- forward * 2), TRAVEL_TIME)
	if Input.is_action_just_pressed("my_q") and not leftRay.is_colliding():
#		print("q")
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		var left = forward.rotated(Vector3.UP, PI/2)
		tween.tween_property(self, "transform", transform.translated(left *2), TRAVEL_TIME)
	if Input.is_action_just_pressed("my_e") and not rightRay.is_colliding():
#		print("e")
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		var right = forward.rotated(Vector3.UP, -PI/2)
		tween.tween_property(self, "transform", transform.translated(right *2), TRAVEL_TIME)	
	if Input.is_action_just_pressed("my_a") or Input.is_action_just_pressed("my_left"):
#		print("left")
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "rotation:y", self.rotation.y + PI/2, TRAVEL_TIME)
		forward = forward.rotated(Vector3.UP, PI/2)
	if Input.is_action_just_pressed("my_d") or Input.is_action_just_pressed("my_right"):
#		print("right")
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "rotation:y", self.rotation.y - PI/2, TRAVEL_TIME)
		forward = forward.rotated(Vector3.UP, -PI/2)
	body.move_and_collide(Vector3(0,0,0))

func set_dungeon(d):
	my_dungeon = d
