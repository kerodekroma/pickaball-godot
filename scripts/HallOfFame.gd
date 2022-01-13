extends Node2D

var data = []

func _ready():
	data = Globals.load_data()
	print_scores(data.records)

func print_scores(record_data: Array):
	if record_data.size() < 1:
		$VBoxContainer/lblPlaceholder.show()
		return
	$VBoxContainer/lblPlaceholder.hide()
	record_data.sort()
	for value in record_data:
		var label_instance = Label.new()
		label_instance.text = "{value} Pts".format({
			"value": value
		})
		label_instance.add_to_group("scores")
		$VBoxContainer.add_child(label_instance)
		$VBoxContainer.move_child(label_instance, 0)

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/welcome.tscn")

func _on_Button2_pressed():
	Globals.clear_record()
	for item in $VBoxContainer.get_children():
		if item.is_in_group("scores"):
			$VBoxContainer.remove_child(item)
	$VBoxContainer/lblPlaceholder.show()
