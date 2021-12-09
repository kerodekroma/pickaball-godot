extends Node2D

signal goal

func _ready():
	$GoalArea2D.connect("body_entered", self, '_on_goal_area_entered')
	
func _on_goal_area_entered(area):
	emit_signal("goal")
