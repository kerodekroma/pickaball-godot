extends Node

signal on_resume_pressed
signal on_reset_double_check_ok_pressed
signal on_main_menu_pressed

func _on_btnResume_pressed():
	emit_signal("on_resume_pressed")

func _on_btnReset_pressed():
	$FirstMenu.hide()
	$DoubleCheck.show()

func _on_btnOK_double_check_pressed():
	emit_signal("on_reset_double_check_ok_pressed")

func _on_btnNO_pressed():
	$FirstMenu.show()
	$DoubleCheck.hide()

func _on_btnMainMenu_pressed():
	emit_signal("on_main_menu_pressed")
