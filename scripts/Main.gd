extends Node2D

const ball = preload("res://entities/Ball/Ball.tscn")
const control = preload("res://entities/Control/Control.tscn")

var time_to_reload_when_it_fails = 3.8
var control_instance: Node
var ball_instance
var current_score = 0
var timer_reload_ball_and_control_instance: Timer

func _ready():
	$Basket.setup_goal_area()
	$Basket.connect("goal", self, "_on_basket_goal")
	create_ball()
	create_control()
	
func _on_Button_pressed():
	create_ball_and_control()

func create_ball():
	if ball_instance != null:
		remove_child(ball_instance)
	ball_instance = ball.instance()
	ball_instance.position = Globals.generate_ball_position()
	ball_instance.connect("ball_touched_ring", self, "_on_ball_touched_ring")
	add_child(ball_instance)

func create_control():
	if control_instance != null:
		remove_child(control_instance)
	control_instance = control.instance()
	# initial position in the 2d preview: 768, 310
	control_instance.position = Globals.generate_control_position(ball_instance.position)
	control_instance.connect("control_released", self, "_on_control_released")
	add_child(control_instance)

func create_reload_timer():
	if timer_reload_ball_and_control_instance != null:
		timer_reload_ball_and_control_instance.stop()
		remove_child(timer_reload_ball_and_control_instance)
	#create the timer to restart the ball & controls
	timer_reload_ball_and_control_instance = Timer.new()
	timer_reload_ball_and_control_instance.connect("timeout", self, "create_ball_and_control")
	timer_reload_ball_and_control_instance.autostart = true
	timer_reload_ball_and_control_instance.wait_time = time_to_reload_when_it_fails
	timer_reload_ball_and_control_instance.start()
	add_child(timer_reload_ball_and_control_instance)
	print("START TIMER")

func _on_control_released(direction):
	ball_instance.apply_torque_impulse(10000)
	ball_instance.apply_impulse(Vector2.ZERO, direction * -50)
	remove_child(control_instance)
	create_reload_timer()

func _on_ball_touched_ring():
	print("more time please!")
	ball_instance.apply_torque_impulse(-1)
	ball_instance.apply_central_impulse(Vector2(-1, -1))
	time_to_reload_when_it_fails += 0.4

func _on_basket_goal():
	current_score += Globals.calculate_points();
	var points = '0000'
	if current_score < 100:
		points = '00{current_score}'.format({"current_score": current_score})
	if current_score > 100:
		points = '0{current_score}'.format({"current_score": current_score})
	if current_score > 999:
		points = '{current_score}'.format({"current_score": current_score}) 
	$HUD/HBoxContainer/score.text = 'SCORE {points}'.format({"points": points})
	$Basket.hide_goal_area()

func create_ball_and_control():
	print("CREATE BALL!")
	create_ball()
	create_control()
	$Basket.setup_goal_area()
	timer_reload_ball_and_control_instance.stop()
