@tool
extends CharacterBody2D


@onready var healthBar = $HealthBar

func _ready():
	if Engine.is_editor_hint():
		healthBar.visible = true
		
