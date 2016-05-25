extends Node2D

var egg_scn = preload("res://egg/egg.scn")
var current_step = 0
var last_spawn_time = 0
var touched_egg = 0
onready var width = get_tree().get_root().get_rect().size.x
const SPAWN_DELAY = 1
const SPAWN_MARGIN = 50
onready var zob = get_node("zob")
onready var g = get_node("/root/global")

func _ready():
	zob.connect("sperm_increase", self, "_on_shake")
	zob.connect("sperm_decrease", self, "_on_empty")
	g.add_user_signal("kill_egg")
	g.connect("kill_egg", self, "on_egg_touch")
	set_step(0)

func _on_shake(level):
	if level > 10 and current_step == 0:
		set_step(1)
		
func _on_empty(level):
	if level == 0 and current_step == 2:
		set_step(3)

func set_step(n):
	current_step = n
	# Generic hide/show for step items
	for node in get_tree().get_nodes_in_group("steps"):
		if not node.is_in_group("step"+str(n)):
			node.hide()
		else:
			node.show()
	if n == 3:
		set_process(true)
		
func _process(delta):
	last_spawn_time += delta
	if last_spawn_time >= SPAWN_DELAY:
		last_spawn_time = 0
		var instance = egg_scn.instance()
		instance.set_pos(Vector2(rand_range(SPAWN_MARGIN, width-SPAWN_MARGIN), -20))
		add_child(instance)
	if touched_egg > 5:
		set_step(4)
		set_process(false)

func _on_move_sensor_body_enter( body ):
	if current_step == 1:
		set_step(2)

func on_egg_touch(position):
	touched_egg += 1