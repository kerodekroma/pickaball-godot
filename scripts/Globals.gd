extends Node #It's required because a global script should be always recognized as a node

var score = 0

# X: 
# 260px -> level 1
# 430px -> level 2
# 750px -> level 3

#Y:
#min -> 150
#max -> 400
const levels = [200, 260, 430, 750]
const min_y_range = 150
const max_y_range = 400
var current_level = 0

func calculate_points():
	return 10 * current_level

func build_rand_x_by_level(num_level):
	return rand_range(levels[num_level-1], levels[num_level])

func generate_ball_position() -> Vector2:
	current_level = int(rand_range(1, levels.size() - 1))
	print("current_level", current_level)
	var rand_x = build_rand_x_by_level(current_level)
	var rand_y = rand_range(min_y_range, max_y_range)
	# var ball_position = Vector2(720, 320)
	var ball_position = Vector2(rand_x, rand_y)
	return ball_position
 
func generate_control_position(ball_position: Vector2) -> Vector2:
	# default values
	#var control_position = Vector2(770, 310)
	var distance = 40
	var dis_x = distance + cos(30) + ball_position.x
	var dis_y = distance + sin(30) + ball_position.y
	var control_position = Vector2(dis_x, dis_y)
	return control_position
