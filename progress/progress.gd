extends Node2D

onready var progress = get_node("progress")
onready var sprite = get_node("sprite")
var ini_pos
onready var g = get_node("/root/global")
onready var label = get_node("timer_label")

func _ready():
	ini_pos = sprite.get_pos()
	set_process(true)

func set_max_time(time):
	progress.set_max(time)

func _process(delta):
	var val = g.play_time/progress.get_max()
	progress.set_val(g.play_time)
	sprite.set_pos(ini_pos + Vector2(val * progress.get_size().x, 0))
	var remaining = progress.get_max() - g.play_time
	label.set_text(str(floor(remaining)))