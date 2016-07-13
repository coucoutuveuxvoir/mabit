extends Node2D

const NUM_SCORE = 5
var names
var scores
onready var g = get_node("/root/global")

func _ready():
	for i in range(1, NUM_SCORE+1):
		get_node("score_line_"+str(i)).get_node("name").set_text(g.highscore_names[i-1])
		get_node("score_line_"+str(i)).get_node("score").set_text(str(g.highscore_scores[i-1]))


func _on_back_btn_pressed():
	g.goto_scene("res://menu/menu.scn")