extends Node2D

const ball = preload("res://entities/Ball/Ball.tscn")
const control = preload("res://entities/Control/Control.tscn")

var time_to_reload_when_it_fails = Globals.time_to_reload_when_it_fails
var control_instance: Node
var ball_instance: RigidBody2D
var current_score = 0
var timer_reload_ball_and_control_instance = Timer.new()
var is_ball_outside_the_screen = false

func _ready():
	$Basket.setup_goal_area()
	connect_with_basket_node()
	create_ball()
	create_control()

func _input(event):
	if event.is_action_pressed("ui_pause"):
		_on_HUD_on_btn_menu_pressed()
	
	if event.is_action_pressed("ui_cancel"):
		$PauseDialog.hide()

func _process(_delta):
	if ball_instance.position.x < -64 && !is_ball_outside_the_screen:
		is_ball_outside_the_screen = true
		create_reload_timer(0.1)
		print("OUTT", time_to_reload_when_it_fails)
	
	if ball_instance.position.x > -64 && is_ball_outside_the_screen:
		is_ball_outside_the_screen = false

func _on_Button_pressed():
	create_ball_and_control()

func connect_with_basket_node():
	if $Basket.is_connected("goal", self, "_on_basket_goal"):
		$Basket.disconnect("goal", self, "_on_basket_goal")
	var has_error = $Basket.connect("goal", self, "_on_basket_goal")
	if has_error != 0:
		print("ERROR found connecting the basket in main", has_error)

func create_ball():
	if ball_instance != null:
		remove_child(ball_instance)
	ball_instance = ball.instance()
	ball_instance.position = Globals.generate_ball_position()
	var has_error = ball_instance.connect("ball_touched_ring", self, "_on_ball_touched_ring")
	if has_error != 0:
		print("ERROR connecting with the ball_instance", has_error)
	add_child(ball_instance)

func create_control():
	control_instance = control.instance()
	# initial position in the 2d preview: 768, 310
	control_instance.position = Globals.generate_control_position(ball_instance.position)
	var has_error = control_instance.connect("control_released", self, "_on_control_released")
	if has_error != 0:
		print("ERROR connecting with the control", has_error)
	add_child(control_instance)

func create_reload_timer(value):
	# just connect once
	if not timer_reload_ball_and_control_instance.is_connected("timeout", self, "create_ball_and_control"):
		timer_reload_ball_and_control_instance.connect("timeout", self, "create_ball_and_control")
	
	timer_reload_ball_and_control_instance.add_to_group("timer_reloader")
	timer_reload_ball_and_control_instance.autostart = true
	timer_reload_ball_and_control_instance.wait_time = value
	
	#clean up all the nodes that belong to this group
	for node in get_tree().get_nodes_in_group("timer_reloader"):
		remove_child(node)

	add_child(timer_reload_ball_and_control_instance)
	timer_reload_ball_and_control_instance.start()
	print("START TIMER", value)

func _on_control_released(direction):
	ball_instance.apply_torque_impulse(10000)
	ball_instance.apply_impulse(Vector2.ZERO, direction * -50)
	remove_child(control_instance)
	create_reload_timer(time_to_reload_when_it_fails)

func _on_ball_touched_ring():
	print("more time please!")
	ball_instance.apply_torque_impulse(-1)
	ball_instance.apply_central_impulse(Vector2(-1, -1))
	time_to_reload_when_it_fails += 0.4
	create_reload_timer(time_to_reload_when_it_fails)

func _on_basket_goal():
	print("GOAL!")
	current_score += Globals.calculate_points();
	var points = Globals.format_score(current_score)
	$HUD/HBoxContainer/score.text = 'SCORE {points}'.format({"points": points})
	$Basket.hide_goal_area()

func create_ball_and_control():
	print("CREATE BALL!")
	create_ball()
	create_control()
	$Basket.setup_goal_area()
	connect_with_basket_node()
	timer_reload_ball_and_control_instance.stop()
	time_to_reload_when_it_fails = Globals.time_to_reload_when_it_fails

func _on_HUD_on_btn_menu_pressed():
	# useful info: https://docs.godotengine.org/en/3.4/tutorials/scripting/pausing_games.html#pause
	$PauseDialog.show()
	get_tree().paused = true

func _on_PauseDialog_on_resume_pressed():
	$PauseDialog.hide()
	get_tree().paused = false

func _on_PauseDialog_on_reset_double_check_ok_pressed():
	var result = get_tree().reload_current_scene()
	print("_on_PauseDialog_on_reset_double_check_ok_pressed: result", result)
	get_tree().paused = false

func _on_PauseDialog_on_main_menu_pressed():
	get_tree().paused = false
	Globals.go_to_main_menu()

func _on_HUD_on_match_finishes():
	get_tree().paused = true
	Globals.save_record(current_score)
	$ScoreDialog/WrapperPoints/lblScore.text = Globals.format_score(current_score)
	$ScoreDialog.show()

func _on_ScoreDialog_on_score_go_main_menu():
	get_tree().paused = false
	Globals.go_to_main_menu()

func _on_ScoreDialog_on_score_play_again():
	var result = get_tree().reload_current_scene()
	print("_on_ScoreDialog_on_score_play_again: result", result)
	get_tree().paused = false
