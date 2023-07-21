extends Node3D

const TRAVEL_TIME := .2

@onready var frontRay := $FrontRayCast
@onready var backRay := $BackRayCast

var forward : Vector3 
var tween

func _ready():
	forward = Vector3.FORWARD
	print(frontRay.is_colliding())

func _physics_process(delta):
	if tween:
		if tween.is_running():
			return
	if (Input.is_action_just_pressed("my_up") or Input.is_action_just_pressed("my_w")) and not frontRay.is_colliding():
		print("up")
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated(forward * 2), TRAVEL_TIME)
	if (Input.is_action_just_pressed("my_down") or Input.is_action_just_pressed("my_s")) and not backRay.is_colliding():
		print("down")
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated(forward * 2), TRAVEL_TIME)
	if Input.is_action_just_pressed("my_a") or Input.is_action_just_pressed("my_left"):
		print("left")
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "rotation:y", self.rotation.y + PI/2, TRAVEL_TIME)
		forward = forward.rotated(Vector3.UP, PI/2)
	if Input.is_action_just_pressed("my_d") or Input.is_action_just_pressed("my_right"):
		print("right")
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "rotation:y", self.rotation.y - PI/2, TRAVEL_TIME)
		forward = forward.rotated(Vector3.UP, -PI/2)
	print(frontRay.is_colliding())
