extends Node2D

const SawScene = preload("res://saw_blade.tscn")

@onready var arrow_sprite: Sprite2D = $Arrow
@onready var timer: Timer = $Timer

var direction = Vector2.RIGHT.rotated(randf_range(0, TAU)) #TAU = PI * 2

func _ready() -> void:
	arrow_sprite.rotation = direction.angle()
	timer.timeout.connect(_on_timer_timeout)
	Events.balloon_popped.connect(timer.stop)
	
	
	
func _on_timer_timeout():
	Events.saw_blade_added.emit()
	var saw = SawScene.instantiate()
	saw.position = position
	saw.linear_velocity = direction * 50
	get_tree().current_scene.add_child(saw)
	queue_free()
	
