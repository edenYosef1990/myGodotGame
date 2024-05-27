extends Node

class Rect:
	var topLeft := Vector2.ZERO
	var w := 0
	var h := 0

enum ControlState { None, Selecting }

var gameState = ControlState.None
var startRectangle : Vector2 = Vector2.ZERO;

func calculateRec(start: Vector2, curr: Vector2):
	var topLeftX = min(start.x,curr.x)
	var topLeftY = min(start.y, curr.y)
	var w = abs(start.x - curr.x)
	var h = abs(start.y - curr.y)
	var rect = Rect.new()
	rect.topLeft = Vector2(topLeftX,topLeftY)
	rect.w = w;
	rect.h = h;
	return rect;
	pass

@onready var selectionRectangle : Node2D = $SelectionRectangle

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func updateRect(rect: Rect):
	selectionRectangle.position = rect.topLeft + Vector2(32,32)
	pass

func _input(event):
	if(event is InputEventMouseButton):
		if event.is_pressed():
			gameState = ControlState.Selecting
			var rectnagle = Rect.new()
			rectnagle.topLeft = event.position
			startRectangle = event.position
			updateRect(rectnagle)
			
			print("Selecting")
		else:
			gameState = ControlState.None
			var rectnagle = Rect.new()
			updateRect(rectnagle)
			print("None")
			
	if(event is InputEventMouseMotion):
		if gameState == ControlState.Selecting:
			var rectangle = calculateRec(startRectangle, event.position)
			updateRect(rectangle)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func doAction():
	print("action done")
	
	
