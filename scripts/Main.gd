extends Node2D

const ball = preload("res://entities/Ball/Ball.tscn")
const control = preload("res://entities/Control/Control.tscn")

var control_instance: Node
var ball_instance:RigidBody2D
var current_score = 0

func _ready():
	$Basket.connect("goal", self, "_on_basket_goal")
	create_ball()
	create_control()

func _on_Button_pressed():
	create_ball()
	create_control()

func create_ball():
	if ball_instance != null:
		remove_child(ball_instance)
	ball_instance = ball.instance()
	ball_instance.position = Vector2(720, 320)
	add_child(ball_instance)

func create_control():
	control_instance = control.instance()
	# initial position in the 2d preview: 768, 310
	control_instance.position = Vector2(770, 310)
	control_instance.connect("control_released", self, "_on_control_released")
	add_child(control_instance)

func _on_control_released(direction):
	print("direction", direction)
	ball_instance.apply_torque_impulse(1000)
	ball_instance.apply_impulse(Vector2.ZERO, direction * -8)
	remove_child(control_instance)

func _on_basket_goal():
	current_score += Globals.calculate_points();
	$HUD/HBoxContainer/score.text = 'SCORE {points}'.format({"points": current_score})
