extends Node

var delta_x = 0
var delta_y = 0
var delta_drag_x = 0
var delta_drag_y = 0
var touch_pos = Vector2()
var area_ent = false
var screen_size = Vector2.ZERO
var initial_sprite_position: Vector2
const MAX_DISTANCE = 150

signal control_released(position)
signal control_is_dragging(position)

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_sprite_position = $Sprite.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_TouchScreenButton_pressed():
	area_ent = true
	$Sprite.scale.y = 2
	$Sprite.scale.x = 2

func _on_TouchScreenButton_released():
	area_ent = false
	$Sprite.scale.y = 1
	$Sprite.scale.x = 1
	$Sprite.position = initial_sprite_position
	emit_signal("control_released", Vector2(delta_drag_x, delta_drag_y))

func _input(event):
	if area_ent == true:
		if event is InputEventScreenTouch and event.is_pressed():
			touch_pos = event.get_position()
			delta_x = touch_pos.x - $Sprite.position.x
			delta_y = touch_pos.y - $Sprite.position.y
			
		if event is InputEventScreenDrag:
			touch_pos = event.get_position()
			delta_drag_x = touch_pos.x - delta_x
			delta_drag_y = touch_pos.y - delta_y
			var force = Vector2(delta_drag_x, delta_drag_y)
			#using clamped limits a vector longitude
			$Sprite.set_position(force.clamped(MAX_DISTANCE))
			emit_signal("control_is_dragging", $Sprite.position)
