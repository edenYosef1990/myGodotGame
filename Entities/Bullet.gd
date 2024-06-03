class_name Bullet
extends Node2D

@export var distance_left : int
@export var speed_delta: Vector2

const bulletPath = preload("res://Entities/Bullet.tscn")

static func new_bullet(start: Vector2, dest: Vector2) -> Bullet:
	var new_bullet : Bullet = bulletPath.instantiate()
	new_bullet.position = start
	new_bullet.rotate((dest-start).angle())
	new_bullet.distance_left = (dest-start).length()
	new_bullet.speed_delta = (dest-start).normalized() * 20
	return new_bullet

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(distance_left <= 0):
		queue_free()
	distance_left -= speed_delta.length()
	position += speed_delta
