extends Node

class Rect:
	var topLeft := Vector2.ZERO
	var w := 0
	var h := 0

enum ControlState { None, Selecting }

var gameState = ControlState.None
var startRectangle : Vector2 = Vector2.ZERO;
var endRectangle : Vector2 = Vector2.ZERO;

var selectedUnits: Array[int] = []

func isInRectangle(start: Vector2, end: Vector2, point: Vector2):
	var topLeft = Vector2(min(startRectangle.x,endRectangle.x), min(startRectangle.y,endRectangle.y))
	var dimension = (endRectangle - startRectangle).abs();
	return topLeft.x <= point.x and point.x <= (topLeft.x + dimension.x) and topLeft.y <= point.y and point.y <= (topLeft.y + dimension.y) 

@onready var selectionRectangle : ColorRect = %SelectionRectangle
@onready var camera: Camera2D = %myCamera
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
			if selectedUnits.size() > 0:
				print("set task")
				setTask()
				pass
			gameState = ControlState.Selecting
			startRectangle = camera.get_global_mouse_position()
			endRectangle = camera.get_global_mouse_position()
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
			endRectangle = camera.get_global_mouse_position()
			updateRect()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var xDirection = Input.get_axis("ui_left", "ui_right")
	var yDirection = Input.get_axis("ui_up", "ui_down")
	var xOffset = 1 * xDirection if xDirection else 0
	var yOffset = 1 * yDirection if yDirection else 0
	if xOffset != 0 or yOffset != 0:
		var cameraPos = camera.position;
		camera.position += Vector2(xOffset,yOffset)
	pass
	
func doAction():
	print("action done")

func selectUnitsInRegion(start: Vector2, end: Vector2):
	var units = get_tree().get_nodes_in_group("selectable")
	var currSelectedUnits : Array[int] = Array([], TYPE_INT,  &"", null)
	if units != null:
		for unit in units:
			var unitInWorld = unit as Tank
			if(isInRectangle(start,end,unitInWorld.global_position)):
				unitInWorld.toggleDisplayHealthBar(true)
				currSelectedUnits.push_back(unit.get_instance_id())
	selectedUnits = currSelectedUnits
	pass
	
func deselectAll():
	selectedUnits = []
	var units = get_tree().get_nodes_in_group("selectable")
	if units != null:
		for unit in units:
			var unitInWorld = unit as Tank
			unitInWorld.toggleDisplayHealthBar(false)

func setTask():
	for id in selectedUnits:
		var unit = instance_from_id(id) as Tank
		unit.set_task(camera.get_global_mouse_position())
	
	
