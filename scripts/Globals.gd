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
const time_to_reload_when_it_fails = 3.8 # milliseconds

# var record_data = {"records": []} 
var file_name = "user://pick_a_ball_records.txt"

func load_data():
	var data_file = File.new()
	var default_content = {"records":[]}
	if not data_file.file_exists(file_name):
		return default_content
	# read the file line by line
	data_file.open(file_name, File.READ)
	var content = data_file.get_as_text()
	data_file.close()
	if content.length() < 1:
		return default_content
	return parse_json(content)

func save_record(value):
	var data_to_save = load_data()
	var data_file = File.new()
	data_file.open(file_name, File.WRITE)
	data_to_save["records"].append(value)
	data_to_save["records"].sort_custom(self, "ascendant_sort")
	data_to_save["records"] = data_to_save["records"].slice(0, 2)
	data_file.store_string(to_json(data_to_save))
	data_file.close()
	
func ascendant_sort(a, b):
	return a > b

func clear_record():
	var dir = Directory.new()
	dir.remove(file_name)

func calculate_points():
	return 10 * current_level

func format_score(value: int) -> String: 
	var points = '0000'
	if value < 100:
		points = '00{value}'.format({"value": value})
	if value >= 100:
		points = '0{value}'.format({"value": value})
	if value > 999:
		points = '{value}'.format({"value": value}) 
	return points

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
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/welcome.tscn")
