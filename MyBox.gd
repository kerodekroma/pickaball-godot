extends Sprite


var deltaX
var deltaY
var deltaDragX
var deltaDragY
var touchPos = Vector2()
var areaEnt = false
var screen_size = Vector2.ZERO

export var speed = 400.0
export var GRAVITY = 10 #10 pixels per second

func _ready():
	screen_size = get_viewport_rect().size
	print("screen_size", screen_size.x, screen_size.y)
	
func _on_TouchScreenButton_pressed():
	areaEnt = true

func _on_TouchScreenButton_released():
	areaEnt = false

func _input(event):
	if areaEnt == true:
		if event is InputEventScreenTouch and event.is_pressed():
			touchPos = event.get_position()
			deltaX = touchPos.x - position.x
			deltaY = touchPos.y - position.y
		
		if event is InputEventScreenDrag:
			touchPos = event.get_position()
			deltaDragX = touchPos.x - deltaX
			deltaDragY = touchPos.y - deltaY
			set_position(Vector2(deltaDragX, deltaDragY))

func _process(delta):
	var direction = Vector2.ZERO

	direction.y += GRAVITY * delta;
	position += direction * speed * delta

	position.x = clamp(position.x, 0, screen_size.x - 100)
	position.y = clamp(position.y, 0, screen_size.y - 100)
