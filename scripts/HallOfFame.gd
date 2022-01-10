extends Node2D

func _ready():
	#var test_record_data = {"records": [0,0,0]}
	#test_record_data.records[0] = 100
	#var stringifiedData = JSON.print(test_record_data)
	#Globals.save_record(stringifiedData)
	Globals.load_records()

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/welcome.tscn")
