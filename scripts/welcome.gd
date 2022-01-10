extends Node

func start_game():
	get_tree().change_scene("res://scenes/Main.tscn")

func _on_btnHallOfFame_pressed():
	get_tree().change_scene("res://scenes/HallOfFame.tscn")
