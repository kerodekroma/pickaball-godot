extends Node #It's required because a global script should be always recognized as a node

var score = 0

func calculate_points():
	return 5

func generate_ball_position() -> Vector2:
	var ball_position = Vector2(720, 320)
	return ball_position
 
func generate_control_position(ball_position: Vector2) -> Vector2:
	# default values
	var control_position = Vector2(770, 310)
	return control_position
