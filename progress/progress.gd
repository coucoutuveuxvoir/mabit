extends Node2D

var progress
var sprite
var ini_pos
var g

func _ready():
	progress = get_node("progress")
	sprite = get_node("sprite")
	g = get_node("/root/global")
	ini_pos = sprite.get_pos()
	set_process(true)

func set_max_time(time):
	progress.set_max(time)

func _process(delta):
	var val = g.play_time/progress.get_max()
	progress.set_val(g.play_time)
	sprite.set_pos(ini_pos + Vector2(val * progress.get_size().x, 0))