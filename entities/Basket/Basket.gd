extends Node2D

signal goal

func setup_goal_area():
	$GoalArea2D.show()
	$GoalArea2D.connect("body_entered", self, '_on_goal_area_entered')
	
func _on_goal_area_entered(area):
	emit_signal("goal")

func hide_goal_area():
	$GoalArea2D.hide()
	$GoalArea2D.disconnect("body_entered", self, '_on_goal_area_entered')
