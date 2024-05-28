class_name Tank
 
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var gameMAnager = %GameManager
@onready var healthBar = $HealthBar
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	add_to_group("selectable")
	
func toggleDisplayHealthBar(isVisible: bool):
	healthBar.visible = isVisible;
	

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		gameMAnager.doAction()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var verical_direction = Input.get_axis("ui_up", "ui_down")
	if verical_direction:
		velocity.y = verical_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
