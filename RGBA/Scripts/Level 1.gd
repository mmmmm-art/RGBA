extends Node2D



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

