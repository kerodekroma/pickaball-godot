extends Node2D

const ball = preload("res://entities/Ball/Ball.tscn")

var ball_control: Node2D
var ball_instance:RigidBody2D
var current_score = 0

func _ready():
	$Control.connect("control_released", self, "_on_control_released")
	$Basket.connect("goal", self, "_on_basket_goal")
	create_ball()

func _on_Button_pressed():
	create_ball()

func create_ball():
	if ball_instance != null:
		ball_instance.queue_free()
	ball_instance = ball.instance()
	ball_instance.position = Vector2(520, 170)
	add_child(ball_instance)

func _on_control_released(direction):
	print("direction", direction)
	ball_instance.apply_torque_impulse(7000)
	ball_instance.apply_impulse(Vector2.ZERO, direction * -3)

func _on_basket_goal():
	current_score += Globals.calculate_points();
	$HUD/HBoxContainer/score.text = 'SCORE {points}'.format({"points": current_score})
