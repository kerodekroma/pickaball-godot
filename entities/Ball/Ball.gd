extends RigidBody2D

signal ball_touched_ring

func _ready():
	var has_error = connect("body_entered", self, "_on_ball_entered")
	if has_error != 0:
		print("ERROR found in Ball", has_error)

func _on_ball_entered(body):
	if body.is_in_group('basket'):
		emit_signal("ball_touched_ring")
