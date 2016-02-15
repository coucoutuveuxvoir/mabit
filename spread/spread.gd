
extends Particles2D

const max_lifetime = 1
var lifetime = 0

func _ready():
	set_process(true)

func _process(delta):
	lifetime += delta
	
	if lifetime > max_lifetime:
		queue_free()
