extends Area2D

const velocity = 100

func _ready():
	set_process(true)

func _process(delta):
	set_pos(get_pos() + Vector2(0, velocity * delta))

func _on_viagra_body_enter( body ):
	if body.has_meta("zob"):
		catch_bonus()
	if body.has_meta("jizz"):
		body.queue_free()
		catch_bonus()
	if body.has_meta("void"):
		queue_free()

func catch_bonus():
	get_node("/root/world").emit_signal("viagra_hit")
	queue_free()