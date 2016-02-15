extends KinematicBody2D

const velocity = 200

func _ready():
	set_meta('jizz', true)
	set_process(true)
	
func _process(delta):
	move(Vector2(0, -delta*velocity))
	
	if get_pos().y < 0:
		queue_free()