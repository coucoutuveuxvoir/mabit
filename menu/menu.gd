extends Node2D

func _on_quit_btn_pressed():
	get_tree().quit()


func _on_play_btn_pressed():
	get_node("/root/global").goto_scene("res://main.scn")


func _on_settings_btn_pressed():
	pass
