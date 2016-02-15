extends Sprite

const lifetime = 5
var duration = 0

func _ready():
	get_node('particles').set_emitting(true)
	set_process(true)

func _process(delta):
	duration += delta
	if duration > 0.1 * lifetime:
		set_opacity((lifetime-duration)/lifetime)
	if duration > lifetime:
		queue_free()
