extends Node2D

var time_left = 2 * 60 # total seconds
var time_template = '{minutes}:{seconds}'

func _ready():
	$Timer.connect("timeout", self, "_on_Timer_timeout")

func _on_Timer_timeout():
	if time_left == 0:
		print("done!")
	if time_left > 0:
		time_left -= 1
		$HBoxContainer/timeout.text = time_template.format({
			"minutes": number_to_str(time_left/60),
			"seconds": number_to_str(time_left%60)
		})

func number_to_str(value: float):
	if value < 10:
		return '0%s' % value
	return '%s' % value
