extends Node2D

onready var g = get_node("/root/global")
onready var score_label = get_node("score")
onready var name = get_node("name_input")

func _ready():
	score_label.set_text(str(g.score))
	if g.is_highscore():
		for node in get_tree().get_nodes_in_group("highscore"):
			node.show()

func _on_Button_pressed():
	if g.is_highscore():
		g.add_highscore(g.score, name.get_text())
	g.goto_scene("res://menu/menu.scn")