extends Node

class Rect:
	var topLeft := Vector2.ZERO
	var w := 0
	var h := 0

enum ControlState { None, Selecting }

var gameState = ControlState.None
var startRectangle : Vector2 = Vector2.ZERO;
var endRectangle : Vector2 = Vector2.ZERO;

func isInRectangle(start: Vector2, end: Vector2, point: Vector2):
	var topLeft = Vector2(min(startRectangle.x,endRectangle.x), min(startRectangle.y,endRectangle.y))
	var dimension = (endRectangle - startRectangle).abs();
	return topLeft.x <= point.x and point.x <= (topLeft.x + dimension.x) and topLeft.y <= point.y and point.y <= (topLeft.y + dimension.y) 

@onready var selectionRectangle : ColorRect = %SelectionRectangle
@onready var camera: Camera2D = %Camera2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func updateRect():
	
	var topLeft = Vector2(min(startRectangle.x,endRectangle.x), min(startRectangle.y,endRectangle.y))
	selectionRectangle.set_position(topLeft);
	selectionRectangle.size = (endRectangle - startRectangle).abs();
	pass

func _input(event):
	if(event is InputEventMouseButton):
		if event.is_pressed():
			gameState = ControlState.Selecting
			startRectangle = event.position
			endRectangle = event.position
			updateRect()	
		else:
			gameState = ControlState.None
			deselectAll()
			selectUnitsInRegion(startRectangle, endRectangle)
			startRectangle = Vector2.ZERO
			endRectangle = Vector2.ZERO
			updateRect()
			
	if(event is InputEventMouseMotion):
		if gameState == ControlState.Selecting:
			endRectangle = event.position;
			updateRect()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func doAction():
	print("action done")

func selectUnitsInRegion(start: Vector2, end: Vector2):
	var units = get_tree().get_nodes_in_group("selectable")
	if units != null:
		for unit in units:
			var unitInWorld = unit as Tank
			if(isInRectangle(start,end,unitInWorld.global_position)):
				unitInWorld.toggleDisplayHealthBar(true)
				print("boom")
	pass
	
func deselectAll():
	var units = get_tree().get_nodes_in_group("selectable")
	if units != null:
		for unit in units:
			var unitInWorld = unit as Tank
			unitInWorld.toggleDisplayHealthBar(false)
	
	
