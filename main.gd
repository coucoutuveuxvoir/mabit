extends Node2D

var egg_scn = preload("res://egg/egg.scn")
var stain_scn = preload("res://stain/stain.scn")
var lastEggTime = 0
const eggSpawnDelay = 1
const egg_margin = 50
var fire_hit = false
var fire_last = 0
# viewport width
var width

func _ready():
	add_user_signal("zob_hit")
	add_user_signal('kill_egg')
	connect("zob_hit", self, "_on_zob_hit")
	connect('kill_egg', self, '_on_kill_egg')
	width = get_tree().get_root().get_rect().size.x
	set_process(true)

func _process(delta):
	lastEggTime += delta
	if lastEggTime > eggSpawnDelay:
		lastEggTime = 0
		spawnEgg()
	get_node("score_label").set_text(str(get_node("/root/global").score))
	get_node("Node2D/ProgressBar").set_value(get_node("zob").sperm_level)

func _on_zob_hit():
	get_node("/root/global").score = 0

func _on_kill_egg(position):
	get_node("snd_player").play("pop")
	var stain = stain_scn.instance()
	add_child(stain)
	stain.set_pos(position)
	get_node("/root/global").score += 1

func spawnEgg():
	var egg = egg_scn.instance()
	add_child(egg)
	egg.set_pos(Vector2(rand_range(egg_margin, width-egg_margin), -20))
	
func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		get_node("/root/global").goto_scene("res://menu/menu.scn")