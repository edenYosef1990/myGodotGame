class_name Tank
 
extends Unit

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var gameMAnager = %GameManager
@onready var healthBar = $HealthBar

func _ready():
	if Engine.is_editor_hint():
		print("im in editor")
	add_to_group("selectable")
	
func toggleDisplayHealthBar(isVisible: bool):
	healthBar.visible = isVisible;
	
func set_task(pos: Vector2):
	task.type = Enums.TaskType.Move;
	task.walk_destination = pos;

	
func _physics_process(delta):
	match task.type:
		Enums.TaskType.None:
			pass
		Enums.TaskType.Move:
			var dest = task.walk_destination
			if (dest-position).length() <= 20:
				task.type = Enums.TaskType.None
			velocity = (dest - position).normalized()* 30
			pass
		Enums.TaskType.AttackUnit:
			pass
		Enums.TaskType.AttackPosition:
			pass
	move_and_slide()
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
		#gameMAnager.doAction()
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#
	#var verical_direction = Input.get_axis("ui_up", "ui_down")
	#if verical_direction:
		#velocity.y = verical_direction * SPEED
	#else:
		#velocity.y = move_toward(velocity.y, 0, SPEED)

	pass
