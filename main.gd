extends Node2D

var egg_scn = preload("res://egg/egg.scn")
var stain_scn = preload("res://stain/stain.scn")
var viagra_scn = preload("res://viagra/viagra.scn")
onready var progress = get_node("progress")
onready var g = get_node("/root/global")
var last_spawn_time = 0
const spawn_delay = 1
const spawn_margin = 50
const max_time = 60
const VIAGRA_BOOST = 100
var fire_hit = false
var fire_last = 0
# viewport width
var width

func _ready():
	progress.set_max_time(max_time)
	add_user_signal("zob_hit")
	add_user_signal('kill_egg')
	add_user_signal("viagra_hit")
	connect("zob_hit", self, "_on_zob_hit")
	connect('kill_egg', self, '_on_kill_egg')
	connect("viagra_hit", self, "_on_viagra_hit")
	width = get_tree().get_root().get_rect().size.x
	get_node("bottom").set_meta("void", true)
	set_process(true)

func _process(delta):
	last_spawn_time += delta
	if last_spawn_time > spawn_delay:
		last_spawn_time = 0
		spawn()
	get_node("score_label").set_text(str(g.score))
	g.play_time += delta
	if (g.play_time >= max_time):
		_on_play_end()

func _on_zob_hit():
	g.score = 0

func _on_kill_egg(position):
	get_node("snd_player").play("pop")
	var stain = stain_scn.instance()
	add_child(stain)
	stain.set_pos(position)
	g.score += 1
	
func _on_viagra_hit():
	get_node("zob").sperm_level += VIAGRA_BOOST

func spawn():
	var r = rand_range(0, 1)
	var instance
	if r > 0.95:
		instance = viagra_scn.instance()
	else:
		instance = egg_scn.instance()
	add_child(instance)
	instance.set_pos(Vector2(rand_range(spawn_margin, width-spawn_margin), -20))
	
func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		g.goto_scene("res://menu/menu.scn")
		
func _on_play_end():
	g.goto_scene("res://menu/menu.scn")