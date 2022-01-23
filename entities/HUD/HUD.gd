extends Node2D

var time_left = 2 * 60 # total seconds
var time_template = '{minutes}:{seconds}'

signal on_btn_menu_pressed
signal on_match_finishes

func _ready():
	var has_error = $Timer.connect("timeout", self, "_on_Timer_timeout")
	if has_error != 0:
		print("ERROR found in HUD:", has_error)

func _on_Timer_timeout():
	if time_left == 0:
		emit_signal("on_match_finishes")
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

func _on_btnMenu_pressed():
	emit_signal("on_btn_menu_pressed")
