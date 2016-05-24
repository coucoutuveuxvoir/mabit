extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	get_node("zob").connect("sperm_increase", self, "_on_shake")
	set_step(0)

func _on_shake(level):
	if level > 15:
		set_step(1)

func set_step(n):
	for node in get_tree().get_nodes_in_group("steps"):
		if not node.is_in_group("step"+str(n)):
			node.hide()
		else:
			node.show()