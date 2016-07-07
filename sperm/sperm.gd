extends KinematicBody2D

const base_velocity = 300
var velocity = 0

func _ready():
	set_meta('jizz', true)
	set_process(true)
	velocity = base_velocity + rand_range(-50, 50)
	
func _process(delta):
	move(Vector2(0, -delta*velocity))
	
	if get_pos().y < 0:
		queue_free()