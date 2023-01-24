extends Node2D

onready var start_position = global_position
onready var target_position = global_position
export(float, 0, 500) var wander_range = 250


func update_target():
	var target_vector = Vector2(rand_range(-wander_range,wander_range), rand_range(-wander_range, wander_range))
	target_position = start_position + target_vector

func _on_Timer_timeout():
	update_target()
	$Timer.start(1)
