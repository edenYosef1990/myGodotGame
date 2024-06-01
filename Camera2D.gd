extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if(event is InputEventMouseButton):
		if event.is_pressed():
			print(get_global_mouse_position())
			print(get_local_mouse_position())	
			print(get_viewport().get_mouse_position())
			pass
		else:
			pass
