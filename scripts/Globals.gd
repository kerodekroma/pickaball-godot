extends Node #It's required because a global script should be always recognized as a node

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

var record_data = {"records": ["","",""]} 
var file_name = "user://pick_a_ball_records"

func load_records():
	var data_file = File.new()
	if not data_file.file_exists(file_name):
		print("file not found, saving an empty file..")
		save_record("")
	# read the file line by line
	data_file.open(file_name, File.READ)
	while data_file.get_position() < data_file.get_len():
		var node_data = parse_json(data_file.get_line())
		print("node_data", node_data.records[0])

func save_record(value):
	var data_file = File.new()
	data_file.open(file_name, File.WRITE)
	var content = value;
	data_file.store_string(content)
	data_file.close()

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

func go_to_main_menu():
	get_tree().change_scene("res://scenes/welcome.tscn")
