extends Node2D

export var score=1

func _ready():
	get_node("Label").set_text("+"+str(score))