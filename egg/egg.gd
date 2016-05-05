extends Area2D

const velocity = 100
var rot_speed = 0.01 * sign(rand_range(-1, 1))
var stain_scn = preload('res://stain/stain.scn')

func _ready():
	rotate(rand_range(0, 6.28))
	set_process(true)
	
func _process(delta):
	var pos = get_pos()
	set_pos(Vector2(pos.x, pos.y + delta * velocity))
	rotate(rot_speed)

func _on_egg_body_enter( body ):
	if body.has_meta('zob'):
		get_node('/root/world').emit_signal("zob_hit")
	if body.has_meta("jizz"):
		body.queue_free()
		kill_egg()
	if body.has_meta("void"):
		queue_free()

func kill_egg():
	get_node('/root/world').emit_signal('kill_egg', get_pos())
	queue_free()