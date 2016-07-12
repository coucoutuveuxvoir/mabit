extends Node2D

func _on_quit_btn_pressed():
	get_tree().quit()


func _on_play_btn_pressed():
	get_node("/root/global").goto_scene("res://main.scn")


func _on_tutorial_btn_pressed():
	get_node("/root/global").goto_scene("res://tutorial/tutorial.scn")


func _on_score_btn_pressed():
	get_node("/root/global").goto_scene("res://highscores/highscores.scn")
