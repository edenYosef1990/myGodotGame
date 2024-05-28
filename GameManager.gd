extends Node

class Rect:
	var topLeft := Vector2.ZERO
	var w := 0
	var h := 0

enum ControlState { None, Selecting }

var gameState = ControlState.None
var startRectangle : Vector2 = Vector2.ZERO;
var endRectangle : Vector2 = Vector2.ZERO;

@onready var selectionRectangle : ColorRect = $ColorRect
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func updateRect():
	
	var topLeft = Vector2(min(startRectangle.x,endRectangle.x), min(startRectangle.y,endRectangle.y))
	selectionRectangle.position = topLeft;
	selectionRectangle.size = (endRectangle - startRectangle).abs();
	#selectionRectangle.scale.x = rect.w / 64;
	#selectionRectangle.scale.y = rect.h / 64;
	pass

func _input(event):
	if(event is InputEventMouseButton):
		if event.is_pressed():
			gameState = ControlState.Selecting
			startRectangle = event.global_position
			endRectangle = event.global_position
			updateRect()	
			print("Selecting")
		else:
			gameState = ControlState.None
			startRectangle = Vector2.ZERO
			endRectangle = Vector2.ZERO
			updateRect()
			print("None")
			
	if(event is InputEventMouseMotion):
		if gameState == ControlState.Selecting:
			endRectangle = event.global_position;
			updateRect()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func doAction():
	print("action done")
	
	
