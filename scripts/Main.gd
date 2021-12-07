extends Node2D

const ball = preload("res://entities/Ball/Ball.tscn")

var ball_control: Node2D
var ball_instance:RigidBody2D

func _ready():
	$Control.connect("control_released", self, "_on_control_released")
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
