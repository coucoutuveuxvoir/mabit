extends Node2D

export var score=1

func _ready():
	get_node("Label").set_text("+"+str(score))
	set_process(true)
	
func _process(delta):
	if (get_opacity() <= 0):
		queue_free()