extends Node2D

signal goal

func setup_goal_area():
	$GoalArea2D.show()
	if $GoalArea2D.is_connected("body_entered", self, "_on_goal_area_entered"):
		self.hide_goal_area()
	var has_error = $GoalArea2D.connect("body_entered", self, '_on_goal_area_entered')
	if has_error != 0:
		print("ERROR found in Basket", has_error)

func _on_goal_area_entered(_area):
	emit_signal("goal")

func hide_goal_area():
	$GoalArea2D.hide()
	$GoalArea2D.disconnect("body_entered", self, '_on_goal_area_entered')
