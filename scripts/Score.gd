extends Node2D

signal on_score_play_again
signal on_score_go_main_menu

func _on_btnPlayAgain_pressed():
	emit_signal("on_score_play_again")

func _on_btnMainMenu_pressed():
	emit_signal("on_score_go_main_menu")
