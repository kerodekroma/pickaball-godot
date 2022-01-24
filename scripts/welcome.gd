extends Node

func start_game():
	var result = get_tree().change_scene("res://scenes/Main.tscn")
	if result != OK:
		print ("An unexpected error occured when trying to switch to Main.tscn")
	
func _on_btnHallOfFame_pressed():
	var result = get_tree().change_scene("res://scenes/HallOfFame.tscn")
	if result != OK:
		print ("An unexpected error occured when trying to switch to HallOfFame.tscn")	
