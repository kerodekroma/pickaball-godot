extends RigidBody2D

signal ball_touched_ring

func _ready():
	connect("body_entered", self, "_on_ball_entered")
	
func _on_ball_entered(body):
	if body.is_in_group('basket'):
		emit_signal("ball_touched_ring")
