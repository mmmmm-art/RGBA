extends Node2D



func _process(delta):
	$CanvasLayer/Red.value = Global.Red
	$CanvasLayer/Green.value = Global.Green
	$CanvasLayer/Blue.value = Global.Blue
	$CanvasLayer/Alpha.value = Global.Alpha


func _on_Red_value_changed(value):
	Global.Red = value
	$CanvasLayer/RedL.text = "Red: " + String(value)


func _on_Green_value_changed(value):
	Global.Green = value
	$CanvasLayer/GreenL.text = "Green: " + String(value)


func _on_Blue_value_changed(value):
	Global.Blue = value
	$CanvasLayer/BlueL.text = "Blue: " + String(value)


func _on_Alpha_value_changed(value):
	Global.Alpha = value
	$CanvasLayer/AlphaL.text = "Alpha: " + String(value)

func kill():
	$AnimationPlayer.play("Game_Over")

func reset():
	Global.dead = false
	get_tree().change_scene("res://Scenes/Level_1.tscn")
	Player.global_position = Vector2.ZERO
	Global.Red = 255
	Global.Green = 255
	Global.Blue = 255
	Global.Alpha = 255
	$CanvasLayer/Red.value = 255
	$CanvasLayer/Green.value = 255
	$CanvasLayer/Blue.value = 255
	$CanvasLayer/Alpha.value = 255
	

