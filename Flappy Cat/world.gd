extends Node2D

func _on_menu_button_button_up():
	get_tree().change_scene_to_file("res://menu.tscn")
	Global.gameOver = false


func _on_restart_button_button_up():
	get_tree().reload_current_scene()
	Global.gameOver = false
